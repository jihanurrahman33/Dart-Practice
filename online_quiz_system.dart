import 'dart:io';

// Define the Question class
class Question {
  String questionText;
  List<String> options;
  int correctOptionIndex;
  int points;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.points,
  });
}

// Define the Quiz class
class Quiz {
  List<Question> questions = [];

  // Method to add a question
  void addQuestion(Question question) {
    questions.add(question);
  }

  // Simulate fetching questions from a database
  Future<void> fetchQuestionsFromDatabase() async {
    // Simulate a delay for async operation
    await Future.delayed(Duration(seconds: 2));

    // Add some dummy questions
    addQuestion(
      Question(
        questionText: "What is the capital of France?",
        options: ["Berlin", "Madrid", "Paris", "Lisbon"],
        correctOptionIndex: 3,
        points: 10,
      ),
    );
    addQuestion(
      Question(
        questionText: "What is 5 + 3?",
        options: ["5", "8", "10", "15"],
        correctOptionIndex: 2,
        points: 5,
      ),
    );
    addQuestion(
      Question(
        questionText: "Which programming language is used for Flutter?",
        options: ["Java", "Dart", "Python", "C++"],
        correctOptionIndex: 2,
        points: 15,
      ),
    );

    print("Questions have been loaded!\n");
  }

  // Method to start the quiz
  Future<void> startQuiz(int passingScore) async {
    int totalPoints = 0;

    print("Starting the Quiz...");
    for (var question in questions) {
      print("\n${question.questionText}");
      for (var i = 0; i < question.options.length; i++) {
        print("${i + 1}. ${question.options[i]}");
      }

      int userAnswer;
      while (true) {
        print("Enter your answer (1-${question.options.length}): ");
        var input = stdin.readLineSync();
        if (input != null && int.tryParse(input) != null) {
          userAnswer = int.parse(input);
          if (userAnswer >= 1 && userAnswer <= question.options.length) {
            break;
          }
        }
        print("Invalid input. Please try again.");
      }

      if (userAnswer == question.correctOptionIndex) {
        totalPoints += question.points;
        print("Correct! +${question.points} points.");
      } else {
        print(
            "Wrong! Correct answer: ${question.options[question.correctOptionIndex - 1]}");
      }
    }

    print("\nYour total points: $totalPoints");
    if (totalPoints >= passingScore) {
      print("Congratulations! You passed the quiz.");
    } else {
      print("Sorry, you didn't pass. Try again!");
      await startQuiz(passingScore); // Retake the quiz
    }
  }
}

// Main function
void main() async {
  Quiz quiz = Quiz();
  print("Fetching questions...");
  await quiz.fetchQuestionsFromDatabase();

  const passingScore = 20; // Set the passing score
  await quiz.startQuiz(passingScore);
}
