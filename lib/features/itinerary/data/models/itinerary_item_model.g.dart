// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItineraryItemModelAdapter extends TypeAdapter<ItineraryItemModel> {
  @override
  final int typeId = 2;

  @override
  ItineraryItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItineraryItemModel(
      id: fields[0] as String,
      tripId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String?,
      date: fields[4] as DateTime,
      time: fields[5] as String?,
      location: fields[6] as String?,
      category: fields[7] as String,
      isCompleted: fields[8] as bool,
      createdAt: fields[9] as DateTime,
      isSynced: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItineraryItemModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tripId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.isCompleted)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItineraryItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
