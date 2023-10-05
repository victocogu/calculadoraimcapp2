// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcAdapter extends TypeAdapter<Imc> {
  @override
  final int typeId = 0;

  @override
  Imc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Imc(
      fields[0] as double,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Imc obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._peso)
      ..writeByte(1)
      ..write(obj._altura);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
