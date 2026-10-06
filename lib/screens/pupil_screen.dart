import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/intro_panel.dart';

/// "Pupil Assessment" reference page — explains how to evaluate pupil
/// shape, position, equality, size, and light-reflex response
/// (Pupillary Light Reflex) between the left and right eyes.
class PupilScreen extends StatelessWidget {
  const PupilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'ประเมินรูม่านตา',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 20),
          _EyeDiagramCard(),
          SizedBox(height: 16),
          _StepsCard(),
          SizedBox(height: 12),
          _WarningCard(),
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
          'การประเมินรูม่านตาเป็นส่วนหนึ่งของการประเมินระบบประสาท โดยประเมินขนาด ความเท่ากัน '
          'และการตอบสนองต่อแสงของรูม่านตาทั้งสองข้าง การเปลี่ยนแปลงของขนาดหรือการตอบสนองต่อแสง'
          'จากค่าพื้นฐาน อาจสัมพันธ์กับการเปลี่ยนแปลงของระบบประสาท เช่น ภาวะความดันในกะโหลกศีรษะสูง '
          'การกดเบียดก้านสมอง หรือการทำงานผิดปกติของเส้นประสาทสมอง โดยเฉพาะ CN II และ CN III '
          'ซึ่งควรประเมินร่วมกับระดับความรู้สึกตัวและ neurological signs อื่น ๆ',
    );
  }
}

/// Card with the reference eye illustration showing the four things to
/// assess per eye: shape, position, equality, and size.
class _EyeDiagramCard extends StatelessWidget {
  const _EyeDiagramCard();

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
          'assets/images/S__5300254.jpg',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _Step {
  final String number;
  final String title;
  final String description;

  const _Step({required this.number, required this.title, required this.description});
}

class _StepsCard extends StatelessWidget {
  const _StepsCard();

  static const _steps = [
    _Step(
      number: '1',
      title: 'จัดสภาพแวดล้อม',
      description:
          'จัดให้มีแสงสว่างที่เหมาะสมหรือค่อนข้างสลัวหากสามารถทำได้ '
          'และให้ผู้ป่วยมองตรงไปยังวัตถุที่อยู่ไกล',
    ),
    _Step(
      number: '2',
      title: 'ประเมินปัจจัยที่อาจมีผลต่อรูม่านตา',
      description:
          'ซักประวัติความผิดปกติของตา การผ่าตัดตา การบาดเจ็บบริเวณตาหรือเบ้าตา '
          'รวมถึงยาและยาหยอดตาที่อาจมีผลต่อขนาดหรือการตอบสนองของรูม่านตา '
          'โดยควรหลีกเลี่ยงการกดบริเวณลูกตาที่สงสัยว่ามีการบาดเจ็บ',
    ),
    _Step(
      number: '3',
      title: 'สังเกตก่อนส่องไฟ',
      description:
          'ประเมิน รูปร่าง ขนาด และความเท่ากันของรูม่านตาทั้งสองข้างก่อนกระตุ้นด้วยแสง '
          'และบันทึกขนาดเป็นมิลลิเมตร โดยเปรียบเทียบตาขวาและตาซ้าย',
    ),
    _Step(
      number: '4',
      title: 'ตรวจ Direct light reflex',
      description:
          'ส่องไฟจากบริเวณหางตาไปทางหัวตาทีละข้าง แล้วสังเกตการหดตัวของรูม่านตาข้างที่ได้รับแสง',
    ),
    _Step(
      number: '5',
      title: 'ตรวจ Indirect light reflex',
      description:
          'ขณะส่องไฟเข้าตาข้างหนึ่ง ให้สังเกตการหดตัวของรูม่านตาอีกข้างหนึ่ง '
          'และตรวจเปรียบเทียบทั้งสองข้าง',
    ),
    _Step(
      number: '6',
      title: 'บันทึกผล',
      description:
          'บันทึกขนาดรูม่านตาเป็นมิลลิเมตรแยกตาขวาและซ้าย พร้อมลักษณะการตอบสนองต่อแสง '
          'เช่น Rt 3 mm, Lt 3 mm, Reactive โดยสามารถอธิบายการตอบสนองได้ดังนี้',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        border: Border.all(color: AppColors.primary, width: 1.6),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.assignment_rounded, color: AppColors.primaryDark, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'ขั้นตอนการประเมินรูม่านตา (Pupil Assessment)',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final step in _steps) ...[
            _StepRow(step: step),
            if (step != _steps.last)
              Divider(height: 1, thickness: 1, color: AppColors.primary.withValues(alpha: 0.2)),
          ],
          const SizedBox(height: 4),
          const _ReactivityBox(),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final _Step step;

  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.primary, width: 1.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              step.number,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${step.title}: ',
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                  ),
                  TextSpan(text: step.description),
                ],
              ),
              style: const TextStyle(fontSize: 13.5, height: 1.45, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}

/// Yellow box under step 6 defining the light-response terms to record.
class _ReactivityBox extends StatelessWidget {
  const _ReactivityBox();

  static const _terms = [
    ('Reactive/Brisk', 'รูม่านตาหดตัวอย่างรวดเร็วเมื่อได้รับแสง'),
    ('Sluggish', 'รูม่านตาหดตัวช้าหรือมีการตอบสนองต่อแสงลดลง'),
    ('Non-reactive/Fixed', 'รูม่านตาไม่หดตัวหรือไม่มีการเปลี่ยนแปลงของขนาดเมื่อได้รับแสง'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6D6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (term, meaning) in _terms)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7, right: 10),
                    child: Icon(Icons.circle, size: 6, color: AppColors.textDark),
                  ),
                  Expanded(
                    child: Text(
                      '$term: $meaning',
                      style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECEA),
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_rounded, color: AppColors.danger, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'ความผิดปกติที่ต้องรีบรายงาน',
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.danger),
                ),
                SizedBox(height: 4),
                Text(
                  'หากพบรูม่านตาไม่เท่ากันที่เกิดขึ้นใหม่ หรือแตกต่างจากเดิมชัดเจน '
                  'การตอบสนองต่อแสงช้าลง ขนาดรูม่านตาเปลี่ยนแปลงและการตอบสนองต่อแสงเปลี่ยนแปลง '
                  'ควรประเมินซ้ำและรายงานแพทย์ทันที เพราะอาจเป็นสัญญาณของ '
                  'neurological deterioration',
                  style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF8A3A33)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
