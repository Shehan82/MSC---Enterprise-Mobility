import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:letter_game/common_components/common_alphabet_grid.dart';
import 'package:letter_game/redux/appState.dart';
import 'package:redux/redux.dart';

import '../constants/app_constants.dart';

late Store reduxStore;

class NumbersScreen extends StatelessWidget {
  final List<Widget> list = [
    CommonAlphabetGridScreen(
      title: "Numbers",
      letters: AppConstants.listOfNumbers(),
      numberOfTiles: 3,
      fontSize: 50,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: StoreConnector<AppState, AppState>(converter: (store) {
          reduxStore = store;
          return store.state;
        }, builder: (context, state) {
          return AnimatedContainer(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("android/assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            curve: Curves.easeOut,
            duration: const Duration(
              milliseconds: 400,
            ),
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            child: SizedBox(
              height: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  disableCenter: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ),
                items: list.map((item) => item).toList(),
              ),
            ),
          );
        }));
  }
}
