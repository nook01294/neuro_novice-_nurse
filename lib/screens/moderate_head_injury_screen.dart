import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Moderate Head Injury (GCS 9–12): ABCDE
/// assessment and close neuro-observation, key nursing actions, and the
/// warning signs that call for immediate escalation.
class ModerateHeadInjuryScreen extends StatelessWidget {
  const ModerateHeadInjuryScreen({super.key});

  static const _warningSigns = [
    WarningSign(icon: Icons.trending_down_rounded, text: 'GCS ลดลง ≥2 คะแนน'),
    WarningSign(icon: Icons.bolt_rounded, text: 'ชัก'),
    WarningSign(icon: Icons.arrow_downward_rounded, text: 'Motor response (M) ลดลง ≥1 คะแนน'),
    WarningSign(icon: Icons.sick_rounded, text: 'อาเจียน ≥2 ครั้ง'),
    WarningSign(icon: Icons.remove_red_eye_rounded, text: 'รูม่านตาเปลี่ยนแปลง หรือตอบสนองต่อแสงผิดปกติ'),
    WarningSign(icon: Icons.healing_rounded, text: 'ปวดศีรษะมากขึ้น'),
    WarningSign(icon: Icons.psychology_alt_rounded, text: 'ซึม สับสน กระสับกระส่าย'),
    WarningSign(icon: Icons.chat_bubble_rounded, text: 'พูดหรือทรงตัวผิดปกติ'),
    WarningSign(icon: Icons.fitness_center_rounded, text: 'แขนขาอ่อนแรงหรือชามากขึ้น'),
    WarningSign(icon: Icons.blur_on_rounded, text: 'ตามัวหรือเห็นภาพซ้อน'),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'Moderate Head Injury',
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
                    color: AppColors.textOnBackground,
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
                      text: 'จัดท่านอนศีรษะสูงประมาณ 30° เมื่อไม่มีข้อห้าม',
                    ),
                    ChecklistItem(
                      icon: Icons.air_rounded,
                      text: 'ดูแลทางเดินหายใจให้โล่ง ติดตาม SpO₂ '
                          'และให้ออกซิเจนเมื่อ SpO₂ <95% หรือมีข้อบ่งชี้',
                    ),
                    ChecklistItem(
                      icon: Icons.no_food_rounded,
                      text: 'พิจารณางดน้ำและอาหารทางปากตามระดับความรู้สึกตัว '
                          'ความเสี่ยงต่อการสำลัก และแผนการรักษา',
                    ),
                    ChecklistItem(
                      icon: Icons.water_drop_rounded,
                      text: 'ให้สารน้ำทางหลอดเลือดดำ และบันทึกสารน้ำเข้า–ออก (I/O) '
                          'ตามแผนการรักษา',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ป้องกันอันตรายจากชัก พลัดตกหกล้ม และการสำลัก',
                      details: [
                        ChecklistDetail(
                          icon: Icons.psychology_rounded,
                          label: 'ชัก',
                          text: 'จัดสิ่งแวดล้อมให้ปลอดภัย ยกไม้กั้นเตียง '
                              'เตรียมอุปกรณ์ดูดเสมหะ และออกซิเจนให้พร้อม',
                        ),
                        ChecklistDetail(
                          icon: Icons.directions_walk_rounded,
                          label: 'พลัดตกหกล้ม',
                          text: 'ปรับเตียงให้อยู่ระดับต่ำ ยกไม้กั้นเตียงตามความเหมาะสม '
                              'และช่วยเหลือเมื่อลุกนั่ง หรือเดิน',
                        ),
                        ChecklistDetail(
                          icon: Icons.air_rounded,
                          label: 'การสำลัก',
                          text: 'งดน้ำและอาหารทางปากเมื่อระดับความรู้สึกตัวลดลง '
                              'หรือยังไม่ได้ประเมินการกลืน เฝ้าระวังการหายใจผิดปกติ และ SpO₂ ลดลง',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                WarningSignsCard(title: 'เฝ้าระวังและรายงานทันที', signs: _warningSigns),
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
          const BulletList(
            items: [
              'ประเมิน ABCDE และรายงานแพทย์/ทีมที่เกี่ยวข้อง',
              'ประเมิน V/S และ neurological signs อย่างใกล้ชิด '
                  'บันทึก GCS แยก E, V, M, Pupil และ Motor power ของแขนขา',
              'เฝ้าระวังทางเดินหายใจอุดกั้น ภาวะพร่องออกซิเจน และการสำลัก',
            ],
          ),
          const SizedBox(height: 6),
          const TimelineArrowRow(
            boxes: [
              CompactTimelineBox(primary: 'ทุก 30 นาที', secondary: 'ในระยะแรก'),
              CompactTimelineBox(primary: 'ปรับตามอาการ', secondary: 'และคำสั่งแพทย์'),
              CompactTimelineBox(primary: 'ตามแนวปฏิบัติ', secondary: 'ของหน่วยงาน'),
            ],
          ),
        ],
      ),
    );
  }
}
