import 'package:letter_game/models/letter.dart';

class AppConstants {
  static List<Letter> listOfLetters() {
    List<Letter> listOfVowels = [
      Letter(letter: "A", imagePath: "", exampleName: "Apple"),
      Letter(letter: "B", imagePath: "", exampleName: "Ball"),
      Letter(letter: "C", imagePath: "", exampleName: "Cat"),
      Letter(letter: "D", imagePath: "", exampleName: "Dog"),
      Letter(letter: "E", imagePath: "", exampleName: "Elephant"),
      Letter(letter: "F", imagePath: "", exampleName: "Frock"),
      Letter(letter: "G", imagePath: "", exampleName: "Good"),
      Letter(letter: "H", imagePath: "", exampleName: "Home"),
      Letter(letter: "I", imagePath: "", exampleName: "Info"),
      Letter(letter: "J", imagePath: "", exampleName: "Joy"),
      Letter(letter: "K", imagePath: "", exampleName: "Kind"),
      Letter(letter: "L", imagePath: "", exampleName: "Love"),
      Letter(letter: "M", imagePath: "", exampleName: "Mother"),
      Letter(letter: "N", imagePath: "", exampleName: "Nose"),
      Letter(letter: "O", imagePath: "", exampleName: "Office"),
      Letter(letter: "P", imagePath: "", exampleName: "Pie"),
      Letter(letter: "Q", imagePath: "", exampleName: "Queen"),
      Letter(letter: "R", imagePath: "", exampleName: "Run"),
      Letter(letter: "S", imagePath: "", exampleName: "Silver"),
      Letter(letter: "T", imagePath: "", exampleName: "Teeth"),
      Letter(letter: "U", imagePath: "", exampleName: "Universe"),
      Letter(letter: "V", imagePath: "", exampleName: "Vampire"),
      Letter(letter: "W", imagePath: "", exampleName: "Walk"),
      Letter(letter: "X", imagePath: "", exampleName: "Xeon"),
      Letter(letter: "Y", imagePath: "", exampleName: "Yellow"),
      Letter(letter: "Z", imagePath: "", exampleName: "Zoo")
    ];

    return listOfVowels;
  }

  static List<Letter> listOfOther() {
    List<Letter> listOfOther = [
      Letter(letter: "a", imagePath: "", exampleName: "ant"),
      Letter(letter: "e", imagePath: "", exampleName: "egg"),
      Letter(letter: "i", imagePath: "", exampleName: "illegal"),
      Letter(letter: "o", imagePath: "", exampleName: "oval"),
      Letter(letter: "u", imagePath: "", exampleName: "uganda")
    ];

    return listOfOther;
  }

  static List<Letter> listOfNumbers() {
    List<Letter> listOfNumbers = [
      Letter(
          letter: "0",
          imagePath: "android/assets/images/numbers/zero.png",
          exampleName: "Zero"),
      Letter(
          letter: "1",
          imagePath: "android/assets/images/numbers/one.png",
          exampleName: "One"),
      Letter(
          letter: "2",
          imagePath: "android/assets/images/numbers/two.png",
          exampleName: "Two"),
      Letter(
          letter: "3",
          imagePath: "android/assets/images/numbers/three.png",
          exampleName: "Three"),
      Letter(
          letter: "4",
          imagePath: "android/assets/images/numbers/four.png",
          exampleName: "Four"),
      Letter(
          letter: "5",
          imagePath: "android/assets/images/numbers/five.png",
          exampleName: "Five"),
      Letter(
          letter: "6",
          imagePath: "android/assets/images/numbers/six.png",
          exampleName: "Six"),
      Letter(
          letter: "7",
          imagePath: "android/assets/images/numbers/seven.png",
          exampleName: "Seven"),
      Letter(
          letter: "8",
          imagePath: "android/assets/images/numbers/eight.png",
          exampleName: "Eight"),
      Letter(
          letter: "9",
          imagePath: "android/assets/images/numbers/nine.png",
          exampleName: "Nine"),
    ];

    return listOfNumbers;
  }
}
