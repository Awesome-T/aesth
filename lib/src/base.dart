
class GraphicOperator {
  static const cross = '*';
  static const nest = '/';
  static const blend = '+';

  static const exp = '^';
  static const dotCross = '.';
}

abstract class FieldAttachable {
  FieldAttachable({String field, List<String> fieldList})
    : fields = (field != null)
      ? field.split(GraphicOperator.cross)
      : fieldList;

  set field(String field) => fields = field.split(GraphicOperator.cross);

  set fieldList(List<String> fieldList) => fields = fieldList;

  List<String> fields;
}
