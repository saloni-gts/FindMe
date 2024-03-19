// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationHiveModelAdapter extends TypeAdapter<LocationHiveModel> {
  @override
  final int typeId = 3;

  @override
  LocationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationHiveModel(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocationHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLocSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
