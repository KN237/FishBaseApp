import 'package:flutter/material.dart';
import '../network/httpservices.dart';
import '../models/espece.dart';
import '../models/categorie.dart';
import '../models/famille.dart';
import 'pet_detail.dart';

class PetWidget extends StatefulWidget {
  final Espece pet;
  final int index;
  var famille;

  PetWidget({required this.pet, required this.index});

  @override
  State<PetWidget> createState() => _PetWidgetState();
}

class _PetWidgetState extends State<PetWidget> {
  final String baseURL = "https://lit-lake-07750.herokuapp.com/especes/";

  @override
  Widget build(BuildContext context) {
    final String imgUrl = widget.pet.illustration as String;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetail(pet: widget.pet)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200] as Color,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
            right: widget.index != null ? 16 : 0,
            left: widget.index == 0 ? 16 : 0,
            bottom: 16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: widget.pet.id.toString(),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage((baseURL + imgUrl)),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: pet.condition == "Adoption"
                  //         ? Colors.orange[100]
                  //         : pet.condition == "Disappear"
                  //             ? Colors.red[100]
                  //             : Colors.blue[100],
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   child: Text(
                  //     pet.condition,
                  //     style: TextStyle(
                  //       color: pet.condition == "Adoption"
                  //           ? Colors.orange
                  //           : pet.condition == "Disappear"
                  //               ? Colors.red
                  //               : Colors.blue,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.pet.nom,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmarks_outlined,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      FutureBuilder(
                          future: HttpService.getfamille(
                              widget.pet.famille_id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data as String,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return Text(
                                "Chargement...",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmarks,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      FutureBuilder(
                          future: HttpService.getcategorie(
                              widget.pet.categorie_id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data as String,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return Text(
                                "Chargement...",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
