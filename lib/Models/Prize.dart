class Prize{
  String id;
  String name;
  String? image;
  int requiredMarkersCollected;
  int requiredMarkersPosted;
  DateTime? from;
  DateTime? to;
  int level;
  Prize({required this.id, required this.name, this.image, required this.requiredMarkersCollected, required this.requiredMarkersPosted, this.from , this.to, required this.level});
}