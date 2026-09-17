import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

/// "Motor Power" reference page — explains the Medical Research Council
/// (MRC) muscle-strength scale used to compare left/right limb power and
/// flag new neurological changes.
class MotorPowerScreen extends StatelessWidget {
  const MotorPowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'Motor Power',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 20),
          _BodyDiagramCard(),
          SizedBox(height: 16),
          _MrcScaleCard(),
          SizedBox(height: 12),
          _WarningCard(),
          SizedBox(height: 12),
          _FactorsCard(),
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
      'การประเมิน Motor power ใช้ตรวจหากล้ามเนื้ออ่อนแรง เปรียบเทียบแขน-ขาซ้ายและขวา '
      'และติดตามการเปลี่ยนแปลงทางระบบประสาท โดยใช้ Medical Research Council (MRC) Scale '
      'ให้คะแนน Grade 0–5 แบ่งเป็น 6 ระดับ',
      style: TextStyle(fontSize: 14.5, height: 1.6, color: AppColors.textOnBackground),
    );
  }
}

/// Card with the reference body diagram showing the four limbs to compare:
/// right/left arm and right/left leg.
class _BodyDiagramCard extends StatelessWidget {
  const _BodyDiagramCard();

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
          'assets/images/S__5300252.jpg',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _MrcGrade {
  final String score;
  final String description;

  const _MrcGrade({required this.score, required this.description});
}

class _MrcScaleCard extends StatelessWidget {
  const _MrcScaleCard();

  static const _grades = [
    _MrcGrade(score: '0', description: 'ไม่มีการเคลื่อนไหวหรือการหดตัวของกล้ามเนื้อ'),
    _MrcGrade(score: '1', description: 'กล้ามเนื้อหดตัว แต่ข้อไม่เคลื่อนไหว'),
    _MrcGrade(score: '2', description: 'เคลื่อนไหวในแนวราบได้ แต่ต้านแรงโน้มถ่วงไม่ได้'),
    _MrcGrade(score: '3', description: 'ต้านแรงโน้มถ่วงได้ แต่ต้านแรงผู้ตรวจไม่ได้'),
    _MrcGrade(score: '4', description: 'ต้านแรงโน้มถ่วงและแรงผู้ตรวจได้ แต่กำลังไม่ปกติ'),
    _MrcGrade(score: '5', description: 'กำลังกล้ามเนื้อปกติ ต้านแรงผู้ตรวจได้เต็มที่'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.assignment_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'เกณฑ์การให้คะแนน MRC',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final grade in _grades) ...[
            _MrcGradeRow(grade: grade),
            if (grade != _grades.last)
              Divider(height: 1, thickness: 1, color: Colors.white.withValues(alpha: 0.15)),
          ],
        ],
      ),
    );
  }
}

class _MrcGradeRow extends StatelessWidget {
  final _MrcGrade grade;

  const _MrcGradeRow({required this.grade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              border: Border.all(color: Colors.white, width: 1.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              grade.score,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              grade.description,
              style: const TextStyle(fontSize: 13.5, height: 1.4, color: Colors.white),
            ),
          ),
        ],
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
                  'ข้อควรระวัง',
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.danger),
                ),
                SizedBox(height: 4),
                Text(
                  'กำลังกล้ามเนื้อลดลงจากค่าพื้นฐาน หรือแขน-ขาอ่อนแรงไม่เท่ากันที่เกิดขึ้นใหม่ '
                  'ถือเป็น neurological change ควรประเมินซ้ำและรายงานทันที',
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

class _FactorsCard extends StatelessWidget {
  const _FactorsCard();

  static const _factors = [
    'ความปวด',
    'การบาดเจ็บ',
    'ข้อจำกัดการเคลื่อนไหว',
    'ระดับความรู้สึกตัว',
    'การเข้าใจคำสั่ง',
    'ยากดประสาท',
    'ยาคลายกล้ามเนื้อ',
  ];

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_rounded, color: Color(0xFFC97A1E), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ปัจจัยที่อาจทำให้ผลคลาดเคลื่อน',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 6),
                Text(
                  _factors.join(' • '),
                  style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
