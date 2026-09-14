import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';
import '../theme/app_theme.dart';
import 'quiz_set_screen.dart';

/// Entry point for the Quiz Test feature: shows the instructions once,
/// then lets the user pick one of the two 5-question sets to attempt.
class QuizTestScreen extends StatelessWidget {
  const QuizTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Quiz Test')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppColors.cardRadius),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  QuizData.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                _Labeled(label: 'คำชี้แจง', text: QuizData.instructions),
                const SizedBox(height: 10),
                _Labeled(label: 'เกณฑ์ความรุนแรง', text: QuizData.severityCriteria),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'เลือกชุดข้อสอบ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 10),
          _QuizSetCard(
            title: 'ชุดที่ 1',
            subtitle: 'ข้อ 1 – 5',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => QuizSetScreen(setTitle: 'Quiz Test — ชุดที่ 1', questions: QuizData.setOne()),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _QuizSetCard(
            title: 'ชุดที่ 2',
            subtitle: 'ข้อ 6 – 10',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => QuizSetScreen(setTitle: 'Quiz Test — ชุดที่ 2', questions: QuizData.setTwo()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Labeled extends StatelessWidget {
  final String label;
  final String text;

  const _Labeled({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
        ),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontSize: 13.5, color: AppColors.textMuted, height: 1.5)),
      ],
    );
  }
}

class _QuizSetCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuizSetCard({required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppColors.cardRadius);
    return Container(
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: radius, boxShadow: AppColors.cardShadow),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.primaryDark, shape: BoxShape.circle),
                  child: const Icon(Icons.quiz_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
