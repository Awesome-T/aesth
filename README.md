Chart

- size  Size infinit
- data  Object(JSON string, Map, List)  null
- defs  Object(Map, List)  null
- padding  List  null
- coord  Coord
- axes  List<Axis>
- geoms  List<Geoms>
- legends  List<Legend>
- tooltips  List<Tooltips>
- guides  List<Guide>



Coord

- type String (rect | polar)  rect
- transposed  bool  false
- radius  num  
- innerRadius  num
- startAngle  num
- endAngle  num



Axis

- dataKey  String
- show  bool
- position  String(top | bottom | left | right)
- line  Paint
- labelOffset
- grid  Paint
- tickLine  Paint
- label  TextStyle
- top  bool



Geom

- type  String(point | path | line | area | interval | polygon | schema)
- generatePoints  bool
- sortable  bool
- startOnZero  bool
- position  String
- color  Object
- shape  Object
- size  Object
- adjust  Object
- style  Object