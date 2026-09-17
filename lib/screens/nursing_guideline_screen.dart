import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/placeholder_detail_screen.dart';
import 'mild_head_injury_screen.dart';
import 'moderate_head_injury_screen.dart';
import 'severe_head_injury_screen.dart';

Widget _mildHeadInjuryBuilder(BuildContext context) => const MildHeadInjuryScreen();
Widget _moderateHeadInjuryBuilder(BuildContext context) => const ModerateHeadInjuryScreen();
Widget _severeHeadInjuryBuilder(BuildContext context) => const SevereHeadInjuryScreen();

/// "แนวทางการพยาบาล" (Nursing guideline) reference page, reached from the
/// GCS result card and from the Knowledge tab. Summarises the standard
/// primary-survey checklist, how to record a Not-Testable sub-score, and
/// lets the nurse drill into guidance for a specific head-injury severity.
class NursingGuidelineScreen extends StatelessWidget {
  const NursingGuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'แนวทางการพยาบาล',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        children: const [
          _KeyPointCard(),
          SizedBox(height: 12),
          _PrimarySurveyCard(),
          SizedBox(height: 12),
          _NotTestableCard(),
          SizedBox(height: 12),
          _SeverityPickerCard(),
          SizedBox(height: 12),
          _FooterNote(),
        ],
      ),
    );
  }
}

/// Shared rounded-card chrome used by every section below the header.
class _Card extends StatelessWidget {
  final Color background;
  final Widget child;

  const _Card({required this.background, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: child,
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SectionHeading({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryDark, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _KeyPointCard extends StatelessWidget {
  const _KeyPointCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      background: const Color(0xFFFDECEA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'ข้อสำคัญ',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.danger,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'ระดับ GCS เป็นเพียงส่วนหนึ่งของการประเมิน ไม่ควรกำหนดการพยาบาลจากคะแนน '
            'GCS เพียงอย่างเดียว ควรพิจารณาร่วมกับ CT brain การเปลี่ยนแปลงของอาการ '
            'ระบบหายใจ ความดันโลหิต การใช้ยาต้านการแข็งตัวของเลือด '
            'และแผนการรักษาของแพทย์',
            style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF8A3A33)),
          ),
        ],
      ),
    );
  }
}

class _NumberedStep {
  final String label;
  final IconData icon;
  final String title;
  final String subtitle;

  const _NumberedStep({
    required this.label,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _PrimarySurveyCard extends StatelessWidget {
  const _PrimarySurveyCard();

  static const _steps = [
    _NumberedStep(
      label: '1',
      icon: Icons.face_retouching_natural_rounded,
      title: 'A – Airway with C-spine protection',
      subtitle: 'ประเมินทางเดินหายใจและป้องกันกระดูกสันหลังส่วนคอ',
    ),
    _NumberedStep(
      label: '2',
      icon: Icons.air_rounded,
      title: 'B – Breathing and Ventilation',
      subtitle: 'ประเมินการหายใจและการระบายอากาศ',
    ),
    _NumberedStep(
      label: '3',
      icon: Icons.favorite_rounded,
      title: 'C – Circulation with Hemorrhage Control',
      subtitle: 'ประเมินการไหลเวียนโลหิตและควบคุมเลือดออก',
    ),
    _NumberedStep(
      label: '4',
      icon: Icons.psychology_rounded,
      title: 'D – Disability/Neurological Assessment',
      subtitle: 'ประเมินระบบประสาทอย่างรวดเร็ว',
    ),
    _NumberedStep(
      label: '5',
      icon: Icons.thermostat_rounded,
      title: 'E – Exposure and Environment Control',
      subtitle: 'ตรวจร่างกายทั่วตัวและควบคุมอุณหภูมิ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      background: const Color(0xFFEDF9F3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            icon: Icons.fact_check_rounded,
            title: 'การประเมินพื้นฐานสำหรับผู้ป่วยทุกระดับ',
            subtitle: 'ดำเนินการประเมินและดูแลอย่างเป็นระบบ',
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Column(
              children: [
                for (final step in _steps)
                  _StepRow(step: step, showDivider: step != _steps.last),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final _NumberedStep step;
  final bool showDivider;

  const _StepRow({required this.step, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  step.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(step.icon, size: 20, color: AppColors.primaryDark),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      step.subtitle,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
      ],
    );
  }
}

class _NotTestableRow {
  final String label;
  final String description;

  const _NotTestableRow({required this.label, required this.description});
}

class _NotTestableCard extends StatelessWidget {
  const _NotTestableCard();

  static const _rows = [
    _NotTestableRow(label: 'E-NT', description: 'บันทึก ENT–V–M ระบุสาเหตุ และไม่รวมคะแนน'),
    _NotTestableRow(label: 'V-NT', description: 'บันทึก E–VNT–M ระบุสาเหตุ และไม่รวมคะแนน'),
    _NotTestableRow(label: 'M-NT', description: 'บันทึก E–V–MNT ระบุสาเหตุ และไม่รวมคะแนน'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      background: const Color(0xFFEDF9F3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            icon: Icons.assignment_late_rounded,
            title: 'กรณีประเมินเป็น NT',
            subtitle: 'ไม่สามารถประเมินได้ ให้บันทึกรูปแบบและระบุสาเหตุ',
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Column(
              children: [
                for (final row in _rows)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                row.label,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                row.description,
                                style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (row != _rows.last)
                        Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.danger,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'ใช้ GCS ก่อนเกิดข้อจำกัดเป็นแนวทางการพยาบาลเบื้องต้น',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeverityLevel {
  final String titleEn;
  final String scoreRange;
  final Color color;
  final WidgetBuilder? pageBuilder;

  const _SeverityLevel({
    required this.titleEn,
    required this.scoreRange,
    required this.color,
    this.pageBuilder,
  });
}

class _SeverityPickerCard extends StatelessWidget {
  const _SeverityPickerCard();

  static const _levels = [
    _SeverityLevel(
      titleEn: 'Mild Head Injury',
      scoreRange: 'GCS 13–15',
      color: AppColors.primaryDark,
      pageBuilder: _mildHeadInjuryBuilder,
    ),
    _SeverityLevel(
      titleEn: 'Moderate Head Injury',
      scoreRange: 'GCS 9–12',
      color: Color(0xFFC97A1E),
      pageBuilder: _moderateHeadInjuryBuilder,
    ),
    _SeverityLevel(
      titleEn: 'Severe Head Injury',
      scoreRange: 'GCS 3–8',
      color: AppColors.danger,
      pageBuilder: _severeHeadInjuryBuilder,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      background: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            icon: Icons.psychology_rounded,
            title: 'เลือกระดับการบาดเจ็บที่ศีรษะ',
            subtitle: 'เพื่อดูแนวทางการพยาบาลเฉพาะระดับ',
          ),
          const SizedBox(height: 10),
          for (final level in _levels) ...[
            _SeverityRow(level: level),
            if (level != _levels.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _SeverityRow extends StatelessWidget {
  final _SeverityLevel level;

  const _SeverityRow({required this.level});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: level.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: level.pageBuilder ??
                (_) => PlaceholderDetailScreen(
                      title: level.titleEn,
                      icon: Icon(Icons.psychology_rounded, size: 96, color: level.color),
                      description:
                          'แนวทางการพยาบาลผู้ป่วยบาดเจ็บที่ศีรษะระดับ ${level.titleEn} (${level.scoreRange})',
                    ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.psychology_rounded, color: level.color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 14.5, color: AppColors.textDark),
                    children: [
                      TextSpan(
                        text: level.titleEn,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '  |  ${level.scoreRange}'),
                    ],
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: level.color),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'ใช้เพื่อสนับสนุนการประเมิน ไม่ใช่แทนวิจารณญาณทางคลินิก',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11.5, color: AppColors.textMuted),
      ),
    );
  }
}
