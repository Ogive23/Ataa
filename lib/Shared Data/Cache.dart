class Cache {
  Map<String, dynamic> data = new Map<String, dynamic>();

  Cache._privateConstructor();
  static final Cache _instance = Cache._privateConstructor();
  factory Cache() {
    return _instance;
  }

  void setData(String key, dynamic value) {
    this.data[key] = value;
  }

  void clear() {
    this.data = new Map<String, dynamic>();
  }

  bool hasData(String key) {
    return this.data.containsKey(key);
  }

  Map<String, dynamic> getData(String key) {
    return this.data['userAchievement'];
  }
}
