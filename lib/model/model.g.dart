// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelsongAdapter extends TypeAdapter<Modelsong> {
  @override
  final int typeId = 1;

  @override
  Modelsong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Modelsong(
      name: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[3] as int?,
      id: fields[4] as int?,
      url: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Modelsong obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelsongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
