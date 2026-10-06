import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Mild Head Injury (GCS 13–15): the
/// neuro-observation schedule, key nursing actions, and the warning
/// signs that call for an immediate re-assessment and escalation.
class MildHeadInjuryScreen extends StatelessWidget {
  const MildHeadInjuryScreen({super.key});

  static const _warningSigns = [
    WarningSign(icon: Icons.trending_down_rounded, text: 'GCS ลดลง ≥2 คะแนนจากเดิม'),
    WarningSign(icon: Icons.bolt_rounded, text: 'ชัก'),
    WarningSign(icon: Icons.arrow_downward_rounded, text: 'Motor response (M) ลดลง ≥1 คะแนนจากเดิม'),
    WarningSign(icon: Icons.sick_rounded, text: 'อาเจียน ≥2 ครั้ง หรืออาเจียนมากขึ้น'),
    WarningSign(icon: Icons.remove_red_eye_rounded, text: 'รูม่านตาเปลี่ยนแปลง หรือตอบสนองต่อแสงผิดปกติ'),
    WarningSign(icon: Icons.healing_rounded, text: 'ปวดศีรษะมากขึ้น'),
    WarningSign(icon: Icons.psychology_alt_rounded, text: 'ซึมลง สับสน กระสับกระส่าย'),
    WarningSign(icon: Icons.fitness_center_rounded, text: 'แขนขาอ่อนแรงหรือชามากขึ้น'),
    WarningSign(icon: Icons.chat_bubble_rounded, text: 'พูดผิดปกติหรือทรงตัวผิดปกติ'),
    WarningSign(icon: Icons.blur_on_rounded, text: 'ตามัวหรือเห็นภาพซ้อน'),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'Mild Head Injury',
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
                      text: 'จัดท่านอนศีรษะสูงประมาณ 30° เมื่อไม่มีข้อห้าม '
                          'และจัดศีรษะคอให้อยู่แนวตรง',
                    ),
                    ChecklistItem(
                      icon: Icons.air_rounded,
                      text: 'ดูแลทางเดินหายใจให้โล่ง เฝ้าระวังภาวะพร่องออกซิเจน '
                          'และติดตาม SpO₂ ให้ออกซิเจนเมื่อมีข้อบ่งชี้',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ดูแลให้ผู้ป่วยพักผ่อน และจัดสิ่งแวดล้อมให้ปลอดภัย',
                    ),
                    ChecklistItem(
                      icon: Icons.medication_rounded,
                      text: 'ให้การรักษาตามอาการ เช่น ปวดศีรษะ คลื่นไส้ '
                          'หรืออาเจียน ตามแผนการรักษา',
                    ),
                  ],
                ),
                SizedBox(height: 12),
                WarningSignsCard(signs: _warningSigns),
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
              'ประเมิน Neurological signs ได้แก่ ระดับความรู้สึกตัว GCS แยก E, V, M,',
              'ประเมินขนาดและการตอบสนองต่อแสงของ Pupil และ Motor power',
            ],
          ),
          const SizedBox(height: 6),
          const TimelineArrowRow(
            boxes: [
              CompactTimelineBox(primary: 'ทุก 30 นาที', secondary: 'เป็นเวลา 2 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 1 ชั่วโมง', secondary: 'เป็นเวลา 4 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 2 ชั่วโมง', secondary: 'จนครบ 24 ชั่วโมง'),
            ],
          ),
          const SizedBox(height: 10),
          const InfoNoteRow(text: 'ปรับความถี่ตามอาการ คำสั่งแพทย์ และแนวปฏิบัติของหน่วยงาน'),
        ],
      ),
    );
  }
}
