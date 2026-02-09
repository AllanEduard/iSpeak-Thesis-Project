import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'progress_page.dart';
import 'package:ispeak/practice_page.dart' as practice_page;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DashBoardPage(),
      const ProgressPage(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: practice_page.practicePageBuilder));
        },
        backgroundColor: const Color(0xFF3F7CF4),
        elevation: 4,
        child: const Icon(Icons.mic, size: 28, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 8,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Home
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _currentIndex = 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, color: _currentIndex == 0 ? const Color(0xFF3F7CF4) : Colors.grey),
                      const SizedBox(height: 4),
                      Text('Home', style: TextStyle(color: _currentIndex == 0 ? const Color(0xFF3F7CF4) : Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),

              // spacer for center FAB
              const SizedBox(width: 80),

              // Right side: Progress
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _currentIndex = 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, color: _currentIndex == 1 ? const Color(0xFF3F7CF4) : Colors.grey),
                      const SizedBox(height: 4),
                      Text('Progress', style: TextStyle(color: _currentIndex == 1 ? const Color(0xFF3F7CF4) : Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
