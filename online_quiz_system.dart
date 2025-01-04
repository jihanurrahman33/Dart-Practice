class Question {
  Question({
    this.questionText,
    this.options,
    this.correctOptionIndex,
    this.points,
  });
  String? questionText;
  List<String>? options;
  int? correctOptionIndex;
  int? points;
}

class Quiz {
  List<Question>? questions;
  addQuestion(Question question) {
    Question question = Question(
      questionText: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      correctOptionIndex: 0,
      points: 5,
    );
    questions!.add(question);
  }
}
