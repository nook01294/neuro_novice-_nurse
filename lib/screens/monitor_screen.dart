import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

/// "Nursing Care" tab — the 6-step nursing-care guideline for preventing
/// and reducing increased intracranial pressure.
class MonitorScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const MonitorScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'Nursing Care for IICP',
      automaticallyImplyLeading: false,
      body: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 16),
          _NursingCareCard(
            number: '1',
            title: 'เฝ้าระวังอาการทางระบบประสาท',
            description:
                'สังเกตและบันทึกอาการและอาการแสดงทางระบบประสาทและสัญญาณซีพที่เป็น'
                'สัญญาณเตือนของภาวะความดันกะโหลกศีรษะสูง (Early Warning Sign) '
                'และต้องรายงานแพทย์ทันทีหากพบความผิดปกติประกอบด้วย',
            items: [
              'ประเมิน Glasgow Coma Scale',
              'สังเกตอาการผิดปกติ ได้แก่ สับสน กระสับกระส่าย ไม่รับรู้วัน เวลา สถานที่ '
                  'บุคคล หรืออาการง่วงซึม แขนขาอ่อนแรงแย่ลงจากเดิมตั้งแต่ 1 Grade '
                  'มีอาการตาพร่ามัว อาการพูดลำบาก ขนาดของ Pupil ที่เปลี่ยนแปลง '
                  'ปวดศีรษะมากขึ้น รับประทานยาบรรเทาปวดแล้วอาการไม่ทุเลา',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '2',
            title: 'ดูแลการระบายอากาศและทางเดินหายใจ',
            description:
                'ดูแลให้มีการระบายอากาศปอดได้อย่างเพียงพอและป้องกันการอุดตันใน'
                'ทางเดินหายใจ ควรปฏิบัติดังนี้',
            items: [
              'ดูดเสมหะอย่างมีประสิทธิภาพ โดยการดูดเสมหะในแต่ละครั้งไม่เกินครั้งละ '
                  '10 วินาที และก่อนทำการดูดเสมหะในครั้งที่ 2 ให้ผู้ป่วยได้พัก 30 วินาที '
                  'การดูดเสมหะไม่ควรเกิน 1–2 ครั้ง ในแต่ละรอบของการดูดเสมหะ',
              'ความดันที่ใช้การดูดเสมหะไม่เกิน 120 มิลลิเมตรปรอท',
              'จัดท่านอนศีรษะสูง 30 องศา และแนวตรง',
              'พลิกตะแคงตัวทุก 1–2 ชั่วโมง',
              'ติดตามภาวะขาดออกซิเจนในเลือดไม่ควรต่ำกว่า 94%',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '3',
            title: 'เพิ่มการไหลกลับของหลอดเลือดดำ',
            description: 'เพิ่มการไหลกลับของหลอดเลือดดำจากสมองกลับสู่หัวใจ',
            items: [
              'จัดท่านอนศีรษะสูง 30 องศา (Head Elevation 30 Degree)',
              'จัดศีรษะและคออยู่แนวเดียวกับลำตัว (Neutral Position)',
              'ไม่นอนคว่ำ',
              'ไม่งอข้อสะโพกเกิน 90 องศา',
              'ไม่ให้ปลายเท้าชิดปลายเตียง',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '4',
            title: 'ป้องกัน Valsalva Maneuver',
            description:
                'จัดการสาเหตุที่ทำให้เกิดความดันในช่องอกและช่องท้องเพิ่มมากขึ้น '
                '(Valsalva Maneuver)',
            items: [
              'หลีกเลี่ยงการผูกยึด (Restraint) โดยไม่จำเป็น',
              'หลีกเลี่ยงกิจกรรมต่าง ๆ ที่จะทำให้เกิดแรงเบ่ง เช่น การเบ่งอุจจาระและ'
                  'เบ่งปัสสาวะ',
              'ดูแลการตั้งค่าเครื่องช่วยหายใจที่มีความดันบวกในช่วงสิ้นสุดการหายใจ (PEEP) '
                  'ให้อยู่ระหว่าง 5–10 cmH2O',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '5',
            title: 'จัดการกับภาวะไข้',
            description:
                'จัดการกับภาวะไข้ เนื่องจากอุณหภูมิที่เพิ่มมากขึ้นทุก ๆ 1 องศา '
                'ทำให้เพิ่มเมตาบอลิซึมในสมอง',
            items: [
              'เช็ดตัวด้วยน้ำธรรมดา โดยอุณหภูมิที่เหมาะสมสำหรับผู้ป่วยที่ควรอยู่'
                  'ระหว่าง 32–36 องศาเซลเซียส',
              'หลีกเลี่ยงการห่มผ้าแก่ผู้ป่วยโดยเฉพาะบางรายที่พบว่ามีไข้ตั้งแต่ 38 องศา',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '6',
            title: 'ดูแลอุปกรณ์พยุงคอ',
            description:
                'ดูแลให้ผู้ป่วยสวมอุปกรณ์พยุงคอ (Hard or Soft Collar) อย่างเหมาะสม '
                'ไม่แน่นหรือหลวมจนเกินไป',
            items: [],
          ),
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
      'แนวทางการปฏิบัติการพยาบาลเพื่อป้องกันและลดความดันในกะโหลกศีรษะสูง',
      style: TextStyle(
        fontSize: 14.5,
        height: 1.6,
        color: AppColors.textOnBackground,
      ),
    );
  }
}

/// Rounded card for one numbered nursing-care step: a number badge + icon +
/// title header, an optional lead-in description, then a bullet list.
class _NursingCareCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final List<String> items;

  const _NursingCareCard({
    required this.number,
    required this.title,
    required this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 13.5, height: 1.5, color: AppColors.textDark),
          ),
          for (final item in items) ...[
            const SizedBox(height: 8),
            _BulletRow(text: item),
          ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textMuted)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}
