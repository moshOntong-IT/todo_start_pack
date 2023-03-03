/// {@template item}
/// A model class that represents an item.
/// `id` is the unique identifier of the item. The unique id in Firebase
/// is the document id, and the data type is String. Therefore, the id property
/// is String.
/// `value` is the value of the item.
/// {@endtemplate}
class Item {
  /// {@macro item}
  Item({
    required this.id,
    required this.value,
  });

  final String id;
  final String value;
}
