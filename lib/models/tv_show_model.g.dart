// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvShowAdapter extends TypeAdapter<TvShow> {
  @override
  final int typeId = 0;

  @override
  TvShow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvShow(
      id: fields[0] as int,
      name: fields[1] as String,
      imageMedium: fields[2] as String?,
      imageOriginal: fields[3] as String?,
      rating: fields[4] as double?,
      genres: (fields[5] as List).cast<String>(),
      summary: fields[6] as String?,
      status: fields[7] as String?,
      premiered: fields[8] as String?,
      language: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TvShow obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageMedium)
      ..writeByte(3)
      ..write(obj.imageOriginal)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.summary)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.premiered)
      ..writeByte(9)
      ..write(obj.language);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvShowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
