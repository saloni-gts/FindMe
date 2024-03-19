// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callLocApi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocApiHiveModelAdapter extends TypeAdapter<LocApiHiveModel> {
  @override
  final int typeId = 4;

  @override
  LocApiHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocApiHiveModel(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocApiHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isCallLocApi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocApiHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
