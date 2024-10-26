import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:letter_game/redux/appReducer.dart';
import 'package:letter_game/redux/appState.dart';
import 'package:letter_game/screens/alphabet_screen.dart';
import 'package:letter_game/screens/login_screen.dart';
import 'package:letter_game/screens/main_menu.dart';
import 'package:letter_game/screens/number_game_screen.dart';
import 'package:letter_game/screens/numbers_screen.dart';
import 'package:letter_game/screens/profile_screen.dart';
import 'package:redux/redux.dart';
import 'constants/app_constants.dart';
import 'models/letter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('profileBox');

  final _initialState = AppState(
      writingLetter: Letter(letter: "A", imagePath: "", exampleName: ""),
      answers: generateRandomNumbers(),
      question: generateRandomNumber(),
      prevQuestion: 0,
      answersLetter: generateRandomNumbersLetters(),
      questionLetter: generateRandomNumber(),
      prevQuestionLetter: 0);

  Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);

  runApp(Phoenix(
      child: MyApp(
    store: _store,
  )));
}

List<int> generateRandomNumbers() {
  List<int> initList = [];
  var rng = Random();
  for (var i = 0; i < 3;) {
    int generatedNumber = rng.nextInt(10);
    if (!initList.contains(generatedNumber)) {
      initList.add(generatedNumber);
      i++;
    }
  }

  return initList;
}

List<Letter> joinedLetters() {
  List<Letter> joinedArray = [];

  joinedArray.addAll(AppConstants.listOfLetters());
  joinedArray.addAll(AppConstants.listOfOther());

  return joinedArray;
}

List<int> generateRandomNumbersLetters() {
  List<int> generatedNumbers = [];
  var rng = Random();
  for (var i = 0; i < 3;) {
    int generatedNumber = rng.nextInt(joinedLetters().length);
    if (!generatedNumbers.contains(generatedNumber)) {
      if (joinedLetters()[generatedNumber].exampleName != "") {
        generatedNumbers.add(generatedNumber);
        i++;
      }
    }
  }

  return generatedNumbers;
}

int generateRandomNumber() {
  var rng = Random();
  return rng.nextInt(3);
}

class MyApp extends StatelessWidget {
  final Store<AppState>? store;

  const MyApp({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store!,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // Define the default brightness and colors.

            brightness: Brightness.light,
            primaryColor: const Color.fromRGBO(248, 110, 76, 1),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/mainMenu': (context) => MainMenuScreen(),
            '/alphabet': (context) => AlphabetScreen(),
            '/numbers': (context) => NumbersScreen(),
            '/number_game': (context) => NumberGameScreen(),
            '/profile': (context) => ProfileScreen(),
          },
          // home: const LoginScreen(),
        ));
  }
}
