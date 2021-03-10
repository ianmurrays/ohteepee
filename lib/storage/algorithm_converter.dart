part of 'database.dart';

enum Algorithm {
  SHA1,
  SHA256,
  SHA512,
}

class AlgorithmConverter extends TypeConverter<Algorithm, int> {
  const AlgorithmConverter();

  @override
  Algorithm mapToDart(int fromDb) {
    return Algorithm.values[fromDb];
  }

  @override
  int mapToSql(Algorithm value) {
    return value.index;
  }
}
