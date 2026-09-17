import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

/// "ขั้นตอนการประเมิน" tab — walks through the 4-step procedure (Check,
/// Observe, Stimulate, Score) nurses follow when performing a Glasgow Coma
/// Scale assessment.
class AssessScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const AssessScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'ขั้นตอนการประเมิน GCS',
      automaticallyImplyLeading: false,
      body: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _IntroText(),
          SizedBox(height: 16),
          _StepCard(
            number: '1',
            title: 'Check',
            description:
                'ตรวจสอบก่อนการประเมินว่ามีปัจจัยใดที่อาจทำให้ไม่สามารถติดต่อสื่อสาร'
                'กับผู้บาดเจ็บได้ หรือทำให้ผู้บาดเจ็บไม่สามารถตอบสนองได้ '
                'หรือมีการบาดเจ็บอื่นร่วมด้วย',
            child: _CheckPoints(),
          ),
          SizedBox(height: 12),
          _StepCard(
            number: '2',
            title: 'Observe',
            description:
                'สังเกตการลืมตา สาระการพูด (content of speech) และการเคลื่อนไหว'
                'ของร่างกายซีกซ้ายและขวา',
            child: _ObservePoints(),
          ),
          SizedBox(height: 12),
          _StepCard(
            number: '3',
            title: 'Stimulate',
            description:
                'การกระตุ้นด้วยเสียงพูด หรือตะโกนออกคำสั่ง ถ้าไม่ตอบสนองจึงกระตุ้น'
                'ด้วยความเจ็บปวด โดยการกดที่ปลายเล็บ กล้ามเนื้อ trapezius '
                'ตรงบริเวณหัวไหล่ด้านหลัง หรือขอบตาบน (supraorbital notch)',
            child: _StimulateImage(),
          ),
          SizedBox(height: 12),
          _StepCard(
            number: '4',
            title: 'Score',
            description: 'ให้คะแนนจากการตอบสนองที่ดีที่สุด',
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
      'การประเมินระดับความรู้สึกตัวด้วย GCS ประกอบด้วย 4 ขั้นตอนสำคัญ',
      style: TextStyle(fontSize: 14.5, height: 1.6, color: AppColors.textOnBackground),
    );
  }
}

/// Shared card chrome for one of the 4 numbered GCS steps: number badge +
/// title, an explanatory paragraph, and an optional detail widget below.
class _StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final Widget? child;

  const _StepCard({
    required this.number,
    required this.title,
    required this.description,
    this.child,
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
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 13.5, height: 1.5, color: AppColors.textDark),
          ),
          if (child != null) ...[
            const SizedBox(height: 12),
            child!,
          ],
        ],
      ),
    );
  }
}

class _CheckPoint {
  final IconData icon;
  final String text;

  const _CheckPoint({required this.icon, required this.text});
}

class _CheckPoints extends StatelessWidget {
  const _CheckPoints();

  static const _points = [
    _CheckPoint(
      icon: Icons.psychology_rounded,
      text: 'สภาพของผู้ป่วยก่อนการบาดเจ็บ เช่น ความผิดปกติทางระบบประสาทที่มีอยู่ก่อน '
          'ปัญหาการได้ยิน ปัญหาการพูด รวมถึงภาษาและวัฒนธรรมของผู้ป่วย',
    ),
    _CheckPoint(
      icon: Icons.air_rounded,
      text: 'ผลจากการรักษาเบื้องต้น เช่น การใส่ท่อช่วยหายใจ การได้รับยาบางชนิด',
    ),
    _CheckPoint(
      icon: Icons.personal_injury_rounded,
      text: 'มีการบาดเจ็บหรือความผิดปกติระบบประสาทอื่นร่วมด้วย เช่น กระดูกใบหน้าหัก '
          'ภาวะ dysphasia หรือ hemiplegia และมีการบาดเจ็บไขสันหลัง',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final point in _points) ...[
          _CheckPointRow(point: point),
          if (point != _points.last)
            Divider(height: 20, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
        ],
      ],
    );
  }
}

class _CheckPointRow extends StatelessWidget {
  final _CheckPoint point;

  const _CheckPointRow({required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(point.icon, size: 22, color: AppColors.primaryDark),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            point.text,
            style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }
}

class _ObservePoint {
  final IconData icon;
  final String label;

  const _ObservePoint({required this.icon, required this.label});
}

class _ObservePoints extends StatelessWidget {
  const _ObservePoints();

  static const _points = [
    _ObservePoint(icon: Icons.remove_red_eye_rounded, label: 'การลืมตา'),
    _ObservePoint(icon: Icons.chat_bubble_rounded, label: 'สาระการพูด\n(content of speech)'),
    _ObservePoint(
      icon: Icons.accessibility_new_rounded,
      label: 'การเคลื่อนไหว\nของร่างกายซีกซ้ายและขวา',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF9F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          for (final point in _points) ...[
            Expanded(child: _ObservePointColumn(point: point)),
            if (point != _points.last)
              SizedBox(
                height: 56,
                child: VerticalDivider(color: Colors.black.withValues(alpha: 0.1), width: 1),
              ),
          ],
        ],
      ),
    );
  }
}

class _ObservePointColumn extends StatelessWidget {
  final _ObservePoint point;

  const _ObservePointColumn({required this.point});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(point.icon, size: 26, color: AppColors.primaryDark),
        const SizedBox(height: 6),
        Text(
          point.label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
      ],
    );
  }
}

/// Reference photo showing the three stimulation sites (fingertip pressure,
/// trapezius pinch, supraorbital notch) in a single combined image.
class _StimulateImage extends StatelessWidget {
  const _StimulateImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF9F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/S__1654795.jpg',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '(ภาพประกอบจาก www.glasgowcomascale.org)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
