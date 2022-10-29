// ignore_for_file: file_names

import 'package:ataa/Models/BaseUser.dart';

class User implements BaseUser{
  @override
  String id;
  String name;
  String username;
  String email;
  String gender;
  String phoneNumber;
  String address;
  bool verified;
  String? profileImage;
  String? profileCover;
  String? profileBio;
  String nationality;

  User(
      this.id,
      this.name,
      this.username,
      this.email,
      this.gender,
      this.phoneNumber,
      this.address,
      this.verified,
      this.profileImage,
      this.profileCover,
      this.profileBio,this.nationality);

  List<String> toList() {
    return [
      id,
      name,
      username,
      email,
      gender,
      phoneNumber,
      address,
      verified.toString(),
      profileImage!,
      profileCover!,
      profileBio!,
      nationality
    ];
  }
}
