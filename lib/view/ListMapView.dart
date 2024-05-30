import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/ApiRoute.dart';
import '../model/MapModel.dart';
import 'DetailAgentView.dart';

class ListMapView extends StatefulWidget {
  // final String category;
  ListMapView({super.key});

  @override
  State<ListMapView> createState() => _ListMapView();
}

class _ListMapView extends State<ListMapView> {
  // const _ListItem({required this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps",
          style: TextStyle(
              color: Colors.white
          ),
          // style: TextStyle(
          // color:
          // ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
        // backgroundColor: Colors.green[700],
      ),
      body: _buildListFoods()
      // Container(
      //   child: GridView.builder(
      //     itemBuilder: (context, index) {
      //       return CardItem(name: widget.categories[index]);
      //     },
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //     ),
      //     itemCount: categories.length,
      //   ),
      // ),
    );
  }

  Widget _buildListFoods(){
    return Container(
      child: FutureBuilder(
          future: ApiRoute.loadMaps(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoading();
            }
            else if (snapshot.hasError){
              return _buildError();
            }
            else if (snapshot.hasData){
              if (snapshot.data == null) {
                return _buildError();
              }
              try{
                MapModel mapModel = MapModel.fromJson(snapshot.data);
                if (mapModel.data == null || mapModel.data!.isEmpty) {
                  // print(snapshot.data);
                  print("null list");
                  return _buildError();
                }
                // print(mapModel);
                // print(snapshot.data);
                // print("categories");
                // print(categoriesModel.categories);
                return _buildSuccess(mapModel);
              } catch (e) {
                return _buildError();
              }
            } else return _buildError();
          }
      ),
    );
  }

  Widget _buildSuccess(MapModel mapModel){
    // print("length ${foodsModel.meals!.length}");
    return GridView.builder(
      itemBuilder: (context, index) {
        // print("data: ");
        // print("index: $index ");
        // print("data:  ${foodsModel.meals! [index]}");
        // print("data:  ${foodsModel.meals! [index].idMeal}");
        // print("data:  ${foodsModel.meals! [index].strMealThumb}");
        // print("data:  ${foodsModel.meals! [index].strMeal}");
        return CardItem(map: mapModel.data! [index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: mapModel.data!.length,
    );
  }

  Widget _buildError() {
    return Text("Error");
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}


// class ListItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<String> categories = [
//       "Ayam Percik",
//       "Brown Stew Chicken",
//       "Chick-Fil-A Sandwich",
//       "Chicken & Mushroom Hot Plate",
//       "Chicken Alfredo Primavera",
//       "Chicken Basquaise"
//     ];
//
//     // );
//   }
// }

class CardItem extends StatelessWidget {
  final Maps map;

  CardItem({Key? key, required this.map});

  //
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigator.push(context,
          //   MaterialPageRoute(builder:
          //     (context) => DetailFoodView(id: meals.idMeal ?? ""))
          // );
          _launchUrl(map.displayIcon);
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Image.network(
                    width: 300,
                    height: 300,
                    // 'https://picsum.photos/500/500',
                    map.displayIcon ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 15,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  map.displayName ?? "",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 15,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  map.coordinates ?? "null",
                  // style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    final Uri _url = Uri.parse(url);

    if(!await launchUrl(_url)){
      throw Exception("Could not launch $_url");
    }
  }
}