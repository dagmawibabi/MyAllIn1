import 'package:hive/hive.dart';

part "userProfile.g.dart";

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  late bool verified;

  @HiveField(1)
  late String fullname;
  @HiveField(2)
  late String username;
  @HiveField(3)
  late String password;
  @HiveField(4)
  late String profilepic;
  @HiveField(5)
  late String phone;
  @HiveField(6)
  late String email;
  @HiveField(7)
  late String bio;

  @HiveField(8)
  late int posts;

  @HiveField(9)
  late List followers;
  @HiveField(10)
  late List following;
  @HiveField(11)
  late List communities;
}
