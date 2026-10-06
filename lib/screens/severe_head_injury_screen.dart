import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/head_injury_guideline.dart';

/// Nursing care guideline for Severe Head Injury (GCS 3–8): immediate
/// ABCDE resuscitation and airway care, intensive neuro-observation, key
/// nursing actions, deterioration/IICP warning signs, and Cushing response.
class SevereHeadInjuryScreen extends StatelessWidget {
  const SevereHeadInjuryScreen({super.key});

  static const _warningSigns = [
    WarningSign(icon: Icons.trending_down_rounded, text: 'GCS ลดลง ≥2 คะแนนจากเดิม'),
    WarningSign(
      icon: Icons.fitness_center_rounded,
      text: 'Motor response (M) ลดลง ≥1 คะแนนจากเดิม หรือกำลังแขนหรือขาลดลง',
    ),
    WarningSign(icon: Icons.remove_red_eye_rounded, text: 'รูม่านตาเปลี่ยนแปลง หรือตอบสนองต่อแสงผิดปกติ'),
    WarningSign(icon: Icons.bolt_rounded, text: 'ชัก'),
    WarningSign(
      icon: Icons.psychology_rounded,
      text: 'หลีกเลี่ยงกิจกรรมที่อาจเพิ่ม ICP และติดตาม V/S และ neurological signs อย่างใกล้ชิด',
    ),
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
              children: const [
                Text(
                  'GCS 3–8 | การพยาบาลระดับรุนแรง',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textOnBackground,
                  ),
                ),
                SizedBox(height: 12),
                _ImmediateCareCard(),
                SizedBox(height: 12),
                ChecklistCard(
                  headingIcon: Icons.local_hospital_rounded,
                  title: 'การพยาบาลสำคัญ',
                  items: [
                    ChecklistItem(
                      icon: Icons.bed_rounded,
                      text: 'จัดศีรษะสูงประมาณ 30° และศีรษะ-คอให้อยู่แนวตรง เมื่อไม่มีข้อห้าม',
                    ),
                    ChecklistItem(
                      icon: Icons.water_drop_rounded,
                      text: 'ให้สารน้ำทางหลอดเลือดดำตามแผนการรักษา '
                          'และบันทึกสารน้ำเข้า-ออก (I/O)',
                    ),
                    ChecklistItem(
                      icon: Icons.medication_rounded,
                      text: 'ให้ Mannitol หรือ Hypertonic saline เมื่อมีข้อบ่งชี้ตามแผน '
                          'พร้อมติดตามภาวะแทรกซ้อน',
                    ),
                    ChecklistItem(
                      icon: Icons.shield_rounded,
                      text: 'ให้ยากันชักเพื่อป้องกัน early post-traumatic seizure '
                          'เมื่อมีข้อบ่งชี้หรือความเสี่ยงสูง ตามแผนการรักษา',
                    ),
                  ],
                ),
                SizedBox(height: 12),
                WarningSignsCard(
                  title: 'เฝ้าระวังภาวะทรุดลงและ IICP',
                  signs: _warningSigns,
                  columns: 1,
                  bannerText: 'พบความผิดปกติให้รายงานแพทย์ทันที',
                  trailing: _CushingSection(),
                ),
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

class _ImmediateCareCard extends StatelessWidget {
  const _ImmediateCareCard();

  @override
  Widget build(BuildContext context) {
    return GuidelineCard(
      background: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GuidelineCardHeading(
            icon: Icons.event_note_rounded,
            title: 'ประเมินและช่วยเหลือทันที',
            iconColor: AppColors.primaryDark,
            iconBackground: Color(0xFFDDF3E7),
            titleColor: AppColors.primaryDark,
          ),
          const SizedBox(height: 10),
          const ChecklistList(
            items: [
              ChecklistItem(
                icon: Icons.notifications_active_rounded,
                text: 'ช่วยเหลือตามหลัก ABCDE และรายงานแพทย์/ทีมที่เกี่ยวข้องทันที',
              ),
              ChecklistItem(
                icon: Icons.air_rounded,
                text: 'ดูแลทางเดินหายใจให้โล่ง ป้องกันภาวะพร่องออกซิเจน',
              ),
              ChecklistItem(
                icon: Icons.medical_services_rounded,
                text: 'เตรียมอุปกรณ์และช่วยใส่ท่อช่วยหายใจเมื่อมีข้อบ่งชี้ '
                    'โดยเฉพาะ GCS ≤8 หรือปกป้องทางเดินหายใจไม่ได้',
              ),
              ChecklistItem(
                icon: Icons.monitor_heart_rounded,
                text: 'ติดตามสัญญาณชีพและ SpO₂ อย่างใกล้ชิด',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3FBF7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ประเมิน neurological signs: GCS (E, V, M), Pupil, Motor response',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(height: 10),
                TimelineArrowRow(
                  boxes: [
                    CompactTimelineBox(primary: 'ทุก 15–30 นาที', secondary: 'ในระยะวิกฤต'),
                    CompactTimelineBox(primary: 'ปรับตามอาการ', secondary: 'คำสั่งแพทย์'),
                    CompactTimelineBox(primary: 'และแนวปฏิบัติ', secondary: 'ของหน่วยงาน'),
                  ],
                ),
              ],
            ),
          ),
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
    _CushingSign(icon: Icons.arrow_upward_rounded, text: 'ความดันโลหิตสูงขึ้น โดยเฉพาะ Systolic BP'),
    _CushingSign(icon: Icons.show_chart_rounded, text: 'Pulse pressure กว้างขึ้น'),
    _CushingSign(
      icon: Icons.monitor_heart_rounded,
      text: 'ชีพจรช้าลง (Bradycardia) และการหายใจผิดปกติ/ไม่สม่ำเสมอ',
    ),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cushing response',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.danger),
                  ),
                  const Text(
                    'สัญญาณอันตรายของภาวะ IICP',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
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
