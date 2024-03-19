// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languagemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageHiveModelAdapter extends TypeAdapter<LanguageHiveModel> {
  @override
  final int typeId = 2;

  @override
  LanguageHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageHiveModel(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLanguageSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
