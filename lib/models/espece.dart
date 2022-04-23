import 'categorie.dart';
import 'famille.dart';
import 'forme.dart';

class Espece {
  int id;
  String nom;
  String? description;
  String? illustration;
  String? remarque;
  var categorie_id;
  var famille_id;
  var forme_id;

  Espece(
      {required this.id,
      required this.nom,
      this.description,
      this.illustration,
      this.remarque,
      this.categorie_id,
      this.famille_id,
      this.forme_id});

  static Espece fromJson(Map<String, dynamic> json) {
    return Espece(
      id: json['id'] as int,
      nom: json['nom'] as String,
      description: json['description'] as String,
      illustration: json['illustration'] as String,
      remarque: json['remarque'] as String,
      categorie_id: json['category_id'],
      famille_id: json['famille_id'],
      forme_id: json['forme_id'],
    );
  }
}
