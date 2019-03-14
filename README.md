

### Chart

---

**width | widthPercent**

type: num | num

default(widthPercent): 100

**height | heightPercent**

type: num | num

default: Infinity

**padding | paddingPercent | paddingType**

type: [EdgeInsets](https://docs.flutter.io/flutter/painting/EdgeInsets-class.html) | [EdgeInsets](https://docs.flutter.io/flutter/painting/EdgeInsets-class.html) | PaddingType

default(paddingType): PaddingType.auto 

**data**

type: Array

**defs**

type: Map<String, Scale>

**coord**

type: Coord

**axes**

type: List<Axis>

**geoms**

type: List<Geoms>

**legends**

type: List<Legend>

**tooltips**

type: List<Tooltips>

**guides**

type: List<Guide>



### Coord

---

**type**

type: CoordType

default: CoordType.rect

**reansposed**

type: bool

default: false

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

**dataKey**

type: String

**show**

type: bool

default: true

**position**

type: Position

default: Psition.bottom for x, Position.left for y

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

**type**

type: GeomType

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



### LineGuide

---

**top**

type: bool

default: true

**start**





### ColorMap

---

**field**

type: String

**colorList | color | colorFunc | Gradient**

type: List\<[Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html)\> | [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) | (value) => [Color](https://docs.flutter.io/flutter/dart-ui/Color-class.html) | [Gradient](https://docs.flutter.io/flutter/painting/Gradient-class.html) 



### ShapeMap

---

**field**

type: String

**shapeList | shape | ShapeFunc**

type: List<Shape> | Shape | (value) => Shape



### SizeMap

---

**field**

type: String

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

**x | xPercent | 



### Type Emuns

---

**PaddingType**

auto



**CoordType**

rect

polar



**Position**

top

right

bottom

left



**GeomType**

point

path

line

area

interval

polygon

schema



### Functions

---

**GridFunc**

[Paint](https://docs.flutter.io/flutter/dart-ui/Paint-class.html) Function(String text, int index, int count)