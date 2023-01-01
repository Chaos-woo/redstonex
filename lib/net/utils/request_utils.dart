class RequestData {
  final Map<String, dynamic> _params = {};
  final Map<String, dynamic> _header = {};
  dynamic _data;

  void param(String key, dynamic val) {
    _params[key] = val;
  }

  void header(String key, dynamic val) {
    _header[key] = val;
  }

  void dynamicData(dynamic data) {
    _data = data;
  }

  Map<String, dynamic>? get params => _params.isEmpty ? null : _params;

  Map<String, dynamic>? get headers => _header.isEmpty ? null : _header;

  dynamic get data => _data;
}
