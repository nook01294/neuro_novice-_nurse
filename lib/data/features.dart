import '../models/feature_item.dart';
import '../screens/gcs_assess_screen.dart';
import '../screens/icp_warning_screen.dart';
import '../screens/motor_power_screen.dart';
import '../screens/nursing_guideline_screen.dart';
import '../screens/pupil_screen.dart';
import '../screens/quiz_test_screen.dart';
import '../widgets/icons/gcs_png_icon.dart';
import '../widgets/icons/guidelines_png_icon.dart';
import '../widgets/icons/icp_warning_png_icon.dart';
import '../widgets/icons/motor_power_png_icon.dart';
import '../widgets/icons/quiz_test_png_icon.dart';
import '../widgets/icons/pupil_png_icon.dart';

/// Single source of truth for the app's main features, reused by the Home
/// grid and the Knowledge tab.
class Features {
  Features._();

  static final gcs = FeatureItem(
    title: 'ประเมิน GCS',
    iconBuilder: (size) => GcsPngIcon(size: size),
    pageBuilder: (_) => const GcsAssessScreen(),
  );

  static final motorPower = FeatureItem(
    title: 'Motor Power',
    iconBuilder: (size) => MotorPowerPngIcon(size: size),
    pageBuilder: (_) => const MotorPowerScreen(),
  );

  static final pupil = FeatureItem(
    title: 'ประเมินรูม่านตา',
    iconBuilder: (size) => PupilPngIcon(size: size),
    pageBuilder: (_) => const PupilScreen(),
  );

  static final icpWarning = FeatureItem(
    title: 'ICP Warning',
    iconBuilder: (size) => IcpWarningPngIcon(size: size),
    pageBuilder: (_) => const IcpWarningScreen(),
  );

  static final quizTest = FeatureItem(
    title: 'Quiz Test',
    iconBuilder: (size) => QuizTestPngIcon(size: size),
    pageBuilder: (_) => const QuizTestScreen(),
  );

  static final guidelines = FeatureItem(
    title: 'แนวทางการพยาบาล',
    iconBuilder: (size) => GuidelinesPngIcon(size: size),
    pageBuilder: (_) => const NursingGuidelineScreen(),
  );

  static final List<FeatureItem> all = [
    gcs,
    guidelines,
    motorPower,
    pupil,
    icpWarning,
    quizTest,
  ];

  static final List<FeatureItem> knowledge = [guidelines];
}
