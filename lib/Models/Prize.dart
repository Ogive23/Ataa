class Prize {
  String id;
  String name;
  String arabicName;
  String? image;
  int requiredMarkersCollected;
  int requiredMarkersPosted;
  DateTime? from;
  DateTime? to;
  int level;
  bool active;
  bool acquired;
  DateTime? acquiredAt;
  Prize(
      {required this.id,
      required this.name,
        required this.arabicName,
      this.image,
      required this.requiredMarkersCollected,
      required this.requiredMarkersPosted,
      this.from,
      this.to,
      required this.level, required this.active, required this.acquired, this.acquiredAt});
}
