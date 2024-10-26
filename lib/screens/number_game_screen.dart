import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:letter_game/redux/appState.dart';
import 'package:letter_game/styles/color_pallet.dart';
import 'package:letter_game/styles/text_styles.dart';
import 'package:redux/redux.dart';

import '../common_components/common_main_menu_button.dart';
import '../constants/app_constants.dart';
import '../redux/appActions.dart';

late Store reduxStore;
ConfettiController _controllerCenter =
    ConfettiController(duration: const Duration(seconds: 2));

class NumberGameScreen extends StatelessWidget {
  showAlertDialog(BuildContext context, bool isCorrect, AppState state) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.white,
      content: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isCorrect
                ? Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: _controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ],
                      createParticlePath: drawStar,
                    ),
                  )
                : Container(),
            isCorrect
                ? Image.asset("android/assets/images/happiness.png")
                : Image.asset("android/assets/images/lonely.png"),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  generateRandomNumbers(context, state);
                  Navigator.pop(context);
                },
                child: Text(
                  isCorrect ? "Next" : "Let's Start Again",
                  style:
                      TextStyles.alphabetButtonTextStyle(Colors.redAccent, 20),
                ))
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  generateRandomNumbers(BuildContext buildContext, AppState state) {
    List<int> generatedNumbers = [];
    var rng = Random();
    for (var i = 0; i < 3;) {
      int generatedNumber = rng.nextInt(10);
      if (!generatedNumbers.contains(generatedNumber)) {
        generatedNumbers.add(generatedNumber);
        i++;
      }
    }

    int question = rng.nextInt(3);

    if (AppConstants.listOfNumbers()[state.answers[question]].letter ==
        AppConstants.listOfNumbers()[state.answers[state.prevQuestion]]
            .letter) {
      question = rng.nextInt(3);
    }
    StoreProvider.of<AppState>(buildContext)
        .dispatch(ActionQuestionAndAnswerChange(generatedNumbers, question));
  }

  validateAnswer(
      BuildContext buildContext, AppState state, int selectedAnswer) {
    if (AppConstants.listOfNumbers()[state.answers[state.question]].letter ==
        AppConstants.listOfNumbers()[selectedAnswer].letter) {
      _controllerCenter.play();
      showAlertDialog(buildContext, true, state);
    } else {
      showAlertDialog(buildContext, false, state);
    }
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    // returnAd().load();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Number Game"),
        ),
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
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("What is this Number?",
                    style: TextStyles.mainMenuButtonTextStyle(Colors.black)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Card(
                    color: Colors.black.withOpacity(0.5),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(AppConstants.listOfNumbers()[
                              state.answers[state.question]]
                          .imagePath),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonMainMenuButton(
                  borderColor: ColorPallet.mainMenuButtonColor1,
                  title: AppConstants.listOfNumbers()[state.answers[2]]
                      .exampleName,
                  store: reduxStore,
                  onTap: () => validateAnswer(context, state, state.answers[2]),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonMainMenuButton(
                  borderColor: ColorPallet.mainMenuButtonColor2,
                  title: AppConstants.listOfNumbers()[state.answers[1]]
                      .exampleName,
                  store: reduxStore,
                  onTap: () => validateAnswer(context, state, state.answers[1]),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonMainMenuButton(
                  borderColor: ColorPallet.mainMenuButtonColor3,
                  title: AppConstants.listOfNumbers()[state.answers[0]]
                      .exampleName,
                  store: reduxStore,
                  onTap: () => validateAnswer(context, state, state.answers[0]),
                ),
              ],
            )),
          );
        }));
  }
}
