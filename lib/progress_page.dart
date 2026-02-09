import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF5F7FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top blue header area
              Container(
                width: double.infinity,
                color: const Color(0xFF3F7CF4),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 6),
                    Text(
                      'Your Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Track your improvement over time',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Overlapping white card
              Transform.translate(
                offset: const Offset(0, -28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 8),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('This Week', style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('3 Sessions', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF3F7CF4))),
                                SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Weekdays with aligned labels and circles
                            Row(
                              children: List.generate(7, (index) {
                                const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                                final bool done = index < 3;
                                return Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        labels[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: done ? const Color(0xFF3F7CF4) : Colors.grey.shade200,
                                        child: done ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Performance card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Performance Trends', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            _perfRow('Pace', 'Average: 119 WPM', 0.75, '+12%'),
                            const SizedBox(height: 12),
                            _perfRow('Clarity', 'Avg filler words: 4 per session', 0.6, '+8%'),
                            const SizedBox(height: 12),
                            _perfRow('Energy', 'Consistently high energy', 0.8, '+15%'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Session history
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Session History', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          _historyCard('Session #4', 'Feb 2, 2026', '86'),
                          const SizedBox(height: 8),
                          _historyCard('Session #3', 'Jan 28, 2026', '85'),
                          const SizedBox(height: 8),
                          _historyCard('Session #2', 'Jan 27, 2026', '78'),
                          const SizedBox(height: 8),
                          _historyCard('Session #1', 'Jan 25, 2026', '82'),
                        ],
                      ),

                      const SizedBox(height: 40),
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

Widget _perfRow(String title, String subtitle, double value, String change) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(change, style: const TextStyle(color: Color(0xFF3F7CF4), fontWeight: FontWeight.bold)),
        ],
      ),
      const SizedBox(height: 6),
      LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.grey.shade200,
        valueColor: const AlwaysStoppedAnimation(Color(0xFF3F7CF4)),
        minHeight: 8,
      ),
      const SizedBox(height: 6),
      Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  );
}

Widget _historyCard(String title, String date, String score) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Text(score, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF3F7CF4))),
      ],
    ),
  );
}
