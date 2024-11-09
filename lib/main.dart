import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: const QuizScreen(),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;

  Question(
      {required this.questionText,
      required this.answers,
      required this.correctAnswer});
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [
    Question(
      questionText: "Thủ đô của Pháp là gì?",
      answers: ["Berlin", "Madrid", "Paris", "Rome"],
      correctAnswer: "Paris",
    ),
    Question(
      questionText: "Căn bậc hai của 64 là gì?",
      answers: ["6", "7", "8", "9"],
      correctAnswer: "8",
    ),
    Question(
      questionText:
          "Ai là cầu thủ ghi nhiều bàn thắng nhất trong lịch sử World Cup?",
      answers: ["Ronaldo Nazário", "Lionel Messi", "Miroslav Klose", "Pele"],
      correctAnswer: "Miroslav Klose",
    ),
    Question(
      questionText: "Tìm giá trị của x trong phương trình: 3x - 4 = 11.",
      answers: ["3", "5", "7", "6"],
      correctAnswer: "5",
    ),
    Question(
      questionText: "Câu lạc bộ bóng đá nào có biệt danh là (Quỷ đỏ)?",
      answers: ["Manchester United", "Chelsea", "Arsenal", "Arsenal"],
      correctAnswer: "Manchester United",
    ),
    Question(
      questionText: "Tìm giá trị của x trong phương trình: 3x - 4 = 11.",
      answers: ["3", "5", "7", "6"],
      correctAnswer: "5",
    ),
    Question(
      questionText:
          "Nước có nhiệt độ sôi là bao nhiêu độ C ở áp suất khí quyển bình thường?",
      answers: ["50°C", "75°C", "100°C", "150°C"],
      correctAnswer: "100°C",
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  String selectedAnswer = "";
  String feedbackMessage = "";

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        score++;
        feedbackMessage = "Chúc mừng! Bạn đã chọn đáp án đúng!";
      } else {
        feedbackMessage = "Rất tiếc, đáp án sai. Hãy thử lại!";
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        isAnswered = false;
        selectedAnswer = "";
        feedbackMessage = "";
      } else {
        // Display final score when quiz is completed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Quiz Completed", textAlign: TextAlign.center),
            content: Text("Your score: $score/${questions.length}",
                textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetQuiz();
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      isAnswered = false;
      selectedAnswer = "";
      feedbackMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Color.fromARGB(255, 74, 235, 219)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex].questionText,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Arial',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            for (var answer in questions[currentQuestionIndex].answers)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: isAnswered ? null : () => checkAnswer(answer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAnswered && answer == selectedAnswer
                        ? (answer ==
                                questions[currentQuestionIndex].correctAnswer
                            ? Colors.green
                            : Colors.red)
                        : Colors.tealAccent,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (isAnswered)
              Column(
                children: [
                  Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: feedbackMessage.contains("Chúc mừng")
                          ? Colors.green
                          : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      currentQuestionIndex < questions.length - 1
                          ? 'Next Question'
                          : 'Finish Quiz',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
