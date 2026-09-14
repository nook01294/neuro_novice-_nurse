import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:neuro_novice_nurse/screens/quiz_test_screen.dart';

void main() {
  testWidgets('Quiz Test: instructions, take set 1, answer all 5, see score', (tester) async {
    tester.view.physicalSize = const Size(800, 3600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: QuizTestScreen()));
    await tester.pumpAndSettle();

    expect(find.text('คำชี้แจง'), findsOneWidget);
    expect(find.text('ชุดที่ 1'), findsOneWidget);
    expect(find.text('ชุดที่ 2'), findsOneWidget);

    await tester.tap(find.text('ชุดที่ 1'));
    await tester.pumpAndSettle();

    for (var i = 0; i < 5; i++) {
      expect(find.text('คำถามที่ ${i + 1} จาก 5'), findsOneWidget);

      // No explanation visible before answering.
      expect(find.text('ถูกต้อง'), findsNothing);

      final confirmButton = find.text('ยืนยันคำตอบ');
      expect(confirmButton, findsOneWidget);

      // Select the first option, then confirm.
      await tester.tap(find.byKey(ValueKey('quiz_${i}_option_0')));
      await tester.pump();
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      // Reveal: explanation shown for the selected option only (correct or not).
      final revealCount = find.text('ถูกต้อง').evaluate().length + find.text('ไม่ถูกต้อง').evaluate().length;
      expect(revealCount, 1);

      final nextLabel = i == 4 ? 'ดูผลคะแนน' : 'ข้อถัดไป';
      await tester.tap(find.text(nextLabel));
      await tester.pumpAndSettle();
    }

    expect(find.text('สรุปผลคะแนน'), findsOneWidget);
    expect(find.textContaining('จาก 5 ข้อ'), findsOneWidget);
  });
}
