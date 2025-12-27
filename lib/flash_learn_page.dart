import 'package:flutter/material.dart';

class FlashLearnPage extends StatefulWidget {
  const FlashLearnPage({super.key});

  @override
  State<FlashLearnPage> createState() => _FlashLearnPageState();
}

class _FlashLearnPageState extends State<FlashLearnPage> {
  int _selectedIndex = 1; // 0 = Home, 1 = FlashLearn, 2 = Quiz

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // tetap di halaman ini
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/quiz');
    }
  }

  Widget _buildFlashButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.withOpacity(0.9),
          minimumSize: const Size(double.infinity, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlashLearn"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          // 🖼️ Gambar background transparan
          Opacity(
            opacity: 0.2, // atur tingkat transparansi (0.0 - 1.0)
            child: Image.asset(
              'assets/image.png', // ganti sesuai nama file gambarmu
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // 📱 Konten utama di atas background
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Spacer(flex: 1),
                _buildFlashButton("HTML BASICS", () {
                  Navigator.pushNamed(context, '/html_basic');
                }),
                _buildFlashButton("TEXT FORMAT", () {
                  Navigator.pushNamed(context, '/text_format');// pindah ke halaman materi Text Format
                }),
                _buildFlashButton("LINK & IMAGE", () {
                  Navigator.pushNamed(context, '/link_image');// pindah ke halaman materi Link & Image
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'FlashLearn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
        ],
      ),
    );
  }
}
