import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/intro_panel.dart';

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
          SizedBox(height: 8),
          _SourceNote(),
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
    return const IntroPanel(
      text:
          'การประเมิน Motor power ใช้ประเมินกำลังกล้ามเนื้อและค้นหาภาวะอ่อนแรง '
          'โดยเปรียบเทียบแขน-ขาซ้ายและขวาและติดตามการเปลี่ยนแปลงทางระบบประสาท '
          'ใช้ Medical Research Council (MRC) Scale แบ่งเป็น 6 ระดับ '
          'ให้คะแนนตั้งแต่ Grade 0–5 (Paternostro-Sluga et al., 2008)',
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

  static const _background = Color(0xFF5E9A6B);

  static const _grades = [
    _MrcGrade(score: '0', description: 'ไม่มีการเคลื่อนไหว/หดตัวของกล้ามเนื้อ'),
    _MrcGrade(score: '1', description: 'มีการหดตัวของกล้ามเนื้อเล็กน้อย แต่ไม่เกิดการเคลื่อนไหวของข้อ'),
    _MrcGrade(score: '2', description: 'สามารถเคลื่อนไหวกล้ามเนื้อในแนวราบได้ แต่ไม่สามารถต้านแรงโน้มถ่วง'),
    _MrcGrade(
      score: '3',
      description: 'กำลังของกล้ามเนื้อสามารถต้านแรงโน้มถ่วง แต่ไม่สามารถต้านแรงของผู้ตรวจได้',
    ),
    _MrcGrade(
      score: '4',
      description: 'กำลังของกล้ามเนื้อสามารถต้านแรงโน้มถ่วงและแรงของผู้ตรวจได้แต่ไม่ปกติ',
    ),
    _MrcGrade(score: '5', description: 'กำลังกล้ามเนื้อปกติ และต้านแรงผู้ตรวจได้เต็มที่'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _background,
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
              Flexible(
                child: Text(
                  'เกณฑ์การให้คะแนน MRC',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final grade in _grades) ...[
            _MrcGradeRow(grade: grade),
            if (grade != _grades.last)
              Padding(
                padding: const EdgeInsets.only(left: _MrcGradeRow.pillWidth + 12),
                child: Divider(height: 1, thickness: 1, color: Colors.white.withValues(alpha: 0.2)),
              ),
          ],
        ],
      ),
    );
  }
}

class _MrcGradeRow extends StatelessWidget {
  static const double pillWidth = 78;

  final _MrcGrade grade;

  const _MrcGradeRow({required this.grade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: pillWidth,
            padding: const EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Grade ${grade.score}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              grade.description,
              style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceNote extends StatelessWidget {
  const _SourceNote();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        'หมายเหตุ. แปลและเรียบเรียงจาก Paternostro-Sluga et al. (2008)',
        style: TextStyle(fontSize: 12, color: AppColors.textMuted),
      ),
    );
  }
}

/// Tinted, outlined note card with an icon-led title, used for the
/// "ข้อควรระวัง" and "ควรพิจารณา" notes at the bottom of the page.
class _NoteCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color accent;
  final Color background;

  const _NoteCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.accent,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 26),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textDark),
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
    return const _NoteCard(
      icon: Icons.warning_rounded,
      title: 'ข้อควรระวัง',
      text: 'หากกำลังกล้ามเนื้อลดลงจากค่าพื้นฐาน หรือพบแขน-ขาอ่อนแรงเกิดขึ้นใหม่ '
          'ควรถือเป็น neurological change ประเมินซ้ำร่วมกับ neurological signs อื่น '
          'และรายงานแพทย์/ทีมรักษาตามความเร่งด่วน',
      accent: Color(0xFFE0661F),
      background: Color(0xFFFDF3E7),
    );
  }
}

class _FactorsCard extends StatelessWidget {
  const _FactorsCard();

  @override
  Widget build(BuildContext context) {
    return const _NoteCard(
      icon: Icons.search_rounded,
      title: 'ควรพิจารณา',
      text: 'ควรพิจารณาปัจจัยที่อาจรบกวนการประเมิน เช่น ความปวด '
          'การบาดเจ็บหรือข้อจำกัดของระบบกระดูกและกล้ามเนื้อ การจัดท่า '
          'ความร่วมมือและความเข้าใจคำสั่งของผู้ป่วย รวมถึงระดับความรู้สึกตัว'
          'และยาที่มีผลต่อระบบประสาท เพราะอาจทำให้ผลการประเมินคลาดเคลื่อน',
      accent: Color(0xFF1E8A8A),
      background: Color(0xFFEFF8FA),
    );
  }
}
