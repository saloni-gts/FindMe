// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petLostNotiModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class petLostHiveModelAdapter extends TypeAdapter<petLostHiveModel> {
  @override
  final int typeId = 5;

  @override
  petLostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return petLostHiveModel(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, petLostHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isNotiOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is petLostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
