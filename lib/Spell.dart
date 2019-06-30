class Spell {
  final String name;
  final String description;
  final String fullDescription;
  final Map<String, String> classLevel;

  Spell(
      {this.name,
      this.description,
      this.fullDescription,
      this.classLevel});

  factory Spell.fromJson(Map<String, dynamic> json) {
    return new Spell(
        name: json['name'] as String,
        description: json['description'] as String,
        fullDescription: json['full_description'] as String,
        classLevel: {
          'bard': json['bard'] as String,
          'cleric': json['cleric'] as String,
          'druid': json['druid'] as String,
          'paladin': json['paladin'] as String,
          'ranger': json['ranger'] as String,
          'wizard': json['wizard'] as String,
        });
  }
}
