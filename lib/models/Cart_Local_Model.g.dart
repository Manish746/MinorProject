// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cart_Local_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalCartModelAdapter extends TypeAdapter<LocalCartModel> {
  @override
  final int typeId = 1;

  @override
  LocalCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalCartModel(
      price: fields[2] as double,
      imageUrl: fields[3] as String,
      limit: fields[4] as int,
      pName: fields[5] as String,
      productId: fields[0] as String,
      numOfItem: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LocalCartModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.numOfItem)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.limit)
      ..writeByte(5)
      ..write(obj.pName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
