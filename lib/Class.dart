class Class {
  final String id;
  final String name;
  final String image;
  final int levelCount;

  Class({this.id, this.name, this.image, this.levelCount});

  factory Class.get(Map<String, dynamic> json) {
    return new Class(
        id: json['id'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
        levelCount: json['level_count'] as int);
  }
}
