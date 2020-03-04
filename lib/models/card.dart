import 'package:meta/meta.dart' show required;

import '../utils/utils.dart';

class Card<T> {
  final T id;
  final String imagePath;

  const Card({@required this.id, this.imagePath});

  @override
  String toString() => enumToString(id);
}
