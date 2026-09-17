import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

/// "Pupil Assessment" reference page — explains how to evaluate pupil
/// shape, position, equality, size, and light-reflex response
/// (Pupillary Light Reflex) between the left and right eyes.
class PupilScreen extends StatelessWidget {
  const PupilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'ประเมินรูม่านตา',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 20),
          _EyeDiagramCard(),
          SizedBox(height: 10),
          _EyeDiagramCaption(),
          SizedBox(height: 16),
          _StepsCard(),
          SizedBox(height: 12),
          _TechniqueCard(),
          SizedBox(height: 12),
          _WarningCard(),
        ],
      ),
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'การประเมินรูม่านตาและปฏิกิริยาต่อแสง (Pupillary Light Reflex) ใช้ตรวจหาความผิดปกติ '
      'ทางระบบประสาท โดยประเมินรูปร่าง ตำแหน่ง ความเท่ากัน ขนาด (mm) และปฏิกิริยาต่อแสง '
      'แยกตาทั้งสองข้าง',
      style: TextStyle(fontSize: 14.5, height: 1.6, color: AppColors.textOnBackground),
    );
  }
}

/// Card with the reference eye illustration showing the four things to
/// assess per eye: shape, position, equality, and size.
class _EyeDiagramCard extends StatelessWidget {
  const _EyeDiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/S__5300254.jpg',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _EyeDiagramCaption extends StatelessWidget {
  const _EyeDiagramCaption();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ประเมินรูปร่าง ตำแหน่ง ความเท่ากัน ขนาด และปฏิกิริยาต่อแสงแยกตาทั้งสองข้าง',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textDark),
    );
  }
}

class _Step {
  final String number;
  final String title;
  final String description;

  const _Step({required this.number, required this.title, required this.description});
}

class _StepsCard extends StatelessWidget {
  const _StepsCard();

  static const _steps = [
    _Step(
      number: '1',
      title: 'เตรียมผู้ป่วย',
      description:
          'ตรวจสอบค่าพื้นฐาน ประวัติโรคหรือการผ่าตัดตา ยาหรือยาหยอดตาที่อาจมีผลต่อรูม่านตา '
          'และการบาดเจ็บที่ดวงตา',
    ),
    _Step(
      number: '2',
      title: 'สังเกตก่อนส่องไฟ',
      description:
          'ประเมินรูปร่าง ตำแหน่ง ความเท่ากัน และวัดขนาดรูม่านตาทั้งสองข้างเป็นมิลลิเมตร',
    ),
    _Step(
      number: '3',
      title: 'Direct light reflex',
      description: 'ส่องไฟจากหางตาไปทางหัวตาทีละข้าง สังเกตการหดตัวของตาข้างที่ถูกส่อง',
    ),
    _Step(
      number: '4',
      title: 'Consensual light reflex',
      description: 'ขณะส่องไฟตาข้างหนึ่ง สังเกตการหดตัวของรูม่านตาอีกข้าง',
    ),
    _Step(
      number: '5',
      title: 'บันทึกผลแยกข้าง',
      description: 'เช่น Rt 3 mm, Lt 3 mm, equal, round, briskly reactive to light',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        border: Border.all(color: AppColors.primary, width: 1.6),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.assignment_rounded, color: AppColors.primaryDark, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'ขั้นตอนการประเมินรูม่านตา',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final step in _steps) ...[
            _StepRow(step: step),
            if (step != _steps.last)
              Divider(height: 1, thickness: 1, color: AppColors.primary.withValues(alpha: 0.2)),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final _Step step;

  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.primary, width: 1.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              step.number,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 3),
                Text(
                  step.description,
                  style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechniqueCard extends StatelessWidget {
  const _TechniqueCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF9F3),
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_rounded, color: Color(0xFFC97A1E), size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'เทคนิคการตรวจ',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'จัดห้องให้แสงสลัวหากทำได้ ให้ผู้ป่วยมองไกลขณะตรวจ '
                      'และหลีกเลี่ยงการกดลูกตาที่ได้รับบาดเจ็บ',
                      style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _StatusChip(label: 'Reactive', color: Color(0xFFA3EBC5), textColor: Color(0xFF1E7A4A))),
              SizedBox(width: 8),
              Expanded(child: _StatusChip(label: 'Sluggish', color: Color(0xFFFCE49B), textColor: Color(0xFF8A6A1E))),
              SizedBox(width: 8),
              Expanded(child: _StatusChip(label: 'Non-reactive', color: Color(0xFFF6B8B0), textColor: Color(0xFF8A3A33))),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _StatusChip({required this.label, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: textColor),
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  const _WarningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECEA),
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_rounded, color: AppColors.danger, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'ความผิดปกติที่ต้องรีบรายงาน',
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.danger),
                ),
                SizedBox(height: 4),
                Text(
                  'รูม่านตาไม่เท่ากันที่เกิดขึ้นใหม่หรือแตกต่างจากเดิมชัดเจน การตอบสนองต่อแสงช้าลง '
                  'หรือรูม่านตาขยายและไม่ตอบสนองต่อแสง ควรประเมินซ้ำและรายงานแพทย์ทันที '
                  'เพราะอาจเป็นสัญญาณของ neurological deterioration',
                  style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF8A3A33)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
