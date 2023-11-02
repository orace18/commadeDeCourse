// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestAdapter extends TypeAdapter<Test> {
  @override
  final int typeId = 0;

  @override
  Test read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Test(
      id: fields[0] as int,
      age: fields[1] as double,
      nom: fields[2] as String,
      married: fields[3] as bool,
      listint: (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Test obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.nom)
      ..writeByte(3)
      ..write(obj.married)
      ..writeByte(4)
      ..write(obj.listint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
