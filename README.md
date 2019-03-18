

### Chart<D>

---

**width | widthPercent**

type: num | num

default(widthPercent): 100

**height | heightPercent**

type: num | num

default: Infinity

**padding | paddingPercent**

type: [EdgeInsets](https://docs.flutter.io/flutter/painting/EdgeInsets-class.html) | [EdgeInsets](https://docs.flutter.io/flutter/painting/EdgeInsets-class.html) 

default(padding): null(auto)

**data**

type: List<D>

**scales**

type: List<Scale>

**coord**

type: Coord

default: RectCoord()

**axes**

type: List<Axis>

**geoms**

type: List<Geoms>

**legend**

type: Legend

**tooltip**

type: Tooltip

default: null (not show)

**guides**

type: List<Guide>



### Scale

---

**field | fieldList**

type: String | List<String>

**formatter**

type: Object => String

**range**

type: ScaleRange

**alias**

type: String

**ticks | tickCount**

type: List<String> | int



### LinearScale : Scale

---

**nice**

type: bool

**min**

type: num

**max**

type: num

**tickInterval**

type: num (contract with tickCount)



### CatScale : Scale

---

**values**

type: List<Object>

**isRounding**

type: bool

default: false



### TimeCatScale : CatScale : LinearScale

---

**mask**

type: String

default: 'YYYY-MM-DD' (contract with formatter)







### Coord

---



### RectCoord : Coord

---

**transposed**

type: bool

default: false



### PolarCoord : Coord

---

**radius**

type: num

default: 1

**innerRadius**

type: num

default: 0

**startAngle**

type: num

default: 0

**endAngle**

type: num

default: 0



### Axis

---

**field | fieldList**

type: String | List<String>

**show**

type: bool

default: true

**position**

type: AxisPosition

default: AxisPosition.bottom for x, AxisPosition.left for y

**line**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 

**labelOffset**

type: num

**grid | gridFunc**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) | GridFunc

**tickLine | tickLineFunc**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) | GridFunc

**label | labelFunc**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) | TextFunc

**top**

type: bool





### Geom

---

**generatePoints**

type: bool

default: false for line, path, true for others

**sortable**

type: bool

default: true for area, line, false for others(if data has been sorted, false will inhence peformance)

**startOnZero**

type: bool

default: true

**position | positionList**

type: String | List<String>

**color**

type: ColorMap

**shape**

type: ShapeMap

**size**

type: SizeMap

**adjust**

TODO

**style | styleFunc**

type:  [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) | (value) => [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 



### Point : Geom

---



### Path : Geom

---



### Line : Geom

---



### Area : Geom

---



### Interval : Geom

----



### Polygon : Geom

---



### Schema : Geom

---



### Guide

---

**top**

type: bool

default: true



### ShapeGuide : Guide

---

**start | startFunc**

type: GuideAnchor | (xScale, yScales) => GuideAnchor

**end | endFunc**

type: GuideAnchor | (xScale, yScales) => GuideAnchor

**style**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 



### LineGuide : ShapeGuide

---



### RectGuide : ShapeGuide

---



### ArcGuide : ShapeGuide

---



### TextGuide : Guide

---

**position | positionFunc**

type: GuideAnchor | (xScale, yScales) => GuideAnchor

**content**

type: String

**style**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**offset**

type: [Offset](https://docs.flutter.io/flutter/dart-ui/Offset-class.html) 

default: Offset(0, 0)



### TagGuide : TextGuide

---

**direct**

type: CoarseDirects

default: null

**size**

type: num

default: 4

**background**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 

**withPoint**

type: bool

**pointStyle**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 



### Legend

---

**dataKey**

type: String

**show**

type: bool

default: true(if dataKey is set, false apply to it, else false apply to all)

**position**

type: CoarsePositions

default: CoarsePositions.top

**align**

type: AlignTypes

default: AlignTypes.start(for top/bottom position), AlignTypes.center(for left/right position)

**itemWidth**

type: num

default: null(auto)

**showTitle**

type: bool

default: false

**titleStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**offset**

type: [Offset](https://docs.flutter.io/flutter/dart-ui/Offset-class.html) 

default: Offset(0, 0)

**titleGap**

type: num

default: 12

**itemGap**

type: num

default: 12

**itemMarginBottom**

type: num

default: 12

**wordSpace**

type: num

default: 6(marker 与 word之间)

**unCheckColor**

type:  [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) 

**itemFormatter**

type: String => String

**marker**

type: Shape TODO

**nameStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**valueStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**triggerOn**

TODO

**clickable**

type: bool

default: true

**onClick**

type: ev => void

**custom**

type: bool

default: false

**items**

type: List<LegendItem> (when custom is true)



### ToolTip

---

**offset**

type: [Offset](https://docs.flutter.io/flutter/dart-ui/Offset-class.html) 

default: Offset(0, 0)

**triggerOn**

type: TouchEvent TODO

**triggerOff**

type: TouchEvent TODO

**showTitle**

type: bool

default: false

**showCrosshairs**

type: bool

**crosshairsStyle**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 

**showTooltipMarker**

type: bool

**background**

type: [Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) 

**titleStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**nameStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**valueStyle**

type: [TextStyle](https://docs.flutter.io/flutter/dart-ui/TextStyle-class.html) 

**showItemMarker**

type: bool

**itemMarkerStyle**

type: Shape

**onShow**

type: (x,y,title,items,chart) => void

**onHide**

type: (x,y,title,items,chart) => void

**onChange**

type: (x,y,title,items,chart) => void





### ScaleRange

---

**min**

type: num

default: 0.0

**max**

type: num

default: 1.0



### Attr

---

**field | fieldList**

type: String | List<String>

**valueList | value | valueFunc**

type: List<V> | V | (datum) => V



### Position : Attr

---



### Color : Attr

---

**colorList | color | colorFunc | Gradient**

type: List\<[Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html)\> | [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) | (value) => [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) | [Gradient](https://docs.flutter.io/flutter/painting/Gradient-class.html) 



### Shape : Attr

---

**shapeList | shape | ShapeFunc**

type: List<Shape> | Shape | (value) => Shape



### Size : Attr

---

**min**

type: num

default: 0

**max**

type: num

default: 10

**size | sizeFunc**

type: num | (value) => num

default: null, if not null, max and min are invalid



### GuideAnchor

---

**xValue | xPercent | xFeature**

type: D | num | statsFeatures



### Type Enums

---

**AxisPosition**

top

right

bottom

left



**CoarseDirect**

topLeft

top

topRight

right

bottomRight

bottom

bottomLeft

Left





**AlignType**

start

center

end



**StatsFeature**

max

min

median



### Functions

---

**GridFunc**

[Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) Function(String text, int index, int count)