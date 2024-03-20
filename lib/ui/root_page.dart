import 'package:flutter/material.dart';
import 'package:plant_test_ui/constants.dart';
import 'package:plant_test_ui/models/plants.dart';
import 'package:plant_test_ui/ui/screens/cart_page.dart';
import 'package:plant_test_ui/ui/screens/favorite_page.dart';
import 'package:plant_test_ui/ui/screens/home_page.dart';
import 'package:plant_test_ui/ui/screens/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];

  int _bottomNavIndex = 0;

  // List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      FavoritePage(favoritedPlants: favorites),
      CartPage(addedToCartPlants: myCart),
      const ProfilePage(),
    ];
  }

  // List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  // List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

            favorites = favoritedPlants;
            myCart = addedToCartPlants.toSet().toList();
          });
        },
        items: List.generate(
          iconList.length,
              (index) => BottomNavigationBarItem(
            icon: Icon(iconList[index]),
            label: titleList[index], // Set label to an empty string to hide it
          ),
        ),
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.black.withOpacity(.5),
        type: BottomNavigationBarType.fixed,
      ),

    );
  }
}
