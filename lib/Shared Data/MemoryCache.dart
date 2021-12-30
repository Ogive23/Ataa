class MemoryCache {
  Map<String, dynamic> data = new Map<String, dynamic>();

  MemoryCache._privateConstructor();
  static final MemoryCache _instance = MemoryCache._privateConstructor();
  factory MemoryCache() {
    return _instance;
  }

  void setData(String key, dynamic value) {
    this.data[key] = value;
  }

  void removeData(String key) {
    this.data.remove(key);
  }

  void clear() {
    this.data = new Map<String, dynamic>();
  }

  bool hasData(String key) {
    return this.data.containsKey(key);
  }

  Map<String, dynamic> getData(String key) {
    return this.data[key];
  }
}
