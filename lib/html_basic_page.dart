import 'package:flutter/material.dart';
import 'dart:math';

class HtmlBasicPage extends StatefulWidget {
  const HtmlBasicPage({super.key});

  @override
  State<HtmlBasicPage> createState() => _HtmlBasicPageState();
}

class _HtmlBasicPageState extends State<HtmlBasicPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = true;
  int _currentIndex = 0;

  final List<Map<String, String>> _cards = [
    {
      "term": "HTML",
      "definition":
          "HTML (HyperText Markup Language) adalah bahasa markup untuk membuat struktur halaman web."
    },
    {
      "term": "Tag",
      "definition":
          "Tag adalah penanda dalam HTML yang digunakan untuk memberi instruksi pada browser."
    },
    {
      "term": "Element",
      "definition":
          "Element adalah gabungan dari tag pembuka, isi, dan tag penutup."
    },
    {
      "term": "Attribute",
      "definition":
          "Attribute adalah informasi tambahan pada tag HTML, seperti href atau src."
    },
    {
      "term": "Heading",
      "definition":
          "Heading adalah tag judul dalam HTML yang terdiri dari h1 sampai h6."
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() {
        _currentIndex++;
        _resetCard();
      });
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _resetCard();
      });
    }
  }

  void _resetCard() {
    _isFront = true;
    _controller.reset();
  }

  Widget _buildCard(Color color, String text) {
    return Container(
      width: 260,
      height: 360,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = _cards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("FlashLearn", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("HTML Basic", style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double angle = _controller.value * pi;
              if (angle > pi / 2) angle = pi - angle;

              return Transform(
                transform: Matrix4.rotationY(angle),
                alignment: Alignment.center,
                child: _controller.value < 0.5
                    ? _buildCard(Colors.orange, card['term']!)
                    : _buildCard(Colors.blue, card['definition']!),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _prevCard,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: _nextCard,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
