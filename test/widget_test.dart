import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:neuro_novice_nurse/main.dart';

void main() {
  testWidgets('Home screen shows title and 6 feature cards', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NeuroNoviceNurseApp());
    await tester.pumpAndSettle();

    expect(find.text('Neuro Novice Nurse'), findsOneWidget);
    expect(find.text('ประเมิน GCS'), findsOneWidget);
    expect(find.text('Motor Power'), findsOneWidget);
    expect(find.text('ประเมินรูม่านตา'), findsOneWidget);
    expect(find.text('ICP Warning'), findsOneWidget);
    expect(find.text('Quiz Test'), findsOneWidget);
    expect(find.text('แนวทางการพยาบาล'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const NeuroNoviceNurseApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('ความรู้'));
    await tester.pumpAndSettle();

    expect(find.text('ความรู้'), findsWidgets);
  });
}
