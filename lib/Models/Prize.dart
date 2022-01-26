class Prize {
  String id;
  String name;
  String? image;
  int requiredMarkersCollected;
  int requiredMarkersPosted;
  DateTime? from;
  DateTime? to;
  int level;
  bool acquired;
  DateTime? acquiredAt;
  Prize(
      {required this.id,
      required this.name,
      this.image,
      required this.requiredMarkersCollected,
      required this.requiredMarkersPosted,
      this.from,
      this.to,
      required this.level, required this.acquired, this.acquiredAt});
}
