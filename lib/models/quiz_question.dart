import 'dart:math';

/// One selectable answer for a [QuizQuestion].
///
/// [explanation] is stored without its original "A ถูก:" / "B ผิด:" prefix
/// so it stays correct after options are shuffled into a new A–D order —
/// correctness is shown from [isCorrect] instead of re-parsing the text.
class QuizOption {
  final String choiceText;
  final String explanation;
  final bool isCorrect;

  const QuizOption({
    required this.choiceText,
    required this.explanation,
    required this.isCorrect,
  });
}

class QuizQuestion {
  final String scenario;
  final List<QuizOption> options;

  const QuizQuestion({required this.scenario, required this.options});

  /// Returns a copy with its options shuffled into a new order.
  QuizQuestion shuffled(Random random) {
    final shuffledOptions = List<QuizOption>.from(options)..shuffle(random);
    return QuizQuestion(scenario: scenario, options: shuffledOptions);
  }
}
