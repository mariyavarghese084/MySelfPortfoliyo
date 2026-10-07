import 'package:flutter/material.dart';
import '../app/theme/app_spacing.dart';
import '../widgets/common/responsive_layout.dart';
import '../widgets/common/profile_image.dart';
import '../widgets/common/fade_in_section.dart';
import '../widgets/navigation/desktop_navigation.dart';
import '../widgets/navigation/mobile_navigation.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/education_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/footer_section.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final keysMap = <String, GlobalKey>{
      'home': _homeKey,
      'about': _aboutKey,
      'skills': _skillsKey,
      'experience': _experienceKey,
      'projects': _projectsKey,
      'education': _educationKey,
      'contact': _contactKey,
    };

    String currentActive = _activeSection;
    final scrollOffset = _scrollController.offset;

    for (final entry in keysMap.entries) {
      final keyContext = entry.value.currentContext;
      if (keyContext != null) {
        final renderBox = keyContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          if (position.dy <= 180) {
            currentActive = entry.key;
          }
        }
      }
    }

    if (scrollOffset < 100) {
      currentActive = 'home';
    }

    if (currentActive != _activeSection) {
      setState(() {
        _activeSection = currentActive;
      });
    }
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    final secLower = section.toLowerCase();
    switch (secLower) {
      case 'home':
        targetKey = _homeKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'skills':
        targetKey = _skillsKey;
        break;
      case 'experience':
        targetKey = _experienceKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'education':
        targetKey = _educationKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: AppDurations.slow,
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _activeSection = secLower;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: !isDesktop
          ? AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ProfileImage(
                    size: 30,
                    showBorder: true,
                    showBadge: false,
                  ),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text(
                      'Mariya Varghese',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    widget.isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: widget.isDark
                        ? const Color(0xFFFACC15)
                        : primaryColor,
                  ),
                  onPressed: widget.onToggleTheme,
                ),
              ],
            )
          : null,
      drawer: !isDesktop
          ? MobileNavigationDrawer(
              activeSection: _activeSection,
              isDark: widget.isDark,
              onToggleTheme: widget.onToggleTheme,
              onNavItemSelected: _scrollToSection,
            )
          : null,
      body: SelectionArea(
        child: Column(
          children: [
            if (isDesktop)
              DesktopNavigation(
                activeSection: _activeSection,
                isDark: widget.isDark,
                onToggleTheme: widget.onToggleTheme,
                onNavItemSelected: _scrollToSection,
              ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppSpacing.maxContentWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeroSection(
                          key: _homeKey,
                          onNavigateToSection: _scrollToSection,
                        ),
                        FadeInSection(delayMs: 50, child: AboutSection(key: _aboutKey)),
                        FadeInSection(delayMs: 100, child: SkillsSection(key: _skillsKey)),
                        FadeInSection(delayMs: 150, child: ExperienceSection(key: _experienceKey)),
                        FadeInSection(delayMs: 200, child: ProjectsSection(key: _projectsKey)),
                        FadeInSection(delayMs: 250, child: EducationSection(key: _educationKey)),
                        FadeInSection(delayMs: 300, child: ContactSection(key: _contactKey)),
                        const FadeInSection(delayMs: 350, child: FooterSection()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
