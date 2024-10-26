import 'package:letter_game/models/letter.dart';

class AppState {
  Letter writingLetter =
      Letter(letter: "A", imagePath: "", exampleName: "Apple");
  List<int> answers = [];
  int question = 0;

  List<int> answersLetter = [];
  int questionLetter = 0;
  int prevQuestion = 0;
  int prevQuestionLetter = 0;

  AppState({
    required this.writingLetter,
    required this.answers,
    required this.question,
    required this.prevQuestion,
    required this.answersLetter,
    required this.questionLetter,
    required this.prevQuestionLetter,
  });

  AppState.fromAppState(AppState another) {
    writingLetter = another.writingLetter;
    answers = another.answers;
    question = another.question;
    prevQuestion = another.prevQuestion;
    answersLetter = another.answersLetter;
    prevQuestionLetter = another.prevQuestionLetter;
    questionLetter = another.questionLetter;
  }
}
