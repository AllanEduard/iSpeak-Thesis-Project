import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  bool _isEnglishSelected = true;
  
  final _englishOverall = 87;
  final _englishSkills = [
    {'label': 'Pace', 'score': 85, 'value': 0.85},
    {'label': 'Clarity', 'score': 92, 'value': 0.92},
    {'label': 'Energy', 'score': 80, 'value': 0.80},
  ];

  final _filipinoOverall = 84;
  final _filipinoSkills = [
    {'label': 'Pace', 'score': 78, 'value': 0.78},
    {'label': 'Clarity', 'score': 88, 'value': 0.88},
    {'label': 'Energy', 'score': 85, 'value': 0.85},
  ];

  final List<double?> _dailyScores = [88.0, 85.0, 90.0, 87.0, 86.0, null, null];
  final List<String> _dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  Color _barColor(double score) {
    if (score >= 85) return const Color(0xFF4CAF50);
    if (score >= 70) return const Color(0xFFFFC107);
    return const Color(0xFFFF9800);
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = _isEnglishSelected;
    final overall = isEnglish ? _englishOverall : _filipinoOverall;
    final skills = isEnglish ? _englishSkills : _filipinoSkills;
    final accentColor = isEnglish ? const Color(0xFF3F7CF4) : const Color(0xFFF5A623);
    final bgColor = isEnglish ? const Color(0xFFF0F4FF) : const Color(0xFFFFF8EE);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor,
                        accentColor.withValues(alpha: 0.8), // ✅ Fixed
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Track your improvement over time',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                _buildWeeklySummary(accentColor),

                const SizedBox(height: 20),

                // ── Performance Trends ───────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Performance Trends',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(height: 20),
                        _perfRow('Pace', 'Steady improvement in rate', 0.72, '+8%', accentColor),
                        const SizedBox(height: 18),
                        _perfRow('Clarity', 'Clear and articulate delivery', 0.85, '+12%', accentColor),
                        const SizedBox(height: 18),
                        _perfRow('Energy', 'Consistently high energy', 0.8, '+15%', accentColor),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildSkillsBreakdown(accentColor, bgColor, isEnglish, skills, overall),

                const SizedBox(height: 20),

                _buildDailyChart(),

                const SizedBox(height: 20),

                // ── Session History ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Session History',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 14),
                      _historyCard('Session #4', 'Feb 2, 2026', '86', accentColor),
                      const SizedBox(height: 10),
                      _historyCard('Session #3', 'Jan 28, 2026', '85', accentColor),
                      const SizedBox(height: 10),
                      _historyCard('Session #2', 'Jan 27, 2026', '78', accentColor),
                      const SizedBox(height: 10),
                      _historyCard('Session #1', 'Jan 25, 2026', '82', accentColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04), // ✅ Fixed
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _buildWeeklySummary(Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity This Week',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              '3 Sessions',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: accentColor),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(7, (index) {
                const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                final bool done = index < 3;
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        labels[index],
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 8),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: done ? accentColor : Colors.grey.shade100,
                        child: done
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsBreakdown(
      Color accentColor, Color bgColor, bool isEnglish, List skills, int overall) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Skills Breakdown',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      _toggleBtn(
                        'English',
                        _isEnglishSelected,
                        const Color(0xFF3F7CF4),
                        () => setState(() => _isEnglishSelected = true),
                      ),
                      _toggleBtn(
                        'Filipino',
                        !_isEnglishSelected,
                        const Color(0xFFF5A623),
                        () => setState(() => _isEnglishSelected = false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Overall performance banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stars_rounded, color: accentColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        isEnglish ? 'ENGLISH SCORE' : 'FILIPINO SCORE',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$overall%',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'Overall Performance',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Skill bars
            ...skills.map((skill) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          skill['label'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          '${skill['score']}%',
                          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: skill['value'] as double,
                        backgroundColor: Colors.grey.shade100,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Performance',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['100', '75', '50', '25', '0']
                        .map((e) => Text(
                              e,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ))
                        .toList(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(7, (i) {
                        final score = _dailyScores[i];
                        final hasSession = score != null;
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: hasSession ? (score / 100) * 140 : 10,
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  color: hasSession ? _barColor(score) : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _dayLabels[i],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleBtn(String label, bool active, Color activeColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3), // ✅ Fixed
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.grey.shade600,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _perfRow(
      String title, String subtitle, double value, String change, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(
              change,
              style: TextStyle(color: accentColor, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: accentColor.withValues(alpha: 0.1), // ✅ Fixed
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _historyCard(String title, String date, String score, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1), // ✅ Fixed
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              score,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}