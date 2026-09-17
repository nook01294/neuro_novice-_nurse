import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Severe Head Injury (GCS 3–8): immediate
/// physician/charge-nurse escalation, intensive neuro-observation, key
/// nursing actions, deterioration warning signs, and Cushing response.
class SevereHeadInjuryScreen extends StatelessWidget {
  const SevereHeadInjuryScreen({super.key});

  static const _warningSigns = [
    WarningSign(icon: Icons.bolt_rounded, text: 'ชัก'),
    WarningSign(icon: Icons.psychology_alt_rounded, text: 'กระสับกระส่าย'),
    WarningSign(icon: Icons.trending_down_rounded, text: 'ระดับความรู้สึกตัวลดลง'),
    WarningSign(icon: Icons.fitness_center_rounded, text: 'แขนหรือขาอ่อนแรงเพิ่มขึ้น'),
    WarningSign(icon: Icons.equalizer_rounded, text: 'GCS ลดลง >1 คะแนน'),
    WarningSign(icon: Icons.location_on_rounded, text: 'มีอาการผิดปกติเกิดขึ้นในตำแหน่งใหม่'),
    WarningSign(icon: Icons.remove_red_eye_rounded, text: 'รูม่านตาไม่เท่ากัน/ตอบสนองต่อแสงผิดปกติ'),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'Severe Head Injury',
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'GCS 3–8 | การพยาบาลระดับรุนแรง',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textOnBackground,
                  ),
                ),
                const SizedBox(height: 12),
                const _MonitoringCard(),
                const SizedBox(height: 12),
                const ChecklistCard(
                  headingIcon: Icons.local_hospital_rounded,
                  title: 'การพยาบาลสำคัญ',
                  items: [
                    ChecklistItem(
                      icon: Icons.bed_rounded,
                      text: 'จัดท่านอนศีรษะสูง 30 องศา เมื่อไม่มีข้อห้าม',
                    ),
                    ChecklistItem(
                      icon: Icons.water_drop_rounded,
                      text: 'ดูแลและปรับสารน้ำทางหลอดเลือดดำ (IV fluid) ตามแผนการรักษา '
                          'และบันทึกสารน้ำเข้า-ออก',
                    ),
                    ChecklistItem(
                      icon: Icons.medication_rounded,
                      text: 'ให้ยาลด ICP และยากันชัก ตามแผนการรักษาของแพทย์',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ป้องกันการสำลัก ชัก แผลกดทับ และอุณหภูมิที่ผิดปกติ',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                WarningSignsCard(signs: _warningSigns, trailing: const _CushingSection()),
                const SizedBox(height: 12),
                const GuidelineFooterNote(),
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
            text: 'ประเมิน ABCDE และแจ้งหัวหน้าเวร/รายงานแพทย์/ทีมที่เกี่ยวข้องทันที',
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(
                  child: InlineTintedRow(
                    icon: Icons.air_rounded,
                    text: 'ดูแลทางเดินหายใจและเตรียมช่วยใส่ท่อช่วยหายใจเมื่อมีข้อบ่งชี้',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InlineTintedRow(
                    icon: Icons.monitor_heart_rounded,
                    text: 'ติดตาม BP • HR • ECG • O₂ saturation อย่างต่อเนื่อง',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'V/S • N/S • Pupil • GCS แยก E, V, M • Motor power',
            style: TextStyle(fontSize: 13.5, color: AppColors.textDark),
          ),
          const SizedBox(height: 10),
          const TimelineArrowRow(
            boxes: [
              CompactTimelineBox(primary: 'ทุก 15 นาที', secondary: 'เป็นเวลา 2 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 30 นาที', secondary: 'เป็นเวลา 2 ชั่วโมง'),
              CompactTimelineBox(primary: 'ทุก 1 ชั่วโมง', secondary: 'จนกว่าอาการจะคงที่'),
            ],
          ),
          const SizedBox(height: 10),
          const InfoNoteRow(text: 'หรือปรับตามอาการ คำสั่ง และแนวทางหน่วยงาน'),
        ],
      ),
    );
  }
}

class _CushingSign {
  final IconData icon;
  final String text;

  const _CushingSign({required this.icon, required this.text});
}

class _CushingSection extends StatelessWidget {
  const _CushingSection();

  static const _signs = [
    _CushingSign(icon: Icons.arrow_upward_rounded, text: 'ความดันโลหิตสูงขึ้น โดยเฉพาะ systolic BP'),
    _CushingSign(icon: Icons.monitor_heart_rounded, text: 'ชีพจรช้าลง (Bradycardia)'),
    _CushingSign(icon: Icons.air_rounded, text: 'การหายใจผิดปกติ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.favorite_rounded, color: AppColors.danger, size: 20),
            const SizedBox(width: 8),
            Text(
              'เฝ้าระวัง Cushing response',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.danger),
            ),
          ],
        ),
        const SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < _signs.length; i++) ...[
                Expanded(child: _CushingTile(sign: _signs[i])),
                if (i != _signs.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CushingTile extends StatelessWidget {
  final _CushingSign sign;

  const _CushingTile({required this.sign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECEA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(sign.icon, size: 18, color: AppColors.danger),
          const SizedBox(height: 6),
          Text(
            sign.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, height: 1.3, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
