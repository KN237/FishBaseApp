class Famille {
  int id;
  String nom;
  String? description;
  String? taille_max;
  String? coloration;
  String? distribution_naturelle;
  String? introduction_bg;
  String? illustration;
  String? remarque;
  String? nomcommun;

  Famille(
      {required this.id,
      required this.nom,
      this.description,
      this.taille_max,
      this.coloration,
      this.distribution_naturelle,
      this.introduction_bg,
      this.illustration,
      this.remarque,
      this.nomcommun});

  static Famille fromJson(Map<String, dynamic> json) {
    return Famille(
      id: json['id'] as int,
      nom: json['nom'] as String,
      description: json['description'] as String,
      taille_max: json['taille_max'] as String,
      coloration: json['coloration'] as String,
      distribution_naturelle: json['distribution_naturelle'] as String,
      introduction_bg: json['introduction_bg'] as String,
      illustration: json['illustration'] as String,
      remarque: json['remarque'] as String,
      nomcommun: json['nomcommun'] as String,
    );
  }
}
