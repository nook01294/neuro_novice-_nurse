import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/intro_panel.dart';

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
            title: 'เฝ้าระวังการเปลี่ยนแปลงทางระบบประสาทและสัญญาณเตือนของ ICP',
            items: [
              'ประเมินและบันทึก Glasgow Coma Scale (GCS) และเปรียบเทียบกับค่าพื้นฐาน',
              'ประเมินขนาดและการตอบสนองต่อแสงของรูม่านตา ทั้งสองข้าง',
              'ประเมินกำลังแขน-ขา และเปรียบเทียบซ้าย-ขวา',
              'ติดตามสัญญาณชีพและรูปแบบการหายใจอย่างใกล้ชิด',
              'เฝ้าระวังอาการผิดปกติ เช่น สับสน กระสับกระส่าย ง่วงซึมมากขึ้น GCS ลดลง '
                  'กำลังแขน-ขาลดลงจากเดิม รูม่านตาเปลี่ยนแปลง ปวดศีรษะมากขึ้น '
                  'คลื่นไส้หรืออาเจียน การพูดผิดปกติ หรืออาการชัก',
              'หากพบ neurological deterioration หรืออาการเปลี่ยนแปลงจากเดิม'
                  'ควรประเมินซ้ำและรายงานแพทย์ทันที',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '2',
            title: 'ดูแลทางเดินหายใจและการระบายอากาศภายในปอดได้อย่างเพียงพอ',
            items: [
              'ดูแลทางเดินหายใจให้โล่ง และป้องกันภาวะพร่องออกซิเจน',
              'ติดตาม SpO₂ และลักษณะการหายใจ',
              'ให้ออกซิเจนหรือช่วยการหายใจตามข้อบ่งชี้และแผนการรักษา',
              'ดูดเสมหะเมื่อมีข้อบ่งชี้ โดยใช้เทคนิคที่เหมาะสม ดูดเสมหะแต่ละครั้งไม่เกิน '
                  '10 วินาที ให้ผู้ป่วยพักประมาณ 30 วินาทีก่อนดูดซ้ำ ไม่ควรดูดเกิน '
                  '1–2 ครั้งต่อรอบ และใช้แรงดันในการดูดเสมหะไม่เกิน 120 mmHg',
              'ติดตาม SpO₂ สัญญาณชีพ และ neurological signs ระหว่างและหลังการดูดเสมหะ '
                  'เนื่องจากการไอและการ suction อาจทำให้ ICP เพิ่มขึ้นชั่วคราว',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '3',
            title: 'ส่งเสริมการไหลกลับของเลือดดำจากสมอง (Cerebral Venous Drainage)',
            items: [
              'จัดท่านอน ศีรษะสูงประมาณ 30° เมื่อไม่มีข้อห้าม (Head Elevation 30 Degree)',
              'จัดศีรษะและคอให้อยู่ในแนวตรง (Neutral Position)',
              'หลีกเลี่ยงการก้ม บิด หรือหมุนคอมากเกินไป',
              'หลีกเลี่ยงการกดรัดบริเวณคอ เพื่อไม่ให้ขัดขวางการไหลกลับของเลือด'
                  'ผ่านหลอดเลือดดำ jugular',
              'หลีกเลี่ยงการงอข้อสะโพกมากเกินไป เนื่องจากอาจเพิ่มความดันในช่องท้อง'
                  'และรบกวน venous return',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '4',
            title: 'ลดกิจกรรมที่เพิ่มความดันในช่องอกและช่องท้อง (Valsalva Maneuver)',
            items: [
              'หลีกเลี่ยงการไอ จามอย่างรุนแรง',
              'ป้องกันการเบ่งถ่ายอุจจาระ โดยดูแลป้องกันภาวะท้องผูกตามแผนการรักษา',
              'ป้องกันการคั่งของปัสสาวะและการเบ่งปัสสาวะ',
              'ในผู้ป่วยที่ใช้เครื่องช่วยหายใจ ดูแล PEEP ตามแผนการรักษาและสภาวะของผู้ป่วย '
                  'พร้อมติดตาม oxygenation และผลต่อ ICP/CPP',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '5',
            title: 'ป้องกันและจัดการภาวะไข้',
            items: [
              'ติดตามอุณหภูมิร่างกายอย่างสม่ำเสมอ',
              'ป้องกันและจัดการภาวะไข้ เนื่องจากอุณหภูมิที่สูงขึ้นทำให้ cerebral metabolic '
                  'demand เพิ่มขึ้น และอาจส่งผลให้ ICP เพิ่มขึ้น',
              'ให้ยาลดไข้ตามแผนการรักษาเมื่อมีข้อบ่งชี้',
              'เฝ้าระวังและหลีกเลี่ยง อาการหนาวสั่น (shivering) เนื่องจากทำให้ metabolic '
                  'demand และการใช้ออกซิเจนเพิ่มขึ้น',
            ],
          ),
          SizedBox(height: 12),
          _NursingCareCard(
            number: '6',
            title: 'ดูแลอุปกรณ์พยุงคอ (Cervical Collar) อย่างเหมาะสมในผู้ป่วยที่มีข้อบ่งชี้',
            items: [
              'ในผู้ป่วยที่สงสัยหรือมีการบาดเจ็บกระดูกสันหลังส่วนคอร่วมด้วย ดูแล cervical '
                  'immobilization ตามข้อบ่งชี้และแผนการรักษา',
              'ตรวจสอบอุปกรณ์พยุงคอให้อยู่ในตำแหน่งที่เหมาะสม',
              'หลีกเลี่ยงการรัดแน่นเกินไป เพราะอาจกด jugular veins และขัดขวาง '
                  'cerebral venous drainage',
              'ดูแลแนวศีรษะและคอให้เหมาะสม โดยคำนึงถึงการป้องกันการเคลื่อนไหว'
                  'ของกระดูกสันหลังส่วนคอร่วมด้วย',
            ],
          ),
          SizedBox(height: 12),
          _SourceNote(),
        ],
      ),
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return const IntroPanel(text: 'แนวทางการปฏิบัติการพยาบาลเพื่อป้องกันและลดความดันในกะโหลกศีรษะสูง');
  }
}

class _SourceNote extends StatelessWidget {
  const _SourceNote();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        'ที่มา: ดัดแปลงและเรียบเรียงจาก รุ่งนภา เขียวชะอำ (2567) '
        'และหลักฐานเชิงประจักษ์ที่เกี่ยวข้อง',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
      ),
    );
  }
}

/// Rounded card for one numbered nursing-care step: a number badge +
/// title header, then a bullet list.
class _NursingCareCard extends StatelessWidget {
  final String number;
  final String title;
  final List<String> items;

  const _NursingCareCard({required this.number, required this.title, required this.items});

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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFEDF9F3), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.primaryDark, shape: BoxShape.circle),
                  child: Text(
                    number,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          for (final item in items) ...[const SizedBox(height: 8), _BulletRow(text: item)],
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
      padding: const EdgeInsets.only(left: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7, right: 10),
            child: Icon(Icons.circle, size: 7, color: AppColors.textMuted),
          ),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textMuted)),
          ),
        ],
      ),
    );
  }
}
