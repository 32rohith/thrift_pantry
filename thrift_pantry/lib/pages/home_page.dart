// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:thrift_pantry/pages/discover_page/discover_page.dart';
import 'package:thrift_pantry/pages/farm_page/farm_page.dart';
import 'package:thrift_pantry/pages/grocery_page/grocery_page.dart';
import 'package:thrift_pantry/pages/maps_page/map_page.dart';
import 'package:thrift_pantry/pages/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 2); // Controller for page navigation
  final NotchBottomBarController _controller = NotchBottomBarController(index: 2);

  // List of pages to navigate to
  final List<Widget> _pages = [
    MapPage(),
    FarmPage(),
    DiscoverPage(),
    GroceryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keeping the black background
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _controller.index = index;  // Update controller index
          });
        },
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        color: Theme.of(context).colorScheme.surface, // Make background transparent
        notchBottomBarController: _controller,
        notchColor: Colors.grey.shade500, // Color of the notch
        // showBlurBottomBar: true,
        durationInMilliSeconds: 300,
        showLabel: true,
        itemLabelStyle: TextStyle(
          color: const Color.fromARGB(206, 4, 134, 84),
          fontSize: 10,
        ), 
        elevation: 2,
        bottomBarHeight: 50,
        bottomBarWidth: MediaQuery.sizeOf(context).width,
        blurOpacity: 0.9,
        blurFilterX: 10000,
        blurFilterY: 10000,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
            ),
            activeItem: Icon(
              Icons.location_pin,
              color: const Color.fromARGB(206, 4, 134, 84),
            ),
            itemLabel: 'Map',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.agriculture_outlined,
              color: Colors.grey,
            ),
            activeItem: Icon(
              Icons.agriculture_rounded,
              color: const Color.fromARGB(206, 4, 134, 84),
            ),
            itemLabel: 'Farm',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.grey,
            ),
            activeItem: Icon(
              Icons.home,
              color: const Color.fromARGB(206, 4, 134, 84),
            ),
            itemLabel: 'Discover',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey,
            ),
            activeItem: Icon(
              Icons.shopping_bag_rounded,
              color: const Color.fromARGB(206, 4, 134, 84),
            ),
            itemLabel: 'Grocery',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            activeItem: Icon(
              Icons.person,
              color: const Color.fromARGB(206, 4, 134, 84),
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _controller.index = index; // Update controller index
          });
          _pageController.jumpToPage(index); // Navigate to the selected page
        },
        kIconSize: 20,
        kBottomRadius: 32,
      ),
    );
  }
}
