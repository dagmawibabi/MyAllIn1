// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userProfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile()
      ..verified = fields[0] as bool
      ..fullname = fields[1] as String
      ..username = fields[2] as String
      ..password = fields[3] as String
      ..profilepic = fields[4] as String
      ..phone = fields[5] as String
      ..email = fields[6] as String
      ..bio = fields[7] as String
      ..posts = fields[8] as int
      ..followers = (fields[9] as List).cast<dynamic>()
      ..following = (fields[10] as List).cast<dynamic>()
      ..communities = (fields[11] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.verified)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.profilepic)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.bio)
      ..writeByte(8)
      ..write(obj.posts)
      ..writeByte(9)
      ..write(obj.followers)
      ..writeByte(10)
      ..write(obj.following)
      ..writeByte(11)
      ..write(obj.communities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
