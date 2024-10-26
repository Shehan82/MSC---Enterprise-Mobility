import 'appActions.dart';
import 'appState.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);
  if (action is ActionWritingLetterChange) {
    newState.writingLetter = action.writingLetter;
  } else if (action is ActionQuestionAndAnswerChange) {
    newState.answers = action.answers;
    newState.question = action.question;
    newState.prevQuestion = action.question;
  } else if (action is ActionQuestionAndAnswerLetterChange) {
    newState.answersLetter = action.answersLetter;
    newState.questionLetter = action.questionLetter;
    newState.prevQuestionLetter = action.questionLetter;
  }
  return newState;
}
