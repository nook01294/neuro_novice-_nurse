import 'package:flutter/material.dart';
import '../models/gcs_option.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import 'mild_head_injury_screen.dart';
import 'moderate_head_injury_screen.dart';
import 'nursing_guideline_screen.dart';
import 'severe_head_injury_screen.dart';

/// ประเมิน GCS (Glasgow Coma Scale) — เลือกการตอบสนองที่ดีที่สุดในแต่ละหมวด
/// (Eye / Verbal / Motor) แล้วแอปจะรวมคะแนนและประเมินความรุนแรงให้อัตโนมัติ
class GcsAssessScreen extends StatefulWidget {
  const GcsAssessScreen({super.key});

  @override
  State<GcsAssessScreen> createState() => _GcsAssessScreenState();
}

class _GcsAssessScreenState extends State<GcsAssessScreen> {
  final Map<String, GcsOption?> _selected = {
    GcsData.eyeOpening.code: null,
    GcsData.verbalResponse.code: null,
    GcsData.motorResponse.code: null,
  };

  bool get _allAnswered => _selected.values.every((o) => o != null);

  bool get _hasNotTestable =>
      _selected.values.any((o) => o != null && !o.isTestable);

  int? get _total {
    if (!_allAnswered || _hasNotTestable) return null;
    return _selected.values.fold<int>(0, (sum, o) => sum + o!.value!);
  }

  void _select(String code, GcsOption option) {
    setState(() {
      _selected[code] = _selected[code] == option ? null : option;
    });
  }

  void _reset() => setState(() => _selected.updateAll((_, _) => null));

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      title: 'ประเมิน GCS',
      actions: [
        IconButton(
          tooltip: 'เริ่มใหม่',
          onPressed: _selected.values.any((o) => o != null) ? _reset : null,
          icon: const Icon(Icons.refresh),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        children: [
          for (final category in GcsData.categories) ...[
            _GcsCategoryCard(
              category: category,
              selected: _selected[category.code],
              onSelect: (option) => _select(category.code, option),
            ),
            const SizedBox(height: 12),
          ],
          _NursingGuidelineButton(total: _total),
          const SizedBox(height: 12),
          Text(
            GcsData.source,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 12),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: _GcsResultCard(selected: _selected, total: _total),
      ),
    );
  }
}

class _GcsCategoryCard extends StatelessWidget {
  final GcsCategory category;
  final GcsOption? selected;
  final ValueChanged<GcsOption> onSelect;

  const _GcsCategoryCard({
    required this.category,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppColors.cardRadius);
    final remark = category.options
        .where((o) => o.note != null)
        .map((o) => o.note!)
        .join('; ');
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: radius,
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  category.code,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(category.icon, color: AppColors.primaryDark, size: 26),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.titleEn,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          for (final option in category.options)
            _GcsOptionTile(
              option: option,
              selected: selected == option,
              onTap: () => onSelect(option),
              showDivider: option != category.options.last,
            ),
          if (remark.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 10, 2, 6),
              child: Text(
                '* $remark',
                style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
              ),
            ),
        ],
      ),
    );
  }
}

/// When a total score could be calculated, jump straight to the guideline
/// for that severity; otherwise fall back to the severity picker.
Widget _destinationFor(int? total) {
  if (total == null) return const NursingGuidelineScreen();
  switch (gcsSeverityOf(total)) {
    case GcsSeverity.mild:
      return const MildHeadInjuryScreen();
    case GcsSeverity.moderate:
      return const ModerateHeadInjuryScreen();
    case GcsSeverity.severe:
      return const SevereHeadInjuryScreen();
  }
}

class _NursingGuidelineButton extends StatelessWidget {
  final int? total;

  const _NursingGuidelineButton({required this.total});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppColors.cardRadius);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: radius,
        boxShadow: AppColors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => _destinationFor(total)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                const Icon(Icons.menu_book_rounded, color: AppColors.primaryDark, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'แนวทางการพยาบาล',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GcsOptionTile extends StatelessWidget {
  final GcsOption option;
  final bool selected;
  final VoidCallback onTap;
  final bool showDivider;

  const _GcsOptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      option.score,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15.5, color: AppColors.textDark),
                        children: [
                          TextSpan(
                            text: option.labelEn,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' (${option.label})'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _RadioCircle(selected: selected),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
      ],
    );
  }
}

class _RadioCircle extends StatelessWidget {
  final bool selected;

  const _RadioCircle({required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.primaryDark : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.primaryDark : AppColors.textMuted.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 15, color: Colors.white)
          : null,
    );
  }
}

class _GcsResultCard extends StatelessWidget {
  final Map<String, GcsOption?> selected;
  final int? total;

  const _GcsResultCard({required this.selected, required this.total});

  @override
  Widget build(BuildContext context) {
    final e = selected[GcsData.eyeOpening.code];
    final v = selected[GcsData.verbalResponse.code];
    final m = selected[GcsData.motorResponse.code];
    final anyAnswered = e != null || v != null || m != null;
    final allAnswered = e != null && v != null && m != null;
    final hasNt = [e, v, m].any((o) => o != null && !o.isTestable);

    final notation =
        'E${e?.score ?? '_'}V${v?.score ?? '_'}M${m?.score ?? '_'}';

    Widget summary;
    if (!anyAnswered) {
      summary = const Text(
        'เลือกการตอบสนองที่ดีที่สุดในแต่ละหมวดด้านบน',
        style: TextStyle(fontSize: 13, color: AppColors.textMuted),
      );
    } else if (!allAnswered) {
      summary = Text(
        '$notation — เลือกให้ครบทั้ง 3 หมวดเพื่อรวมคะแนน',
        style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
      );
    } else if (hasNt) {
      summary = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notation,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.danger,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'ไม่สามารถคำนวณคะแนนรวมได้ — บันทึกทางการพยาบาล (Nursing note) แทน',
            style: TextStyle(fontSize: 12.5, color: AppColors.danger),
          ),
        ],
      );
    } else {
      final severity = gcsSeverityOf(total!);
      final color = switch (severity) {
        GcsSeverity.mild => AppColors.primaryDark,
        GcsSeverity.moderate => const Color(0xFFC97A1E),
        GcsSeverity.severe => AppColors.danger,
      };
      summary = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notation,
                  style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
                Text(
                  'รวม $total คะแนน',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              severity.label,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        child: Material(
          color: AppColors.cardBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: summary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
