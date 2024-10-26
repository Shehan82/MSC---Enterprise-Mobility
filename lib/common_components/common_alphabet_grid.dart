import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letter_game/models/letter.dart';
import 'package:letter_game/styles/color_pallet.dart';
import 'package:letter_game/styles/text_styles.dart';

class CommonAlphabetGridScreen extends StatelessWidget {
  const CommonAlphabetGridScreen(
      {super.key,
      required this.letters,
      required this.title,
      required this.numberOfTiles,
      required this.fontSize});

  final String title;
  final List<Letter> letters;
  final int numberOfTiles;
  final double fontSize;

  showAlertDialog(BuildContext context, int index) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.white,
      content: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              letters[index].exampleName,
              style: TextStyles.alphabetButtonTextStyle(Colors.black, 50),
            )
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorPallet.mainTextColor,
                  size: 30,
                ),
                label: Text("")),
            Expanded(
              child: Text(title,
                  style: TextStyles.mainMenuButtonTextStyle(Colors.black)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          "< Swipe Right >",
          style: TextStyle(color: ColorPallet.mainTextColor),
        ),
        Expanded(
          child: GridView.count(
              crossAxisCount: numberOfTiles,
              childAspectRatio: 1,
              children: List.generate(letters.length, (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () => letters[index].exampleName == ""
                        ? print("no")
                        : showAlertDialog(context, index),
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        color: Colors.indigo,
                        child: Center(
                          child: Text(
                            letters[index].letter,
                            style: TextStyles.alphabetButtonTextStyle(
                                Colors.white, fontSize),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })),
        ),
      ],
    );
  }
}
