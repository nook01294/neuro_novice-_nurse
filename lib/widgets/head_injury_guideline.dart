import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Shared building blocks for the head-injury-severity nursing guideline
/// screens (Mild / Moderate / Severe): the rounded-card chrome, the
/// checklist and warning-signs cards, and the bullet/info rows used inside
/// the "ประเมินและติดตาม" card.

/// Shared rounded-card chrome used by every section below the header.
class GuidelineCard extends StatelessWidget {
  final Color background;
  final Widget child;

  const GuidelineCard({super.key, required this.background, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        boxShadow: AppColors.cardShadow,
      ),
      child: child,
    );
  }
}

/// Icon-circle + title (+ optional subtitle) heading used at the top of
/// every card.
class GuidelineCardHeading extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color iconColor;
  final Color iconBackground;
  final Color titleColor;

  const GuidelineCardHeading({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.iconColor,
    required this.iconBackground,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: titleColor),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A row of timeline boxes connected by forward-arrow separators.
class TimelineArrowRow extends StatelessWidget {
  final List<Widget> boxes;

  const TimelineArrowRow({super.key, required this.boxes});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < boxes.length; i++) ...[
          Expanded(child: boxes[i]),
          if (i != boxes.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.textMuted),
            ),
        ],
      ],
    );
  }
}

/// Compact, centered timeline box (icon on top, text stacked below) used
/// when three or more steps need to share a row.
class CompactTimelineBox extends StatelessWidget {
  final String primary;
  final String secondary;

  const CompactTimelineBox({super.key, required this.primary, required this.secondary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3FBF7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.schedule_rounded, size: 18, color: AppColors.primaryDark),
          const SizedBox(height: 6),
          Text(
            primary,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark),
          ),
          const SizedBox(height: 1),
          Text(
            secondary,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

/// Dotted bullet list, e.g. the assessment points in "ประเมินและติดตาม".
class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 7, left: 4, right: 10),
                  child: Icon(Icons.circle, size: 6, color: AppColors.textDark),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Muted "(i) hint" row, e.g. "ปรับความถี่ตามอาการ คำสั่งแพทย์ และแนวปฏิบัติของหน่วยงาน".
class InfoNoteRow extends StatelessWidget {
  final String text;

  const InfoNoteRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted)),
        ),
      ],
    );
  }
}

/// A labelled sub-point shown in a tinted box under a checklist item,
/// e.g. "ชัก: จัดสิ่งแวดล้อมให้ปลอดภัย ...".
class ChecklistDetail {
  final IconData icon;
  final String label;
  final String text;

  const ChecklistDetail({required this.icon, required this.label, required this.text});
}

class ChecklistItem {
  final IconData icon;
  final String text;
  final List<ChecklistDetail> details;

  const ChecklistItem({required this.icon, required this.text, this.details = const []});
}

/// White card with a heading and a divided list of check-marked nursing
/// actions, e.g. "การพยาบาลสำคัญ".
class ChecklistCard extends StatelessWidget {
  final IconData headingIcon;
  final String title;
  final List<ChecklistItem> items;

  const ChecklistCard({
    super.key,
    required this.headingIcon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GuidelineCard(
      background: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GuidelineCardHeading(
            icon: headingIcon,
            title: title,
            iconColor: AppColors.primaryDark,
            iconBackground: const Color(0xFFDDF3E7),
            titleColor: AppColors.primaryDark,
          ),
          const SizedBox(height: 10),
          ChecklistList(items: items),
        ],
      ),
    );
  }
}

/// Divided list of check-marked nursing actions; the body of
/// [ChecklistCard].
class ChecklistList extends StatelessWidget {
  final List<ChecklistItem> items;

  const ChecklistList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFB),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
                          const SizedBox(width: 10),
                          Icon(items[i].icon, color: AppColors.primaryDark, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              items[i].text,
                              style: const TextStyle(
                                fontSize: 13.5,
                                height: 1.4,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Sub-items start under the item's icon (past the 20px
                      // check + 10px gap), so they get more line width.
                      if (items[i].details.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: _ChecklistDetails(details: items[i].details),
                        ),
                      ],
                    ],
                  ),
                ),
                if (i != items.length - 1)
                  Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
              ],
            ),
        ],
      ),
    );
  }
}

class _ChecklistDetails extends StatelessWidget {
  final List<ChecklistDetail> details;

  const _ChecklistDetails({required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3FBF7),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        children: [
          for (var i = 0; i < details.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(details[i].icon, size: 18, color: AppColors.primaryDark),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${details[i].label}: ',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: details[i].text),
                        ],
                      ),
                      style: const TextStyle(fontSize: 12, height: 1.25, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            ),
            if (i != details.length - 1)
              Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06)),
          ],
        ],
      ),
    );
  }
}

class WarningSign {
  final IconData icon;
  final String text;

  const WarningSign({required this.icon, required this.text});
}

class _WarningCell extends StatelessWidget {
  final WarningSign sign;

  const _WarningCell({required this.sign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(sign.icon, size: 17, color: const Color(0xFFC97A1E)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              sign.text,
              style: const TextStyle(fontSize: 12, height: 1.3, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}

/// Peach card listing neurological deterioration warning signs in a grid
/// of [columns] columns, optionally followed by [trailing] content, and
/// ending in a red escalation banner.
class WarningSignsCard extends StatelessWidget {
  final String title;
  final List<WarningSign> signs;
  final int columns;
  final String bannerText;
  final Widget? trailing;

  const WarningSignsCard({
    super.key,
    this.title = 'เฝ้าระวังและรายงาน',
    required this.signs,
    this.columns = 2,
    this.bannerText = 'พบความผิดปกติให้รายงานแพทย์/ทีมรักษาทันที',
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06));
    return GuidelineCard(
      background: const Color(0xFFFDF3E7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GuidelineCardHeading(
            icon: Icons.warning_rounded,
            title: title,
            iconColor: const Color(0xFFC97A1E),
            iconBackground: const Color(0xFFFBE4C4),
            titleColor: const Color(0xFFC97A1E),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              children: [
                for (var i = 0; i < signs.length; i += columns) ...[
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var j = i; j < i + columns; j++) ...[
                          if (j != i) Container(width: 1, color: Colors.black.withValues(alpha: 0.06)),
                          Expanded(
                            child: j < signs.length ? _WarningCell(sign: signs[j]) : const SizedBox(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (i + columns < signs.length) divider,
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(height: 10),
            trailing!,
          ],
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.danger,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bannerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
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

/// Muted footer disclaimer shown at the bottom of every guideline screen.
class GuidelineFooterNote extends StatelessWidget {
  final String text;

  const GuidelineFooterNote({
    super.key,
    this.text = 'ใช้เพื่อสนับสนุนการพยาบาล ไม่ใช่แทนวิจารณญาณทางคลินิก',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
