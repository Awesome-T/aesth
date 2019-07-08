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



TODO

typedef统一添加

所有默认值统一添加

所有num, int, double的细化

