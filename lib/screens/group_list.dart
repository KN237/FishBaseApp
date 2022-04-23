import 'package:flutter/material.dart';
import '../models/categorie.dart';
import './pet_widget3.dart';
import '../network/httpservices.dart';
import '../screens/group_espece.dart';

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Groupes",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
              ),
              child: FutureBuilder(
                  future: HttpService.getfamilles(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> test = snapshot.data as List<dynamic>;
                      return GridView.count(
                        physics: BouncingScrollPhysics(),
                        childAspectRatio: 1 / 1.55,
                        crossAxisCount: 2,
                        children: test.map((item) {
                          return PetWidget(
                            pet: item,
                            index: 0,
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }
                  }),
              // builder: (context, snapshot) {
              //   return GridView.count(
              //     physics: BouncingScrollPhysics(),
              //     childAspectRatio: 1 / 1.55,
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 15,
              //     children: HttpService.getespeces()
              //         .where((i) => i.category == category)
              //         .map((item) {
              //       return PetWidget(
              //         pet: item,
              //         index: 0,
              //       );
              //     }).toList(),
              //   );
              // }),
            ),
          ),
        ],
      ),
    );
  }
}
