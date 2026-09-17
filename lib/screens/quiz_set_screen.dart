import 'dart:math';

import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/usage_log_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

const _optionLetters = ['A', 'B', 'C', 'D'];

/// Runs one 5-question set of the Quiz Test: one question per screen,
/// answer confirmation with immediate reveal, then a final score summary.
/// Question order and each question's option order are reshuffled every
/// time this screen is opened.
class QuizSetScreen extends StatefulWidget {
  final String setId;
  final String setTitle;
  final List<QuizQuestion> questions;

  const QuizSetScreen({
    super.key,
    required this.setId,
    required this.setTitle,
    required this.questions,
  });

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
      UsageLogService.instance.logQuizResult(
        setId: widget.setId,
        setTitle: widget.setTitle,
        score: _score,
        total: _questions.length,
      );
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
    return BackgroundScaffold(
      title: widget.setTitle,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'คำถามที่ ${_index + 1} จาก ${_questions.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textOnBackground,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  tween: Tween(
                    begin: 0,
                    end: (_index + (_answered ? 1 : 0)) / _questions.length,
                  ),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    backgroundColor: AppColors.fieldFill,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppColors.cardRadius),
                  boxShadow: AppColors.cardShadow,
                  border: Border.all(color: AppColors.fieldBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.format_quote_rounded, size: 20, color: AppColors.primary.withValues(alpha: 0.5)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        question.scenario,
                        style: const TextStyle(fontSize: 15.5, color: AppColors.textDark, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < question.options.length; i++) ...[
                _OptionTile(
                  // Keyed per-question so Flutter builds fresh tiles (no
                  // carried-over AnimatedContainer transition) when moving
                  // to the next question, instead of animating the old
                  // answered colors into the new question's neutral state.
                  key: ValueKey('quiz_${_index}_option_$i'),
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
    Color tileTint = AppColors.cardBackground;

    if (answered) {
      if (option.isCorrect) {
        borderColor = AppColors.primary;
        badgeColor = AppColors.primary.withValues(alpha: 0.18);
        badgeTextColor = AppColors.primaryDark;
        tileTint = AppColors.primary.withValues(alpha: 0.06);
      } else if (selected) {
        borderColor = AppColors.danger;
        badgeColor = AppColors.danger.withValues(alpha: 0.15);
        badgeTextColor = AppColors.danger;
        tileTint = AppColors.danger.withValues(alpha: 0.05);
      }
    } else if (selected) {
      borderColor = AppColors.primaryDark;
      badgeColor = AppColors.primaryDark;
      badgeTextColor = Colors.white;
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: answered ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: tileTint,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: selected || (answered && option.isCorrect) ? 2 : 1),
            boxShadow: selected && !answered
                ? [BoxShadow(color: AppColors.primaryDark.withValues(alpha: 0.15), blurRadius: 10, offset: const Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
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
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 20,
                    child: answered
                        ? Icon(
                            option.isCorrect ? Icons.check_circle : (selected ? Icons.cancel : null),
                            color: option.isCorrect ? AppColors.primaryDark : AppColors.danger,
                            size: 20,
                          )
                        : null,
                  ),
                ],
              ),
              if (answered && selected) ...[
                const SizedBox(height: 12),
                Divider(height: 1, thickness: 1, color: borderColor.withValues(alpha: 0.3)),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: option.isCorrect
                            ? AppColors.primary.withValues(alpha: 0.16)
                            : AppColors.danger.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        option.isCorrect ? 'ถูกต้อง' : 'ไม่ถูกต้อง',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: option.isCorrect ? AppColors.primaryDark : AppColors.danger,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
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
    final perfect = score == total;
    final color = passed ? AppColors.primaryDark : AppColors.danger;
    final message = perfect
        ? 'ยอดเยี่ยมมาก! ตอบถูกครบทุกข้อ'
        : (passed ? 'ทำได้ดีมาก ผ่านเกณฑ์แล้ว' : 'ลองทบทวนแล้วทำใหม่อีกครั้งนะ');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 108,
              height: 108,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.12),
                border: Border.all(color: color.withValues(alpha: 0.25), width: 3),
              ),
              child: Icon(
                perfect
                    ? Icons.emoji_events_rounded
                    : (passed ? Icons.check_circle_rounded : Icons.refresh_rounded),
                size: 56,
                color: color,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'สรุปผลคะแนน',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              'ตอบถูก $score จาก $total ข้อ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              '${(score / total * 100).round()}%',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: AppColors.textDark),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
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
