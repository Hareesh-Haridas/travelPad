// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_destination_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DreamDestinationAdapter extends TypeAdapter<DreamDestination> {
  @override
  final int typeId = 2;

  @override
  DreamDestination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DreamDestination(
      place: fields[0] as String,
      savings: fields[1] as double,
      expense: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DreamDestination obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.place)
      ..writeByte(1)
      ..write(obj.savings)
      ..writeByte(2)
      ..write(obj.expense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DreamDestinationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
