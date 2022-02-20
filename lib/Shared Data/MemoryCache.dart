// ignore_for_file: file_names

class MemoryCache {
  Map<String, dynamic> data = <String, dynamic>{};

  MemoryCache._privateConstructor();
  static final MemoryCache _instance = MemoryCache._privateConstructor();
  factory MemoryCache() {
    return _instance;
  }

  void setData(String key, dynamic value) {
    data[key] = value;
  }

  void removeData(String key) {
    data.remove(key);
  }

  void clear() {
    data = <String, dynamic>{};
  }

  bool hasData(String key) {
    return data.containsKey(key);
  }

  dynamic getData(String key) {
    return data[key];
  }
}
