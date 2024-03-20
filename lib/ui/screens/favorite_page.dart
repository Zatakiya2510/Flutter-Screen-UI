import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_test_ui/constants.dart';
import 'package:plant_test_ui/models/plants.dart';
import 'package:plant_test_ui/ui/screens/widgets/plant_widget.dart';

import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  final List<Plant> favoritedPlants;

  const FavoritePage({Key? key, required this.favoritedPlants})
      : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool toggleIsFavorited(bool isFavorited) {
      return !isFavorited;
    }
    return Scaffold(
      body: widget.favoritedPlants.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/favorited.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your favorited Plants',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
        height: size.height * 10,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns in the grid
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemCount: widget.favoritedPlants.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: DetailPage(
                      plantId: widget.favoritedPlants[index].plantId,
                    ),
                    type: PageTransitionType.leftToRightWithFade,
                  ),
                );
              },
              child: Container(
                width: size.width * 0.3, // Adjust the width based on your design
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 20,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              bool isFavorited = toggleIsFavorited(
                                widget.favoritedPlants[index].isFavorated,
                              );
                              widget.favoritedPlants[index].isFavorated = isFavorited;
                            });
                          },
                          icon: Icon(
                            widget.favoritedPlants[index].isFavorated == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Constants.primaryColor,
                          ),
                          iconSize: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 50,
                      bottom: 50,
                      child: Image.asset(widget.favoritedPlants[index].imageURL),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.favoritedPlants[index].category,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.favoritedPlants[index].plantName,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          r'$' + widget.favoritedPlants[index].price.toString(),
                          style: TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
