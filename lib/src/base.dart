import 'package:aesth/src/util/common.dart' show mix;

/// Cfg type: Map<String, Object>. 

abstract class Base {
  Base(Map<String, Object> cfg) {
    final attrs = <String, Object>{};
    final defaultCfg = this.getDefaultCfg();
    this._attrs = attrs;
    mix([attrs, defaultCfg, cfg]);
  }

  Map<String, Object> _attrs;
  bool destroyed;

  Map<String, Object> getDefaultCfg() => <String, Object>{};

  get(String name) => this._attrs[name];

  set(String name, Object value) {
    this._attrs[name] = value;
  }

  void destroy() {
    this._attrs = <String, Object>{};
    this.destroyed = true;
  }
}
