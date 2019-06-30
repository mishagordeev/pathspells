class Spell {
  final String name;
  final String description;
  final String fullDescription;

  Spell({this.name, this.description, this.fullDescription});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['name'] as String,
        description: json['description'] as String,
        fullDescription: json['full_description'] as String);
  }
}