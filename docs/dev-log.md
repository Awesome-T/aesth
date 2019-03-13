先不涉及地图、webgl，动画、交互后做



API需求场景

1.静态数据，初始化时配置，永不重绘

2.一次异步获取，第一次获取到后绘制，请求数据更新后仅重绘数据

3.事件触发设置元素行为



API设计参考f2, bizgoblin

添加f2，bizgoblin协议



Canvas绘图属性用Paint和TextStyle类

需要处理 5 | ‘100%’ | 'auto' 和 5 | [5, 10]类型的输入

以google/chart 0.6.0为基础

1. 将charts_common与charts_flutter中的基础类整体迁移，charts_common移至lib/src/common

common代码改动

lib\src\common\cartesian\cartesian_chart.dart中makeDefaultRenderer需要一个可实例化的SeriesRenderer，先返回null，以便取消对BarRenderer的依赖