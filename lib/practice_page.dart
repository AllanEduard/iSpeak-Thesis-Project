import 'dart:async';
import 'package:flutter/material.dart';

enum PracticeState { ready, recording, paused }

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  PracticeState _state = PracticeState.ready;
  Timer? _timer;
  int _seconds = 0;

  void _start() {
    setState(() => _state = PracticeState.recording);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() => _state = PracticeState.paused);
  }

  void _stopAndReset() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _state = PracticeState.ready;
    });
  }

  String get _time {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Practice Session', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text('Record your speech to get instant feedback', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF0F0F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              const SizedBox(height: 6),
              _recordCard(),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _metricCard('Pace', '121 WPM', 0.75, Colors.blue),
                      const SizedBox(height: 12),
                      _metricCard('Clarity', '0 fillers', 0.6, Colors.cyan),
                      const SizedBox(height: 12),
                      _metricCard('Energy', 'Good', 0.8, Colors.green),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              _finishButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recordCard() {
    final isRecording = _state == PracticeState.recording;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (_state == PracticeState.ready) {
                _start();
              } else if (_state == PracticeState.recording) {
                _pause();
              } else {
                _start();
              }
            },
            child: CircleAvatar(
              radius: 42,
              backgroundColor: isRecording ? Colors.redAccent : Colors.blue,
              child: Icon(
                isRecording ? Icons.pause : Icons.mic,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _state == PracticeState.ready
                ? 'Ready to Record'
                : _state == PracticeState.recording
                    ? 'Recording...'
                    : 'Paused',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            _time,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _metricCard(String title, String value, double progress, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation(color), minHeight: 8),
          const SizedBox(height: 6),
          Text(_helperForMetric(title), style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  String _helperForMetric(String title) {
    switch (title) {
      case 'Pace':
        return 'Optimal pace range: 120-150 WPM';
      case 'Clarity':
        return 'Perfect! No filler words';
      case 'Energy':
        return 'Try to project more energy';
      default:
        return '';
    }
  }

  Widget _finishButton() {
    return SafeArea(
      top: false,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F7CF4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            // stop and return
            _stopAndReset();
            Navigator.of(context).maybePop();
          },
          child: const Text('Finish & View Results'),
        ),
      ),
    );
  }
}

// Helper builder exported for other files to push/open the practice page.
Widget practicePageBuilder(BuildContext context) => const PracticePage();
