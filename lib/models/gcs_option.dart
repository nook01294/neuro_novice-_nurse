import 'package:flutter/material.dart';

/// One selectable choice within a GCS sub-scale (Eye / Verbal / Motor).
///
/// [score] is the raw display value ("4", "NT", ...); [value] is its
/// numeric contribution to the total (null for "Not testable").
class GcsOption {
  final String score;
  final int? value;
  final String label;
  final String labelEn;
  final String? note;

  const GcsOption({
    required this.score,
    required this.value,
    required this.label,
    required this.labelEn,
    this.note,
  });

  bool get isTestable => value != null;
}

/// One GCS sub-scale (Eye Opening, Verbal Response, or Motor Response).
class GcsCategory {
  final String code;
  final String title;
  final String titleEn;
  final IconData icon;
  final List<GcsOption> options;

  const GcsCategory({
    required this.code,
    required this.title,
    required this.titleEn,
    required this.icon,
    required this.options,
  });
}

/// Source data transcribed from the hospital's GCS reference card
/// (ดัดแปลงและแปลเป็นภาษาไทยจาก: Glasgow Coma Scale: Do it this way,
/// Institute of Neurological Sciences, NHS Greater Glasgow and Clyde, 2014).
class GcsData {
  GcsData._();

  static const eyeOpening = GcsCategory(
    code: 'E',
    title: 'การลืมตา',
    titleEn: 'Eye Opening',
    icon: Icons.visibility_rounded,
    options: [
      GcsOption(score: '4', value: 4, label: 'ลืมตาได้เอง', labelEn: 'Spontaneous'),
      GcsOption(score: '3', value: 3, label: 'ลืมตาเมื่อได้ยินเสียง', labelEn: 'To sound'),
      GcsOption(score: '2', value: 2, label: 'ลืมตาเมื่อได้รับแรงกด', labelEn: 'To pressure'),
      GcsOption(score: '1', value: 1, label: 'ไม่ลืมตา', labelEn: 'None'),
      GcsOption(
        score: 'NT',
        value: null,
        label: 'ประเมินไม่ได้',
        labelEn: 'Not testable',
        note: 'ตาบวมปิด 2 ข้าง, อุบัติเหตุรุนแรงดวงตา 2 ข้าง',
      ),
    ],
  );

  static const verbalResponse = GcsCategory(
    code: 'V',
    title: 'การพูดคุย',
    titleEn: 'Verbal Response',
    icon: Icons.record_voice_over_rounded,
    options: [
      GcsOption(score: '5', value: 5, label: 'พูดคุยได้ไม่สับสน', labelEn: 'Orientated'),
      GcsOption(score: '4', value: 4, label: 'พูดคุยได้แต่สับสน', labelEn: 'Confused'),
      GcsOption(score: '3', value: 3, label: 'พูดเป็นคำๆ', labelEn: 'Words'),
      GcsOption(score: '2', value: 2, label: 'ส่งเสียงไม่เป็นคำพูด', labelEn: 'Sounds'),
      GcsOption(score: '1', value: 1, label: 'ไม่ส่งเสียงใดๆ', labelEn: 'None'),
      GcsOption(
        score: 'NT',
        value: null,
        label: 'ประเมินไม่ได้',
        labelEn: 'Not testable',
        note: 'On ETT, Tracheostomy, บาดเจ็บรุนแรงบริเวณปาก',
      ),
    ],
  );

  static const motorResponse = GcsCategory(
    code: 'M',
    title: 'การเคลื่อนไหว',
    titleEn: 'Motor Response',
    icon: Icons.accessibility_new_rounded,
    options: [
      GcsOption(score: '6', value: 6, label: 'เคลื่อนไหวได้ตามคำสั่ง', labelEn: 'Obeys commands'),
      GcsOption(score: '5', value: 5, label: 'ทราบตำแหน่งที่ถูกกระตุ้น', labelEn: 'Localising'),
      GcsOption(score: '4', value: 4, label: 'ชักแขนขาหนี/งอข้อแขนขึ้นปกติ', labelEn: 'Normal flexion'),
      GcsOption(score: '3', value: 3, label: 'แขนงอหมุนเข้าผิดปกติ', labelEn: 'Abnormal flexion'),
      GcsOption(score: '2', value: 2, label: 'แขนเหยียดผิดปกติ', labelEn: 'Extension'),
      GcsOption(score: '1', value: 1, label: 'ไม่เคลื่อนไหวเลย', labelEn: 'None'),
      GcsOption(
        score: 'NT',
        value: null,
        label: 'ประเมินไม่ได้',
        labelEn: 'Not testable',
        note: 'แขนหรือขาบาดเจ็บจนไม่สามารถประเมินได้, ได้รับยาคลายกล้ามเนื้อ/ยากดประสาท',
      ),
    ],
  );

  static const List<GcsCategory> categories = [eyeOpening, verbalResponse, motorResponse];

  static const String source =
      'ดัดแปลงและแปลเป็นภาษาไทยจาก: Glasgow Coma Scale: Do it this way, '
      'Institute of Neurological Sciences, NHS Greater Glasgow and Clyde (2014)';
}

enum GcsSeverity { mild, moderate, severe }

extension GcsSeverityLabel on GcsSeverity {
  String get label {
    switch (this) {
      case GcsSeverity.mild:
        return 'Mild (บาดเจ็บเล็กน้อย)';
      case GcsSeverity.moderate:
        return 'Moderate (บาดเจ็บปานกลาง)';
      case GcsSeverity.severe:
        return 'Severe (บาดเจ็บรุนแรง)';
    }
  }
}

/// Total score → severity, per: 13-15 Mild, 9-12 Moderate, 3-8 Severe.
GcsSeverity gcsSeverityOf(int total) {
  if (total >= 13) return GcsSeverity.mild;
  if (total >= 9) return GcsSeverity.moderate;
  return GcsSeverity.severe;
}
