import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Moderate Head Injury (GCS 9–12): physician
/// notification, the tighter neuro-observation schedule, key nursing
/// actions, and the same warning signs that call for escalation.
class ModerateHeadInjuryScreen extends StatelessWidget {
  const ModerateHeadInjuryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Moderate Head Injury')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'GCS 9–12 | การพยาบาลระดับปานกลาง',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(height: 12),
                _MonitoringCard(),
                SizedBox(height: 12),
                ChecklistCard(
                  headingIcon: Icons.local_hospital_rounded,
                  title: 'การพยาบาลสำคัญ',
                  items: [
                    ChecklistItem(
                      icon: Icons.bed_rounded,
                      text: 'จัดท่านอนศีรษะสูง 30 องศา เมื่อไม่มีข้อห้าม',
                    ),
                    ChecklistItem(
                      icon: Icons.air_rounded,
                      text: 'ให้ออกซิเจนทาง Cannula หรือ Mask with bag หรือ High flow '
                          'nasal cannula โดยรักษาระดับ O₂ saturation ≥95%',
                    ),
                    ChecklistItem(
                      icon: Icons.water_drop_rounded,
                      text: 'ดูแลงดน้ำงดอาหารทางปาก ให้สารน้ำทางหลอดเลือดดำตามแผนการรักษา '
                          'และบันทึกสารน้ำเข้า-ออก',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ป้องกันอาการชัก พลัดตก และภาวะแทรกซ้อน',
                    ),
                  ],
                ),
                SizedBox(height: 12),
                WarningSignsCard(),
                SizedBox(height: 12),
                GuidelineFooterNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonitoringCard extends StatelessWidget {
  const _MonitoringCard();

  @override
  Widget build(BuildContext context) {
    return GuidelineCard(
      background: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GuidelineCardHeading(
            icon: Icons.event_note_rounded,
            title: 'ประเมินและติดตาม',
            iconColor: AppColors.primaryDark,
            iconBackground: Color(0xFFDDF3E7),
            titleColor: AppColors.primaryDark,
          ),
          const SizedBox(height: 10),
          const InlineAlertRow(
            icon: Icons.record_voice_over_rounded,
            text: 'ประเมิน ABCDE และแจ้งแพทย์/ทีมที่เกี่ยวข้อง',
          ),
          const SizedBox(height: 10),
          const Text(
            'V/S • N/S • Pupil • GCS แยก E, V, M • Motor power',
            style: TextStyle(fontSize: 13.5, color: AppColors.textDark),
          ),
          const SizedBox(height: 10),
          const TimelineArrowRow(
            boxes: [
              WideTimelineBox(primary: 'ทุก 30 นาที', secondary: 'เป็นเวลา 2 ชั่วโมง'),
              WideTimelineBox(primary: 'ทุก 1 ชั่วโมง', secondary: 'จนกว่าอาการจะคงที่'),
            ],
          ),
          const SizedBox(height: 10),
          const InlineTintedRow(
            icon: Icons.air_rounded,
            text: 'เฝ้าระวังทางเดินหายใจและการสำลัก',
          ),
          const SizedBox(height: 10),
          const InfoNoteRow(text: 'หรือปรับตามอาการ คำสั่ง และแนวทางหน่วยงาน'),
        ],
      ),
    );
  }
}
