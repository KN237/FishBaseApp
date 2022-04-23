import 'package:fish/screens/espece_list.dart';
import 'package:fish/screens/pet_detail.dart';
import 'package:http/http.dart';
import '../network/httpservices.dart';
import '../models/categorie.dart';
import '../models/forme.dart';
import '../models/famille.dart';
import '../models/espece.dart';
import '../screens/pet_widget.dart';
import '../screens/category_list.dart';
import '../screens/group_list.dart';
import '../screens/group_espece.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/espece.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  TextEditingController filtre = TextEditingController();
  String searchText = "";
  List noms = [];
  List nomsFiltres = [];
  static String _displayStringForOption(Espece option) => option.nom;
  List<Espece> especeOptions = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void getNoms() async {
    final Response res =
        await get("https://lit-lake-07750.herokuapp.com/api/especes");
    List temp = [];

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Espece> especes = body
          .map(
            (dynamic item) => Espece.fromJson(item),
          )
          .toList();

      for (int i = 0; i < especes.length; i++) {
        temp.add(especes[i]);
      }
      setState(() {
        noms = temp;
        nomsFiltres = noms;
        especeOptions = especes;
      });
    } else {
      setState(() {
        noms = temp;
        nomsFiltres = noms;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getNoms();
    super.initState();
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: Stack(children: <Widget>[
          Center(
            child: Text("FishBase Menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
          ),
        ]));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.sort,
            color: Colors.grey[800],
          ),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [],
      ),
      drawer: Drawer(
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _createHeader(),
              _createDrawerItem(
                  icon: Icons.search,
                  text: 'Recherche par caractéristiques',
                  onTap: () {}),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              ListTile(
                title: Text('Version 1.0'),
                onTap: () {},
              ),
            ],
          )),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "FishBase",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Entrez l'espèce recherchée ici",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Autocomplete<Espece>(
                displayStringForOption: _displayStringForOption,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<Espece>.empty();
                  }
                  return especeOptions.where((Espece option) {
                    return option.nom
                        .toString()
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Recherche',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.only(
                        right: 30,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.0, left: 24.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                      print('You just typed a new entry  $value');
                    },
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<Espece> onSelected,
                    Iterable<Espece> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: Container(
                        width: 300,
                        color: Colors.white,
                        child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Espece option = options.elementAt(index);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PetDetail(pet: option)),
                                );
                              },
                              child: ListTile(
                                title: Text(option.nom,
                                    style:
                                        const TextStyle(color: Colors.black54)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                onSelected: (Espece selection) {
                  debugPrint(
                      'You just selected ${_displayStringForOption(selection)}');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Classés par groupe",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GroupList()),
                      );
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  FutureBuilder(
                      future: HttpService.getfamilles(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Famille>> snapshot) {
                        if (snapshot.hasData) {
                          List<Famille> familles =
                              snapshot.data as List<Famille>;
                          return Container(
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildPetCategory(
                                      familles[0].nom,
                                      familles[0].id.toString(),
                                      Colors.grey[400] as Color),
                                  buildPetCategory(
                                      familles[1].nom,
                                      familles[1].id.toString(),
                                      Colors.black45 as Color),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildPetCategory(
                                      familles[4].nom,
                                      familles[4].id.toString(),
                                      Colors.black54 as Color),
                                  buildPetCategory(
                                      familles[3].nom,
                                      familles[3].id.toString(),
                                      Colors.black87 as Color),
                                ],
                              ),
                            ]),
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          ));
                        }
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Récemment ajoutés",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EspeceList()));
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: HttpService.getespeces(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Espece>> snapshot) {
                  if (snapshot.hasData) {
                    List<Espece> especes = snapshot.data as List<Espece>;
                    return Container(
                      height: 250,
                      child: ListView(
                        children: buildNewestPet(especes),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                      ),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                }),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Classés par catégorie",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 130,
              margin: EdgeInsets.only(bottom: 16),
              child: FutureBuilder(
                future: HttpService.getcategories(),
                // builder: (context, snapshot) {
                //   return PageView(
                //     physics: BouncingScrollPhysics(),
                //     children: [
                //       buildVet(snapshot.data),
                //     ],
                //   );

                builder: (BuildContext context,
                    AsyncSnapshot<List<Categorie>> snapshot) {
                  if (snapshot.hasData) {
                    List<Categorie> categories =
                        snapshot.data as List<Categorie>;
                    return PageView(
                      physics: BouncingScrollPhysics(),
                      children:
                          buildNewestVet(snapshot.data as List<Categorie>),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPetCategory(String nom, String id, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GroupEspece(category_nom: nom, category_id: id)),
          );
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400] as Color,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nom,
                    style: TextStyle(
                      color: Colors.grey[800],
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNewestPet(List<Espece> especes) {
    List<Widget> list = [];
    for (var i = 0; i < 5; i++) {
      list.add(PetWidget(pet: especes[i], index: i));
    }
    return list;
  }

  List<Widget> buildNewestVet(List<Categorie> cats) {
    List<Widget> list = [];
    for (var i = 0; i < cats.length; i++) {
      list.add(buildVet(cats[i].nom, cats[i].id.toString()));
    }
    return list;
  }

  Widget buildVet(String name, String id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CategoryList(category_nom: name, category_id: id)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
            width: 1,
            color: Colors.grey[300] as Color,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 98,
              width: 98,
              child: Image.asset(
                "assets/images/fish2.png",
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: FutureBuilder(
                        future: HttpService.getespeces(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> test = snapshot.data as List<dynamic>;
                            int tot = 0;
                            test
                                .where((i) => i.categorie_id.toString() == id)
                                .forEach((element) {
                              tot = tot + 1;
                            });

                            return Text(
                              tot.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          } else {
                            return Center(child: Text("Chargement..."));
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
