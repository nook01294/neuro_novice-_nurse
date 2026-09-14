import 'dart:math';

import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../theme/app_theme.dart';

const _optionLetters = ['A', 'B', 'C', 'D'];

/// Runs one 5-question set of the Quiz Test: one question per screen,
/// answer confirmation with immediate reveal, then a final score summary.
/// Question order and each question's option order are reshuffled every
/// time this screen is opened.
class QuizSetScreen extends StatefulWidget {
  final String setTitle;
  final List<QuizQuestion> questions;

  const QuizSetScreen({super.key, required this.setTitle, required this.questions});

  @override
  State<QuizSetScreen> createState() => _QuizSetScreenState();
}

class _QuizSetScreenState extends State<QuizSetScreen> {
  late List<QuizQuestion> _questions;
  int _index = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
  }

  void _shuffleQuestions() {
    final random = Random();
    _questions = (List<QuizQuestion>.from(widget.questions)..shuffle(random))
        .map((q) => q.shuffled(random))
        .toList();
  }

  void _restart() {
    setState(() {
      _shuffleQuestions();
      _index = 0;
      _selected = null;
      _answered = false;
      _score = 0;
      _finished = false;
    });
  }

  void _select(int optionIndex) {
    if (_answered) return;
    setState(() => _selected = optionIndex);
  }

  void _confirm() {
    if (_selected == null || _answered) return;
    final correct = _questions[_index].options[_selected!].isCorrect;
    setState(() {
      _answered = true;
      if (correct) _score++;
    });
  }

  void _next() {
    if (_index == _questions.length - 1) {
      setState(() => _finished = true);
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(widget.setTitle)),
      body: SafeArea(
        child: _finished ? _ScoreSummary(score: _score, total: _questions.length, onRetry: _restart) : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_index];
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            children: [
              Text(
                'คำถามที่ ${_index + 1} จาก ${_questions.length}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: (_index + (_answered ? 1 : 0)) / _questions.length,
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
                backgroundColor: AppColors.fieldFill,
                color: AppColors.primary,
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppColors.cardRadius),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Text(
                  question.scenario,
                  style: const TextStyle(fontSize: 15.5, color: AppColors.textDark, height: 1.5),
                ),
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < question.options.length; i++) ...[
                _OptionTile(
                  key: ValueKey('quiz_option_$i'),
                  letter: _optionLetters[i],
                  option: question.options[i],
                  selected: _selected == i,
                  answered: _answered,
                  onTap: () => _select(i),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
        SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: !_answered
                  ? (_selected != null ? _confirm : null)
                  : _next,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                !_answered
                    ? 'ยืนยันคำตอบ'
                    : (_index == _questions.length - 1 ? 'ดูผลคะแนน' : 'ข้อถัดไป'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String letter;
  final QuizOption option;
  final bool selected;
  final bool answered;
  final VoidCallback onTap;

  const _OptionTile({
    super.key,
    required this.letter,
    required this.option,
    required this.selected,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.fieldBorder;
    Color badgeColor = AppColors.primary.withValues(alpha: 0.15);
    Color badgeTextColor = AppColors.primaryDark;

    if (answered) {
      if (option.isCorrect) {
        borderColor = AppColors.primary;
        badgeColor = AppColors.primary.withValues(alpha: 0.18);
        badgeTextColor = AppColors.primaryDark;
      } else if (selected) {
        borderColor = AppColors.danger;
        badgeColor = AppColors.danger.withValues(alpha: 0.15);
        badgeTextColor = AppColors.danger;
      }
    } else if (selected) {
      borderColor = AppColors.primaryDark;
    }

    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: answered ? null : onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: selected || (answered && option.isCorrect) ? 2 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
                    child: Text(
                      letter,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: badgeTextColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option.choiceText,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  if (answered)
                    Icon(
                      option.isCorrect ? Icons.check_circle : (selected ? Icons.cancel : null),
                      color: option.isCorrect ? AppColors.primaryDark : AppColors.danger,
                      size: 20,
                    ),
                ],
              ),
              if (answered) ...[
                const Divider(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        option.isCorrect ? 'ถูกต้อง' : 'ไม่ถูกต้อง',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: option.isCorrect ? AppColors.primaryDark : AppColors.danger,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        option.explanation,
                        style: const TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreSummary extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRetry;

  const _ScoreSummary({required this.score, required this.total, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final passed = score >= (total / 2).ceil();
    final color = passed ? AppColors.primaryDark : AppColors.danger;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(passed ? Icons.emoji_events_rounded : Icons.refresh_rounded, size: 72, color: color),
            const SizedBox(height: 20),
            const Text(
              'สรุปผลคะแนน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              'ตอบถูก $score จาก $total ข้อ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              '${(score / total * 100).round()}%',
              style: const TextStyle(fontSize: 16, color: AppColors.textMuted),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('ทำชุดนี้อีกครั้ง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryDark),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  'กลับหน้าหลัก',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
