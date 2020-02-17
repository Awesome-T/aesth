*types.ts*

## LooseObject

string 到 any 构成的键值对接口

## BBox

x: number

y: number

minX: number

minY: number

maxX: number

maxY: number

width: number

height: number

## Point

x: number;

y: number;

## ColorType

string

## ShapeAttrs

除以下成员外，还可添加其他键值对

x?: number

y?: number

r?: number

stroke?: ColorType

strokeOpacity?: number

fill?: ColorType

fillOpacity?: number

lineWidth?: number

path?: string | object[]

points?: object[]

# ElementCfg

id?: string    元素 id,可以为空

zIndex?: number    层次索引，决定绘制的先后顺序

visible?: boolean    是否可见

capture?: boolean    是否可以拾取

# ShapeCfg

包括 [ElementCfg](#ElementCfg) 所有属性

attrs: ShapeAttrs    图形的属性

# GroupCfg

string: any 的键值对

# ClipCfg

type: string    作为 clip 的图形

attrs: ShapeAttrs    图形的属性

# Renderer

'canvas' | 'svg'

# Cursor

鼠标指针类型

# CanvasCfg

除以下属性外，还可包含其它键值对属性

container: string | HTMLElement    容器

width: number    画布宽度

height: number    画布高度

capture?: boolean    是否可监听

renderer?: Renderer    只读属性，渲染引擎

cursor?: Cursor    画布的 cursor 样式

# ChangeType

'changeSize' | 'add' | 'sort' | 'clear' | 'attr' | 'show' | 'hide' | 'zIndex' | 'remove' | 'matrix' | 'clip';

# AnimateCfg

duration: number    动画执行时间

easing?: string    动画缓动效果

delay?: number    动画执行的延迟时间

repeat?: boolean    是否重复执行动画

callback?: () => void    动画执行完时的回调函数

pauseCallback?: () => void    动画暂停时的回调函数

resumeCallback?: () => void    动画恢复(重新唤醒)时的回调函数

# OnFrame

(ratio: number) => ElementAttrs

# Animation

除 [AnimateCfg](#AnimateCfg) 所有属性之外还有

id: string

fromAttrs: 键值对

toAttrs: 键值对

startTime: number

pathFormatted: boolean

onFrame?: OnFrame

_paused?: boolean

_pauseTime?: number

# ShapeBase

字符串与 ICtor<IShape> 的键值对

# ElementFilterFn

(IElement) => boolean

# PathCommand

一个表示类型的字母与一串数字组成的 tuple









*interfaces.ts*

# ICtor<T>

构造函数类型为 (cfg: any): T

# IObservable

可以绑定事件的接口

on(eventName: string, callback: Function)    绑定事件

off()    移除事件

off(eventName: string)    移除事件

off(eventName: string, callback: Function)    移除事件

emit(eventName: string, eventObject: object)    触发事件, trigger 的别名函数

getEvents(): any

# IBase extends IObservable

所有图形类公共的接口，提供 get,set 方法

get(name: string): any    获取属性值

set(name: string, value: any)    设置属性值

destroyed: boolean    是否销毁

destroy()    销毁对象

# IElement extends IBase

图形元素的基类

getParent(): IContainer    获取父元素, 父元素一般是 Group 或者是 Canvas

getCanvas(): ICanvas    获取所属的 Canvas

getShapeBase(): ShapeBase    获取 Shape 的基类, 返回 Shape 的基类，用作工厂方法来获取类实例

getGroupBase(): ICtor<IGroup>    获取 Group 的基类，用于添加默认的 Group

onCanvasChange(changeType: ChangeType)    当引擎画布变化时，可以调用这个方法，告知 canvas 图形属性发生了改变，这个方法一般不要直接调用，在实现 element 的继承类时可以复写

isGroup(): boolean    是否是分组

remove(destroy?: boolean)    从父元素中移除

attr()    获取全量的图形属性

attr(name: string): any    获取图形属性

attr(name: string, value: any)    设置图形属性

attr(attrs: object)    设置图形属性

getBBox()    获取包围盒，这个包围盒是相对于图形元素自己，不会计算 matrix

getCanvasBBox(): BBox    获取图形元素相对画布的包围盒，会计算从顶层到当前的 matrix

clone(): IElement    复制对象

show()    显示

hide()    隐藏

setZIndex(zIndex: number)    设置 zIndex

toFront()    最前面

toBack()    最后面

resetMatrix()    清除掉所有平移、旋转和缩放

getMatrix(): number[]    获取 transform 后的矩阵

setMatrix(m: number[])    设置 transform 的矩阵

applyToMatrix(v: number[])    将向量应用设置的矩阵

invertFromMatrix(v: number[])    根据设置的矩阵，将向量转换相对于图形/分组的位置

isAnimatePaused()    是否处于动画暂停状态

animate(toAttrs: ElementAttrs, duration: number, easing?: string, callback?: Function, delay?: number)    执行动画

animate(onFrame: OnFrame, duration: number, easing?: string, callback?: Function, delay?: number)    执行动画

animate(toAttrs, cfg: AnimateCfg)    执行动画

animate(onFrame, cfg: AnimateCfg)    执行动画

stopAnimate(toEnd?: boolean)    停止图形的动画

pauseAnimate()    暂停图形的动画

resumeAnimate()    恢复暂停的动画

setClip(clipCfg: ClipCfg)    设置 clip ，会在内部转换成对应的图形

getClip(): IShape    获取 clip ，clip 对象是一个 Shape

isClipped(refX: number, refY: number): boolean    指定的点是否被裁剪掉

emitDelegation(type: string, eventObj: GraphEvent): void    触发委托事件

translate(translateX: number, translateY?: number): IElement    移动元素

move(targetX: number, targetY: number): IElement    移动元素到目标位置

moveTo(targetX: number, targetY: number): IElement    移动元素到目标位置，等价于 move 方法。由于 moveTo 的语义性更强，因此在文档中推荐使用 moveTo 方法

scale(ratio: number): IElement    缩放元素

scale(ratioX: number, ratioY: number): IElement    缩放元素

rotate(radian: number): IElement    以画布左上角 (0, 0) 为中心旋转元素

rotateAtStart(rotate: number): IElement    以起始点为中心旋转元素

rotateAtPoint(x: number, y: number, rotate: number): IElement    以任意点 (x, y) 为中心旋转元素

# IContainer extends IElement

addShape(cfg: ShapeCfg): IShape    添加图形

addShape(type: string, cfg: ShapeCfg): IShape    添加图形

isCanvas()    容器是否是 Canvas 画布

addGroup(): IGroup    添加图形分组，增加一个默认的 Group

addGroup(cfg: GroupCfg): IGroup    添加图形分组，并设置配置项

addGroup(classConstructor: IGroup, cfg: GroupCfg): IGroup    添加图形分组，指定类型

getShape(x: number, y: number): IShape    根据 x,y 获取对应的图形

add(element: IElement)    添加图形元素，已经在外面构造好的类

getParent(): IContainer    获取父元素

getChildren(): IElement[]    获取所有的子元素

sort()    子元素按照 zIndex 进行排序

clear()    清理所有的子元素

getFirst(): IElement    获取第一个子元素

getLast(): IElement    获取最后一个子元素

getChildByIndex(index: number): IElement    根据索引获取子元素

getCount(): number    子元素的数量

contain(element: IElement): boolean    是否包含对应元素

removeChild(element: IElement, destroy?: boolean)    移除对应子元素

findAll(fn: ElementFilterFn): IElement[]    查找所有匹配的元素

find(fn: ElementFilterFn): IElement    查找元素，找到第一个返回

findById(id: string): IElement    根据 ID 查找元素

findAllByName(name: string): IElement[]    根据 name 查找元素列表

# IGroup extends IContainer

isEntityGroup(): boolean    是否是实体分组，即对应实际的渲染元素

# IShape extends IElement

isHit(x: number, y: number): boolean    图形拾取

isClipShape(): boolean    是否用于 clip, 默认为 false

# ICanvas extends IContainer

getRenderer(): Renderer    获取当前的渲染引擎

getParent(): IContainer    为了兼容持续向上查找 parent

getCursor(): Cursor    获取画布的 cursor 样式

setCursor(cursor: Cursor)    设置画布的 cursor 样式

changeSize(width: number, height: number)    改变画布大小

getPointByClient(clientX: number, clientY: number): Point    将窗口坐标转变成 canvas 坐标

getClientByPoint(x: number, y: number): Point    将 canvas 坐标转换成窗口坐标

draw()    绘制









*animate/timelines.ts*

# Timeline

canvas: ICanvas    画布

animators: IElement[] = []    执行动画的元素列表

current: number = 0    当前时间

timer: d3Timer.Timer = null    定时器

constructor(canvas: ICanvas)    时间轴构造函数，依赖于画布

initTimer()    初始化定时器

addAnimator(shape)    增加动画元素

removeAnimator(index)    移除动画元素

isAnimating()    是否有动画在执行

stop()    停止定时器

stopAllAnimations(toEnd = true)    停止时间轴上所有元素的动画，并置空动画元素列表,  toEnd 是否到动画的最终状态，用来透传给动画元素的 stopAnimate 方法

getTime()    获取当前时间









*event/graph-event.ts*

# GraphEvent

type: string    事件类型

name: string    事件名称

x: number    画布上的位置 x

y: number    画布上的位置 y

clientX: number    窗口上的位置 x

clientY: number    窗口上的位置 y

bubbles: boolean = true    是否允许冒泡

target: LooseObject = null    触发对象

currentTarget: LooseObject = null    监听对象

delegateTarget: LooseObject = null    委托对象

delegateObject: object = null    委托事件监听对象的代理对象，即 ev.delegateObject = ev.currentTarget.get('delegateObject')

defaultPrevented: boolean = false    是否阻止了原生事件

propagationStopped: boolean = false    是否阻止传播（向上冒泡）

shape: IShape = null    触发事件的图形

fromShape: IShape = null    开始触发事件的图形

toShape: IShape = null    事件结束时的触发图形

timeStamp: number    触发时的时间

originalEvent: Event    触发时的对象

propagationPath: any[] = []    触发事件的路径

constructor(type, event)

preventDefault()    阻止浏览器默认的行为

stopPropagation()    阻止冒泡

toString()

save()

restore()









*event/event-controller.ts*

# EventController

canvas: ICanvas    画布容器

draggingShape: IShape = null    正在被拖拽的图形

dragging: boolean = false

currentShape: IShape = null    当前鼠标/touch所在位置的图形

mousedownShape: IShape = null

mousedownPoint = null

mousedownTimeStamp

constructor(cfg)

init()

_bindEvents()    注册事件

_clearEvents()    清理事件

_getEventObj(type, event, point, target, fromShape, toShape): GraphEvent

_eventCallback(ev)    统一处理所有的回调

_getShapeByPoint(point): IShape    根据点获取图形，提取成独立方法，便于后续优化

_getPointInfo(ev)    获取事件的当前点的信息

_triggerEvent(type, ev)    触发事件

_onDocumentMove(ev: Event)    在 document 处理拖拽到画布外的事件，处理从图形上移除画布未被捕捉的问题

_onDocumentMouseUp(ev)    在 document 上处理拖拽到外面，释放鼠标时触发 dragend

_onmousedown(pointInfo, shape, event)    记录下点击的位置、图形，便于拖拽事件、click 事件的判定

_emitMouseoverEvents(event, pointInfo, fromShape, toShape)    mouseleave 和 mouseenter 都是成对存在的; mouseenter 和 mouseover 同时触发

_emitDragoverEvents(event, pointInfo, fromShape, toShape, isCanvasEmit)    dragover 不等同于 mouseover，而等同于 mousemove

_afterDrag(draggingShape, pointInfo, event)    drag 完成后，需要做一些清理工作

_onmouseup(pointInfo, shape, event)    按键抬起时，会终止拖拽、触发点击

_ondragover(pointInfo, shape, event)    当触发浏览器的 dragover 事件时，不会再触发mousemove ，所以这时候的 dragenter, dragleave 事件需要重新处理

_onmousemove(pointInfo, shape, event)    大量的图形事件，都通过 mousemove 模拟

_emitEvent(type, event, pointInfo, shape, fromShape?, toShape?)    触发事件

destroy()









*abstract/base.ts*

# Base extends EventEmitter implements IBase

cfg: object    内部属性，用于 get,set

destroyed: boolean = false    是否被销毁

getDefaultCfg()    默认的配置项

constructor(cfg)

get(name)    实现接口的方法

set(name, value)    实现接口的方法

destroy()    实现接口的方法

