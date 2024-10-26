import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:letter_game/redux/appState.dart';
import 'package:letter_game/styles/color_pallet.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common_components/common_main_menu_button.dart';

late Store reduxStore;
bool _isInterstitialAdReady = false;

class MainMenuScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Main Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) {
          reduxStore = store;
          return store.state;
        },
        builder: (context, state) {
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
            padding: const EdgeInsets.only(left: 50, right: 50),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const SizedBox(height: 20),
                  CommonMainMenuButton(
                    borderColor: ColorPallet.mainMenuButtonColor1,
                    title: "English Alphabet",
                    store: reduxStore,
                    onTap: () {
                      if (_isInterstitialAdReady) {}
                      Navigator.pushNamed(context, "/alphabet");
                    },
                  ),
                  const SizedBox(height: 20),
                  CommonMainMenuButton(
                    borderColor: ColorPallet.mainMenuButtonColor2,
                    title: "Numbers",
                    store: reduxStore,
                    onTap: () {
                      if (_isInterstitialAdReady) {
                        //_interstitialAd.show();
                      }
                      Navigator.pushNamed(context, "/numbers");
                    },
                  ),
                  const SizedBox(height: 20),
                  CommonMainMenuButton(
                    borderColor: ColorPallet.mainMenuButtonColor1,
                    title: "Number Game",
                    store: reduxStore,
                    onTap: () {
                      Navigator.pushNamed(context, "/number_game");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
