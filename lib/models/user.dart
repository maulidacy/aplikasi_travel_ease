class User {
  final int? id;
  final String name;

  User({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}