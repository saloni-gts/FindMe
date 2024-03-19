// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..id = fields[0] as int?
      ..loginType = fields[1] as int?
      ..socialToken = fields[2] as String?
      ..phoneCode = fields[3] as String?
      ..mobileNumber = fields[4] as int?
      ..email = fields[5] as String?
      ..password = fields[6] as String?
      ..name = fields[7] as String?
      ..isVerfied = fields[8] as int?
      ..socialId = fields[9] as String?
      ..countryId = fields[10] as int?
      ..language = fields[11] as String?
      ..city = fields[12] as String?
      ..shortCode = fields[13] as String?
      ..code = fields[14] as String?
      ..countryName = fields[15] as String?
      ..lastName = fields[16] as String?
      ..address = fields[17] as String?
      ..profileImage = fields[18] as String?
      ..gender = fields[19] as String?
      ..token = fields[20] as String?
      ..country = fields[21] as String?
      ..isPremium = fields[22] as int?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.loginType)
      ..writeByte(2)
      ..write(obj.socialToken)
      ..writeByte(3)
      ..write(obj.phoneCode)
      ..writeByte(4)
      ..write(obj.mobileNumber)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.isVerfied)
      ..writeByte(9)
      ..write(obj.socialId)
      ..writeByte(10)
      ..write(obj.countryId)
      ..writeByte(11)
      ..write(obj.language)
      ..writeByte(12)
      ..write(obj.city)
      ..writeByte(13)
      ..write(obj.shortCode)
      ..writeByte(14)
      ..write(obj.code)
      ..writeByte(15)
      ..write(obj.countryName)
      ..writeByte(16)
      ..write(obj.lastName)
      ..writeByte(17)
      ..write(obj.address)
      ..writeByte(18)
      ..write(obj.profileImage)
      ..writeByte(19)
      ..write(obj.gender)
      ..writeByte(20)
      ..write(obj.token)
      ..writeByte(21)
      ..write(obj.country)
      ..writeByte(22)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
