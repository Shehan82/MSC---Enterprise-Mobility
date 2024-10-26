import 'package:letter_game/models/letter.dart';

class ActionWritingLetterChange {
  final Letter writingLetter;

  ActionWritingLetterChange(this.writingLetter);
}

class ActionQuestionAndAnswerChange {
  final List<int> answers;
  final int question;

  ActionQuestionAndAnswerChange(this.answers, this.question);
}

class ActionQuestionAndAnswerLetterChange {
  final List<int> answersLetter;
  final int questionLetter;

  ActionQuestionAndAnswerLetterChange(this.answersLetter, this.questionLetter);
}
