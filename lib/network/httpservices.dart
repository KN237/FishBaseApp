import 'dart:convert';
import 'package:http/http.dart';
import '../models/categorie.dart';
import '../models/forme.dart';
import '../models/famille.dart';
import '../models/espece.dart';

class HttpService {
  static final String baseURL = "https://lit-lake-07750.herokuapp.com/api";

  static Future<List<Famille>> getfamilles() async {
    Response res =  await get(baseURL + '/familles');
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Famille> familles = body
          .map(
            (dynamic item) => Famille.fromJson(item),
          )
          .toList();

      return familles;
    } else {
      throw "Unable to retrieve familles.";
    }
  }

  static Future<List<Espece>> getespeces() async {
    Response res = await get(baseURL + '/especes');
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Espece> especes = body
          .map(
            (dynamic item) => Espece.fromJson(item),
          )
          .toList();

      return especes;
    } else {
      throw "Unable to retrieve especes.";
    }
  }

  static Future<String> getfamille(String index) async {
    Response res = await get(baseURL + '/familles/' + index);
    if (res.statusCode == 200) {
      Famille famille = Famille.fromJson(jsonDecode(res.body));

      return famille.nom;
    } else {
      throw "Unable to retrieve especes.";
    }
  }

  static Future<String?> getFamille(String index) async {
    Response res = await get(baseURL + '/familles/' + index);
    if (res.statusCode == 200) {
      Famille famille = Famille.fromJson(jsonDecode(res.body));
      return famille.nomcommun;
    } else {
      throw "Unable to retrieve familles.";
    }
  }

  static Future<String> getcategorie(String index) async {
    Response res = await get(baseURL + '/categories/' + index);
    if (res.statusCode == 200) {
      Categorie categorie = Categorie.fromJson(jsonDecode(res.body));

      return categorie.nom;
    } else {
      throw "Unable to retrieve especes.";
    }
  }

  static Future<List<Categorie>> getcategories() async {
    Response res = await get(baseURL + '/categories');
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Categorie> categories = body
          .map(
            (dynamic item) => Categorie.fromJson(item),
          )
          .toList();

      return categories;
    } else {
      throw "Unable to retrieve categories.";
    }
  }

  Future<List<Forme>> getformes() async {
    Response res = await get(baseURL + '/formes');
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Forme> formes = body
          .map(
            (dynamic item) => Forme.fromJson(item),
          )
          .toList();

      return formes;
    } else {
      throw "Unable to retrieve catgeories.";
    }
  }
}
