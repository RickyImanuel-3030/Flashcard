import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _answered = false;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Apa tag HTML untuk membuat teks tebal?',
      'options': ['<i>', '<b>', '<u>', '<strong>'],
      'answerIndex': 1,
    },
    {
      'question': 'Tag apa yang digunakan untuk membuat link?',
      'options': ['<a>', '<link>', '<href>', '<url>'],
      'answerIndex': 0,
    },
    {
      'question': 'Tag apa yang digunakan untuk menampilkan gambar?',
      'options': ['<img>', '<picture>', '<image>', '<src>'],
      'answerIndex': 0,
    },
  ];

  void _checkAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
      } else {
        // Selesai kuis
        _showFinishDialog();
      }
    });
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Kuis Selesai!'),
        content: const Text('Kamu telah menyelesaikan semua pertanyaan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('Kembali ke Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _questions[_currentQuestion];
    final options = current['options'] as List<String>;
    final correctAnswer = current['answerIndex'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          // 🖼 Background transparan
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // 📄 Konten kuis
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pertanyaan
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    current['question'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Pilihan jawaban
                ...List.generate(options.length, (index) {
                  Color buttonColor = Colors.white;
                  if (_answered) {
                    if (index == correctAnswer) {
                      buttonColor = Colors.green;
                    } else if (index == _selectedAnswer) {
                      buttonColor = Colors.red;
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _checkAnswer(index),
                      child: Text(
                        options[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 30),

                // Tombol Next
                ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
