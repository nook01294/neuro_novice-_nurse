import '../models/feature_item.dart';
import '../screens/gcs_assess_screen.dart';
import '../screens/nursing_guideline_screen.dart';
import '../screens/quiz_test_screen.dart';
import '../widgets/icons/gcs_png_icon.dart';
import '../widgets/icons/guidelines_png_icon.dart';
import '../widgets/icons/icp_warning_png_icon.dart';
import '../widgets/icons/motor_power_png_icon.dart';
import '../widgets/icons/quiz_test_png_icon.dart';
import '../widgets/icons/pupil_png_icon.dart';
import '../widgets/placeholder_detail_screen.dart';

/// Single source of truth for the app's 6 main features.
/// Reused by the Home grid, the Assess tab, and the Monitor tab.
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
    pageBuilder: (_) => PlaceholderDetailScreen(
      title: 'Motor Power',
      icon: const MotorPowerPngIcon(size: 96),
      description: 'เครื่องมือประเมินกำลังกล้ามเนื้อของผู้ป่วย',
    ),
  );

  static final pupil = FeatureItem(
    title: 'ประเมินรูม่านตา',
    iconBuilder: (size) => PupilPngIcon(size: size),
    pageBuilder: (_) => PlaceholderDetailScreen(
      title: 'ประเมินรูม่านตา',
      icon: const PupilPngIcon(size: 96),
      description: 'เครื่องมือตรวจขนาดและการตอบสนองต่อแสงของรูม่านตา\n(Pupillary Light Reflex)',
    ),
  );

  static final icpWarning = FeatureItem(
    title: 'ICP Warning',
    iconBuilder: (size) => IcpWarningPngIcon(size: size),
    pageBuilder: (_) => PlaceholderDetailScreen(
      title: 'ICP Warning',
      icon: const IcpWarningPngIcon(size: 96),
      description: 'ระบบเฝ้าระวังและเตือนภัยภาวะความดันในกะโหลกศีรษะสูง\n(Increased Intracranial Pressure)',
    ),
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
    motorPower,
    pupil,
    icpWarning,
    quizTest,
    guidelines,
  ];

  static final List<FeatureItem> assessment = [gcs, motorPower, pupil];
  static final List<FeatureItem> monitoring = [icpWarning, quizTest];
  static final List<FeatureItem> knowledge = [guidelines];
}
