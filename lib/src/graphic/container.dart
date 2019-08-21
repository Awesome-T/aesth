import './element.dart' show Element;
import './group.dart' show Group;

Comparator<Element> getComparer(Comparator<Element> compare) =>
  (left, right) {
    final result = compare(left, right);
    return result == 0 ? left.index - right.index : result;
  };

mixin Container on Group {
  bool contain(Element item) {
    final children = this.children;
    return children.contains(item);
  }

  Element sort() {
    final children = this.children;
    for (var i = 0; i < children.length; i++) {
      children[i].index = i;
    }

    children.sort(getComparer(
      (obj1, obj2) => obj1.zIndex - obj2.zIndex
    ));

    return this;
  }

  Element clear() {
    final children = this.children;

    while (children.length != 0) {
      children[children.length - 1].remove(true);
    }
    return this;
  }

  Element add(List<Element> items) {
    final children = this.children;
  }

  void _setEvn(Element item) {

  }
}