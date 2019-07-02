class Class {
  final String name;
  final String image;
  final String levelCount;

  Class(
      {this.name,
        this.image,
        this.levelCount});

  factory Class.fromJson(Map<String, dynamic> json) {
    return new Class(
        name: json['name'] as String,
        image: json['image'] as String,
        levelCount: json['level_count'] as String);
  }
}
