import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Mild Head Injury (GCS 13–15): the
/// neuro-observation schedule, key nursing actions, and the warning
/// signs that call for an immediate re-assessment and escalation.
class MildHeadInjuryScreen extends StatelessWidget {
  const MildHeadInjuryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mild Head Injury')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'GCS 13–15 | การพยาบาลระดับเล็กน้อย',
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
                      text: 'รักษาระดับ O₂ saturation ≥95% โดยไม่จำเป็นต้องให้ออกซิเจนทุกราย '
                          'หาก SpO₂ ปกติและไม่มีภาวะหายใจผิดปกติ',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ดูแลให้พักผ่อนและจัดสิ่งแวดล้อมให้ปลอดภัย',
                    ),
                    ChecklistItem(
                      icon: Icons.medication_rounded,
                      text: 'ให้ยาตามแผนการรักษา เพื่อบรรเทาอาการปวดศีรษะ คลื่นไส้ อาเจียน',
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
            subtitle: 'V/S • N/S • Pupil • GCS แยก E, V, M • Motor power',
            iconColor: AppColors.primaryDark,
            iconBackground: Color(0xFFDDF3E7),
            titleColor: AppColors.primaryDark,
          ),
          const SizedBox(height: 12),
          const TimelineArrowRow(
            boxes: [
              CompactTimelineBox(primary: 'ทุก 30 นาที', secondary: 'เป็นเวลา 2 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 1 ชั่วโมง', secondary: 'เป็นเวลา 4 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 2 ชั่วโมง', secondary: 'จนครบ 24 ชั่วโมง'),
            ],
          ),
          const SizedBox(height: 10),
          const InfoNoteRow(text: 'หรือปรับตามอาการ คำสั่ง และแนวทางหน่วยงาน'),
        ],
      ),
    );
  }
}
