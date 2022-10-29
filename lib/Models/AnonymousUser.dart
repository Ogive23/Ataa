// ignore_for_file: file_names

import 'package:ataa/Models/BaseUser.dart';

class AnonymousUser implements BaseUser {
  @override
  String id;

  AnonymousUser(this.id);

  List<String> toList() {
    return [
      id,
    ];
  }
}
