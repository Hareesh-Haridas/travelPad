// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduledTripAdapter extends TypeAdapter<ScheduledTrip> {
  @override
  final int typeId = 0;

  @override
  ScheduledTrip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduledTrip(
      destination: fields[0] as String,
      date: fields[1] as DateTime,
      selectedcontacts: (fields[2] as List).cast<String>(),
      totalExpenseAmount: fields[3] as double?,
      splitAmount: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduledTrip obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.destination)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.selectedcontacts)
      ..writeByte(3)
      ..write(obj.totalExpenseAmount)
      ..writeByte(4)
      ..write(obj.splitAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledTripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
