先不涉及地图、webgl，动画、交互后做

---

**API**

API需求场景

1.静态数据，初始化时配置，永不重绘

2.一次异步获取，第一次获取到后绘制，请求数据更新后仅重绘数据

3.事件触发设置元素行为



API设计参考f2, bizgoblin

添加f2，bizgoblin协议 添加vector_math协议







需要处理 5 | ‘100%’ | 'auto' 和 5 | [5, 10]联合类型的输入

联合类型可采用副命名参数的方式，主名字给最常用的类型，其它的给跟上类型的副名字，逻辑添加优先级，默认值配给优先级最低的那个

优先级设计的原则是 1罕见优先常用， 2精细优先笼统，3具体值优先定性值（num -> percent -> type）

复杂情况优先使用Dart功能，比如padding设置edgeInsets

类型用枚举



scale通过chart.defs属性设置



所有的视图元素都作为对象添加到List中，通过内部的id进行关联，coord目前只有一个，List的顺序可以标注渲染顺序



颜色渐变怎么搞？目前先用Color

字段确定是数组的，以复数表示，拆分元素和数组联合类型的，用单数和XXList区分



axis是x还是y，取决于该axis挂给的field

一个field是x还是y，取决于它在geom的position的\*前后，

x上只会显示第一个geom的xfield的坐标轴

y上只会显示前两个（重复顺延）geom的yfield的坐标轴

axis是与field映射的，一个field只能有一个axis



Guide的位置是相对于coord的，因此GuideAnchor的点指的是coord上的点，与geom无关，x,y轴与scale都取第一个



元素采用继承模式，命名是小类型加大类型，Geom省略大类型



各种设置需要'auto'的将null定位auto，0值手动设置



f2可设置动画，biz不可以



目前tooltip只有一个，legend好像是与attr绑定的，先不管



data必须用泛型类型，因为数据项里每个字段value会不一样



axis，scale，attr等，以list的形式传入，方便拓展，关联字段为field或fieldList，所有field可用\*传入多个，基类命名为FieldAttachable

涉及api的函数类型定义用typedef，参数加名字



data 的泛型称为Datum(D)，Datum 中的项的类型称为Field(F)



timeCat是离散的时间，连续时间用time（先不做），

timeCat可接受三种类型的值，int(TimeStamp), String(必须符合mask)，DateTime



用户可定制的才会直接传入实例，比如回调函数，指明内置类型的，用XXXMode枚举进行设置

需要传入参数的需要用实例



枚举类型尽量就近定义专属的，复用没有必要也不便拓展

---

Canvas绘图属性用Paint和TextStyle类



以google/chart 0.6.0为基础

1. 将charts_common与charts_flutter中的基础类整体迁移，charts_common移至lib/src/common

common代码改动

lib\src\common\cartesian\cartesian_chart.dart中makeDefaultRenderer需要一个可实例化的SeriesRenderer，先返回null，以便取消对BarRenderer的依赖

flutter代码改动

lib\src\chart\chart_container.dart中的reconfigure不做TimeSeriesChart的判断，先返回null



---

改动计划

1.将BaseChart改名为Chart，将配置添加到命名参数中



跨src下的一级目录了就用package:

文件名尽量以类名



1.完成graphic图形引擎，确定shape的类型

实现基于charts，抽象的概念借鉴f2，从两者连接的概念入手，先对common进行连接概念的改造

目前看最大的连接就是canvas，先尝试实现graphic/shape



vector2使用vector_math 64版的

matrix继承vector_math的vector

所有操作遵循vector_math直接在原对象上操作的模式



贝塞尔在Path类中有相关的

BBox bbox

Vector2采用完全拷贝的形式，否则难以处理运算符的返回值类型

按照f2重写direction, angle和angleTo



贝塞尔曲线，smooth方法创建穿过所有点的三阶贝塞尔曲线，获取的sp对象是为方便canvas的bezierCurveTo方法使用

bbox使用自己写的贝塞尔函数，smooth中直接用Path类中的方法



**注意所有坐标系y轴是向下的**，math.Rectangle也是如此，top是最小值



所有this不需要改成self，函数内定义成员的简写是可以的



**scale**

仅写f2中用到的

成员初始化的原则是：构造函数仅暴露Api需要的，构造函数中有的在构造函数中初始化，没有的在定义时初始化，表征类特性的如type设为final

凡是f2用了util.each的，要用?.处理null情况

field只有一个

cat类型原则上都是String，timeCat是特殊的string，但为兼容timeCat直接传time的情况，他们的values和ticks都为泛型F

因为scale本身是工具库，它其中的工具方法translate, scale, getText, invert保留联合类型的参数

translate反查的优先级，先按timestamp 再按index再按string

getText除了兼容F，还要可直传index，故类型为Object

不可以动态的改变scale的F的类型，cat中values保留F类型而不会转换为String

ticks是与values同类型

time-cat内部处理用TimeStemp，用intel.DateFormatter进行字符串的转换

对field的解析根据mask，默认'yyyy-MM-DD'，显示结果有formatter就用formatter，否则用mask，注意intl的patten规则和js不一样

change为满足重载要求，传参采用Map<String, Object>



**attr**

valueFunc改名为callback

属性叫values

一个attr对应多个field（存在fields中），因此可能存在多个F，不好统一，它的scales中的F也可能各不一样

对于对应单独scale的方法，还是可以定义方法自己的F的

所有bool初始不能为null，防止错误

linear 不通过构造函数设置

当不设置callback时，默认的callback只接受params[0]，callback既可以返回value，也可以返回values数组

当没有设置values时，设为[value]

color values是离散的，如线性的设置linear为true，如需复杂的渐变规则从gradient传入

color values不能为string，linear需手动设置



mapping 函数仅有posion中有，

attr中的mapping，传入传出都是List<Object>,仅做抽象处理

postion的mapping，传出限制也为List<Object>, 目前其规则是数组的那个都有，不是数组的那个，如果都不一样是数组，只要出现一样的就不是数组



## graphic

element中所有\_attrs变成类成员，\_attrs.attrs 变为Paint 对象

感觉f2中的clip是一个element对象，回头再说



在flutter中，canvas和paint是分离的，不能像js一样直接从context获取所有信息

包装一个Context类，继承自canvas，基本起到持有paint的功能，不求全部和js canvas一样

设置一个新类dulPaint分别持有stroke和fill的样式

路径编辑用一个内部的path变量进行编辑

js的局限性：不能画椭圆oval

arc不会重置笔触，rect会重置到原点

Path2D就用Path，给stroke和fill添加上对应的可选参数

没有globalAlpha属性

不能画虚线

渐变通过shader属性来确定，需要gradient.createShader(rect)

shader会覆盖color

这里简化一下，fillStyle和strokeStyle传入shader或者Color, shader 包含了gradient和pattern两种情况

阴影好像比较麻烦,先不弄阴影



简化版，只起到保留状态，restore、save的作用，它们保存在栈中，getter是获取栈顶的状态

哪些作为状态：paint, style, 

只保留paint、textStyle,

因为用类什么的完全无法模拟出save、restore，所以干脆不用了

在f2中，只有Element.draw前后会用到save和restore，其目的是保证此次绘图不影响前后绘图

在本项目中，改为contex中不保留有pait的栈每次绘图前reset context



不需要context，只要canvas就行了，paint, textStyel，path等作为shape的属性

clip本质上是一个shape

没有globalAapha，自己通过颜色设置

为简化代码，graphic中所有不是final，且不影响构造函数的字段，不再放到构造函数中

xxContext都改为xxCanvas

因为样式与canvas是独立的，不需要resectContext方法，

不需要parseStyle去解析渐变，渐变通过paint的shader属性处理

paint提到element类中，以实现hasFill 和hasStroke

既有bbox字段，也有getBBox方法



实际的drawInner方法好像很简单



在f2的graphic中，canvas是htmlcanvas的替身，container纯粹为提供一些方法混入canvas中

先不做自定义图形，不引入addShape方法，也不做addGroup方法，仅有add方法

dart里的sort等于0时也顺序不一定，需要特殊处理，Element添加自动index方便排序

add方法只允许传list

Element中js的canvas、context到底需不需处理？

group中的drawinner不需要返回值



Matrix的multiple改为有返回值不改变原值的

js中的三角函数算的略微不准，pi/4的两个值不相等



f2 中 element的用于moveTo的x,y是\_attrs.x，而各种shapes中x，y是\_attrs.attrs.x，element中的改名为originX, originY



path不统一初始化，在遇到ctx.beginPath的时候初始化

custom先不做，可以通过继承shape的方式自定义



sector绘制时，先不单独处理r0=0的情况



text的span完全可设置



由于path本身有生成rect包含框的方法，所以尝试移除BBox定义，使用Rect、path本身的方法，对应字段仍叫bbox，注意两个b同时大小写，

chart/plot 好像也是没有必要的，用Rect代替

path还是要在createPath方法里new的，因为防止多次调用，理论上来讲允许bbox为null



对于点和框，为保持和Path一致，一律使用ui包的Rect和Offset，而不用math包的Rectangle和Point

只有在涉及mathmatic转换时，用vector2（目前还有smooth中也用）

> 在google/charts中，在common中，完全没有引入dart:ui库，因此使用Rectangle和Point，在flutter中用的比较乱。而fl_charts中则统一用Rect和Offset



shapes没有按照f2的方法测试的必要



f2接口测试

图表没有title

数据点上的标签通过guide或直接addShape添加，缺点是是通过数据换算确定position，而不是与标签挂钩，遇到stack等情况比较麻烦

当要双轴时，不同轴要对应到不同的field

目前x轴只能一个bottom

当数据量大时需要横向滑动时，需设置chart.interaction('pan');    scrollBar只起到辅助作用可有可无，linear通过min，max指定显示范围；cat、timeCat通过values指定范围

渐变色可用rgba，但注意不能有空格

多个柱状图同时显示的关系分为堆叠stack和避让dodge

纵横坐标翻转通过chart.coord({transposed: true})设置

瀑布图：echarts是通过在下方堆叠透明的柱子实现；而f2是通过对应field为数组实现的

极坐标系的radius和innerRadius都是0-1的相对值

饼图与南丁格尔图：南丁格尔图就是比较标准的position中x(angle)是类别，y(radius)是值，而饼图是x是常量，y是值，然后堆叠，并翻转坐标系

技巧：由于取field时是用的[]运算符，所以数据项可以为数组，然后attr通过"0*1"确定



google/charts和fl_charts

fl_charts的数据与样式杂糅在一起比较复杂，不好

google/charts的方案不错，需传入行与列的相关回调

采取最简化的方案，数据格式一律为List<Map<String, Object>>的方式，

```
[
  {'field1': value1, 'field2': value2},
]
```

便于将Map中的String类型的key与图形语法中的field关联



adjust

adjust传入的参数dataArray在定义上为Object，但内部会通过as对其判断，必须是可进行adjust的（num, [num]),否则抛出异常

@antv/adust中采用mixin的意义是只有调用index时才会mixin，而f2中并没有走index，因此是没有mixin的，其测试见f2

由于processAdjust中stack会将传入的dataArray的值从num变成[num]，而你是无法确保传入的对应类型是Object的，故要拷贝一下，为防止int double等问题，全部手动深拷贝

用强制规定类型然后addAll浅拷贝的方法，不能扩展里面引用元素的类型

由于datum这一Map其中包含的不同field类型可能不同，不一定都和adjust的目标field一样是num或[num]，故processAdjust的结果类型和输入一样为List<List<Map<String, Object>>>，对应field如需用到num或[num]特性，使用时用as