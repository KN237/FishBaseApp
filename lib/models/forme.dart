class Forme {
  int id;
  String nom;
  String? description;

  Forme({required this.id, required this.nom, this.description});

  static Forme fromJson(Map<String, dynamic> json) {
    return Forme(
        id: json['id'] as int,
        nom: json['nom'] as String,
        description: json['description'] as String);
  }
}
