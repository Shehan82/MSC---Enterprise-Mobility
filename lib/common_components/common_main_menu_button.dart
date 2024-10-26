import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letter_game/styles/text_styles.dart';
import 'package:redux/redux.dart';

class CommonMainMenuButton extends StatelessWidget {
  const CommonMainMenuButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.borderColor,
    required this.store,
  });

  final Function onTap;
  final String title;
  final Color borderColor;
  final Store store;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateColor.resolveWith(
              (states) => borderColor.withAlpha(50)),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(
          title,
          style: TextStyles.mainMenuButtonTextStyle(borderColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
