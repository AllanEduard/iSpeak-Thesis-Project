import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            const Text(
              'Progress',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Track your improvement',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // WEEK CARD
            _weekCard(),

            const SizedBox(height: 25),

            // PERFORMANCE
            const Text(
              'Performance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _performanceCard(),

            const SizedBox(height: 25),

            // ACHIEVEMENTS
            const Text(
              'Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _achievementsGrid(),
          ],
        ),
      ),
    );
  }
}

Widget _weekCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 10),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'This Week',
              style: TextStyle(color: Colors.white70),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.bar_chart, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '8 Sessions',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // DAYS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return CircleAvatar(
              radius: 16,
              backgroundColor: index < 5 ? Colors.white : Colors.white24,
              child: index < 5
                  ? const Icon(Icons.check, size: 16, color: Colors.blueAccent)
                  : null,
            );
          }),
        ),
      ],
    ),
  );
}

Widget _performanceCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8),
      ],
    ),
    child: Column(
      children: const [
        _ProgressRow('Pace', 0.75, '+12%', Colors.blue),
        SizedBox(height: 12),
        _ProgressRow('Clarity', 0.6, '+8%', Colors.cyan),
        SizedBox(height: 12),
        _ProgressRow('Energy', 0.8, '+15%', Colors.green),
      ],
    ),
  );
}

class _ProgressRow extends StatelessWidget {
  final String title;
  final double value;
  final String percent;
  final Color color;

  const _ProgressRow(this.title, this.value, this.percent, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              percent,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 8,
        ),
      ],
    );
  }
}

Widget _achievementsGrid() {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    children: const [
      _AchievementCard(Icons.flag, 'First Speech'),
      _AchievementCard(Icons.flash_on, 'Perfect Pace'),
      _AchievementCard(Icons.local_fire_department, '7 Day Streak', locked: true),
      _AchievementCard(Icons.mic, 'Master Speaker', locked: true),
    ],
  );
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool locked;

  const _AchievementCard(this.icon, this.label, {this.locked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: locked ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!locked) const BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: locked ? Colors.grey : Colors.blueAccent,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: locked ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
