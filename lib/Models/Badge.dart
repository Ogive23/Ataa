// ignore_for_file: file_names

class Badge {
  String id;
  String name;
  String arabicName;
  String description;
  String image;
  bool active;
  bool acquired;
  DateTime? acquiredAt;
  Badge(
      {required this.id,
      required this.name,
      required this.arabicName,
      required this.description,
      required this.image,
      required this.active,
      required this.acquired,
      this.acquiredAt});
}
