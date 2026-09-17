import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

/// "ICP Warning" reference page — explains increased intracranial pressure
/// (Monro–Kellie doctrine) and lists the early vs. late signs and symptoms
/// nurses should watch for.
class IcpWarningScreen extends StatelessWidget {
  const IcpWarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'ICP Warning',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 20),
          _SignCard(
            icon: Icons.visibility_rounded,
            title: 'Early sign : ระยะแรก',
            headerColor: Color(0xFFB9EAD3),
            iconBackground: Color(0xFF1E8058),
            bodyColor: Color(0xFFEAFBF3),
            items: _earlySigns,
          ),
          SizedBox(height: 16),
          _SignCard(
            icon: Icons.warning_rounded,
            title: 'Late sign : ระยะท้าย',
            headerColor: Color(0xFFF6B8B0),
            iconBackground: AppColors.danger,
            bodyColor: Color(0xFFFDECEA),
            items: _lateSigns,
          ),
        ],
      ),
    );
  }
}

const _earlySigns = [
  'การเปลี่ยนแปลงระดับความรู้สึกตัวเป็นอาการสำคัญและมักพบก่อนอาการอื่น',
  'กระสับกระส่าย สับสน หงุดหงิด',
  'ง่วงซึมมากขึ้น ปลุกตื่นยาก',
  'GCS ลดลงจากค่าเดิมของผู้ป่วย',
  'ปวดศีรษะมากขึ้น',
  'คลื่นไส้ อาเจียน โดยเฉพาะอาเจียนพุ่ง',
  'รูม่านตาตอบสนองต่อแสงช้าลงหรือไม่เท่ากัน',
  'แขนขาอ่อนแรงหรือการเคลื่อนไหวสองข้างไม่เท่ากัน',
  'พูดผิดปกติหรือพฤติกรรมเปลี่ยนแปลง',
  'ชัก',
];

const _lateSigns = [
  'ระดับความรู้สึกตัวลดลงมากหรือหมดสติ',
  'รูม่านตาขยายและไม่ตอบสนองต่อแสง',
  'แขนขาเกร็งแบบ decorticate หรือ decerebrate',
  'การหายใจผิดปกติ',
  'สูญเสีย brainstem reflexes',
  "Cushing's triad",
  'ความดันโลหิตสูง โดยเฉพาะ pulse pressure กว้าง',
  'ชีพจรช้า (Bradycardia)',
  'การหายใจช้าหรือไม่สม่ำเสมอ',
  'อาจเกิด brain herniation และเสียชีวิต',
  "Cushing's triad เป็นสัญญาณระยะท้าย ไม่ควรรอให้เกิดก่อนรายงานแพทย์",
];

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ภาวะที่ความดันภายในกะโหลกศีรษะเพิ่มขึ้นจากปริมาตรของเนื้อสมอง เลือด หรือ CSF '
      'ตามหลัก Monro–Kellie ค่า ICP ปกติในผู้ใหญ่ประมาณ 5–15 mmHg',
      style: TextStyle(fontSize: 14.5, height: 1.6, color: AppColors.textOnBackground),
    );
  }
}

/// Rounded card used for both the early- and late-sign lists: a solid
/// colour header bar with an icon and title, followed by a tinted list of
/// bullet items.
class _SignCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color headerColor;
  final Color iconBackground;
  final Color bodyColor;
  final List<String> items;

  const _SignCard({
    required this.icon,
    required this.title,
    required this.headerColor,
    required this.iconBackground,
    required this.bodyColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bodyColor,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: headerColor,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in items) _BulletRow(text: item),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;

  const _BulletRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('-  ', style: TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textDark)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}
