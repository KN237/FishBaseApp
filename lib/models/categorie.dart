class Categorie {
  int id;
  String nom;

  Categorie({required this.id, required this.nom});

  static Categorie fromJson(Map<String, dynamic> json) {
    return Categorie(id: json['id'] as int, nom: json['nom'] as String);
  }
}
