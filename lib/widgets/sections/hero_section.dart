import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../common/editorial_portrait.dart';
import '../common/responsive_layout.dart';
import '../common/download_apk_button.dart';

class HeroSection extends StatefulWidget {
  final ValueChanged<String>? onNavigateToSection;

  const HeroSection({
    super.key,
    this.onNavigateToSection,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Staggered Animations
  late Animation<double> _portraitFade;
  late Animation<Offset> _portraitSlide;

  late Animation<double> _greetingFade;
  late Animation<Offset> _greetingSlide;

  late Animation<double> _nameFade;
  late Animation<Offset> _nameSlide;

  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;

  late Animation<double> _descFade;
  late Animation<Offset> _descSlide;

  late Animation<double> _actionsFade;
  late Animation<Offset> _actionsSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    // Timeline ratio: 1100ms total
    // Portrait: 150ms -> 850ms (0.136 -> 0.772)
    _portraitFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(150 / 1100, 850 / 1100, curve: Curves.easeOutCubic),
    );
    _portraitSlide = Tween<Offset>(
      begin: const Offset(0, 0.06), // ~20px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(150 / 1100, 850 / 1100, curve: Curves.easeOutCubic),
    ));

    // Greeting: 250ms -> 800ms (0.227 -> 0.727)
    _greetingFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(250 / 1100, 800 / 1100, curve: Curves.easeOutCubic),
    );
    _greetingSlide = Tween<Offset>(
      begin: const Offset(0, 0.04), // ~15px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(250 / 1100, 800 / 1100, curve: Curves.easeOutCubic),
    ));

    // Name: 350ms -> 950ms (0.318 -> 0.863)
    _nameFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(350 / 1100, 950 / 1100, curve: Curves.easeOutCubic),
    );
    _nameSlide = Tween<Offset>(
      begin: const Offset(0, 0.05), // ~18px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(350 / 1100, 950 / 1100, curve: Curves.easeOutCubic),
    ));

    // Subtitle: 450ms -> 950ms (0.409 -> 0.863)
    _subtitleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(450 / 1100, 950 / 1100, curve: Curves.easeOutCubic),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.05), // ~18px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(450 / 1100, 950 / 1100, curve: Curves.easeOutCubic),
    ));

    // Description: 500ms -> 1000ms (0.454 -> 0.909)
    _descFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(500 / 1100, 1000 / 1100, curve: Curves.easeOutCubic),
    );
    _descSlide = Tween<Offset>(
      begin: const Offset(0, 0.06), // ~20px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(500 / 1100, 1000 / 1100, curve: Curves.easeOutCubic),
    ));

    // Buttons & Actions: 600ms -> 1100ms (0.545 -> 1.0)
    _actionsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(600 / 1100, 1100 / 1100, curve: Curves.easeOutCubic),
    );
    _actionsSlide = Tween<Offset>(
      begin: const Offset(0, 0.06), // ~20px
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(600 / 1100, 1100 / 1100, curve: Curves.easeOutCubic),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Responsive dimensions for Editorial Portrait (Desktop: ~420px x 540px)
    double portraitWidth = 420;
    double portraitHeight = 540;

    if (isMobile) {
      portraitWidth = 270;
      portraitHeight = 350;
    } else if (isTablet) {
      portraitWidth = 340;
      portraitHeight = 440;
    }

    // 1. HELLO, I'M Tag
    Widget greetingWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            "HELLO, I'M",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );

    // 2. Name Heading
    Widget nameWidget = Text(
      PortfolioData.name,
      style: AppTextStyles.heroHeading(isDark).copyWith(
        fontSize: isMobile ? 32 : (isTablet ? 42 : 52),
        height: 1.1,
        letterSpacing: -0.5,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
    );

    // 3. Subtitle Title
    Widget subtitleWidget = Text(
      PortfolioData.title.toUpperCase(),
      style: AppTextStyles.subtitle(isDark).copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w800,
        fontSize: isMobile ? 18 : 22,
        letterSpacing: 1.5,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
    );

    // 4. Bio Paragraph Description
    Widget descWidget = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 580),
      child: Text(
        PortfolioData.bio,
        style: AppTextStyles.body(isDark).copyWith(
          height: 1.65,
          fontSize: isMobile ? 14 : 16,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
      ),
    );

    // 5. Buttons & Social Link Actions
    Widget actionsWidget = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => widget.onNavigateToSection?.call('projects'),
              icon: const Icon(Icons.work_outline_rounded, size: 18),
              label: const Text('View Projects'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: primaryColor.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const DownloadApkButton(
              variant: DownloadApkButtonVariant.outlined,
            ),
            OutlinedButton.icon(
              onPressed: () => widget.onNavigateToSection?.call('contact'),
              icon: const Icon(Icons.mail_outline_rounded, size: 18),
              label: const Text('Get In Touch'),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                side: BorderSide(
                  color: primaryColor.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.elementSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _SocialIconLink(
              icon: Icons.code_rounded,
              tooltip: 'GitHub Profile',
              onPressed: () => _launchUrl(PortfolioData.githubUrl),
              isDark: isDark,
              primaryColor: primaryColor,
            ),
            const SizedBox(width: 8),
            _SocialIconLink(
              icon: Icons.link_rounded,
              tooltip: 'LinkedIn Profile',
              onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
              isDark: isDark,
              primaryColor: primaryColor,
            ),
            const SizedBox(width: 8),
            _SocialIconLink(
              icon: Icons.email_rounded,
              tooltip: 'Email Direct',
              onPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
              isDark: isDark,
              primaryColor: primaryColor,
            ),
          ],
        ),
      ],
    );

    // 6. Editorial Portrait Area
    Widget portraitWidget = EditorialPortrait(
      width: portraitWidth,
      height: portraitHeight,
      isMobile: isMobile,
    );

    // Apply staggered entrance transitions if animations enabled
    if (!disableAnimations) {
      greetingWidget = FadeTransition(
        opacity: _greetingFade,
        child: SlideTransition(
          position: _greetingSlide,
          child: greetingWidget,
        ),
      );

      nameWidget = FadeTransition(
        opacity: _nameFade,
        child: SlideTransition(
          position: _nameSlide,
          child: nameWidget,
        ),
      );

      subtitleWidget = FadeTransition(
        opacity: _subtitleFade,
        child: SlideTransition(
          position: _subtitleSlide,
          child: subtitleWidget,
        ),
      );

      descWidget = FadeTransition(
        opacity: _descFade,
        child: SlideTransition(
          position: _descSlide,
          child: descWidget,
        ),
      );

      actionsWidget = FadeTransition(
        opacity: _actionsFade,
        child: SlideTransition(
          position: _actionsSlide,
          child: actionsWidget,
        ),
      );

      portraitWidget = FadeTransition(
        opacity: _portraitFade,
        child: SlideTransition(
          position: _portraitSlide,
          child: portraitWidget,
        ),
      );
    }

    Widget contentColumn = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        greetingWidget,
        const SizedBox(height: AppSpacing.itemSpacing * 0.9),
        nameWidget,
        const SizedBox(height: AppSpacing.xsSpacing * 1.5),
        subtitleWidget,
        const SizedBox(height: AppSpacing.itemSpacing * 1.2),
        descWidget,
        const SizedBox(height: AppSpacing.elementSpacing * 1.2),
        actionsWidget,
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24.0 : 48.0,
        horizontal: AppSpacing.elementSpacing,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                portraitWidget,
                const SizedBox(height: AppSpacing.sectionSpacing * 0.8),
                contentColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: contentColumn,
                ),
                const SizedBox(width: AppSpacing.elementSpacing * 1.5),
                Expanded(
                  flex: 5,
                  child: portraitWidget,
                ),
              ],
            ),
    );
  }
}

class _SocialIconLink extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isDark;
  final Color primaryColor;

  const _SocialIconLink({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  State<_SocialIconLink> createState() => _SocialIconLinkState();
}

class _SocialIconLinkState extends State<_SocialIconLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.primaryColor.withValues(alpha: 0.15)
                : (widget.isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? widget.primaryColor
                  : (widget.isDark
                      ? AppColors.darkCardBorder
                      : AppColors.lightCardBorder),
              width: 1.2,
            ),
          ),
          child: IconButton(
            icon: Icon(widget.icon, size: 20),
            color: _isHovered
                ? widget.primaryColor
                : (widget.isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary),
            onPressed: widget.onPressed,
            splashRadius: 22,
          ),
        ),
      ),
    );
  }
}
