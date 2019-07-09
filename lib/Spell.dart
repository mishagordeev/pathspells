class Spell {
  final String name;
  final String description;
  final String fullDescription;
  final Map<String, int> classLevel;
  final List<dynamic> attributes;
  final bool legal;

  Spell(
      {this.name,
      this.description,
      this.fullDescription,
      this.classLevel,
      this.attributes,
      this.legal});

  factory Spell.get(Map<String, dynamic> json) {
    return new Spell(
        name: json['name'] as String,
        description: json['description'] as String,
        fullDescription: json['full_description'] as String,
        classLevel: {
          'bard': json['bard'] as int,
          'cleric': json['cleric'] as int,
          'druid': json['druid'] as int,
          'paladin': json['paladin'] as int,
          'ranger': json['ranger'] as int,
          'wizard': json['wizard'] as int,
        },
        attributes: json['attributes'] as List<dynamic>,
        legal: json['legal'] as bool
    );
  }
}
