import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/contact_card.dart';
import '../common/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Frontend Demo Form: Message preview simulated. Use direct Email or Phone for direct contact!',
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    final contactCards = [
      ContactCard(
        icon: Icons.email_rounded,
        title: 'Email Direct',
        detail: PortfolioData.email,
        url: 'mailto:${PortfolioData.email}',
      ),
      ContactCard(
        icon: Icons.phone_rounded,
        title: 'Phone / Dial',
        detail: PortfolioData.phone,
        url: 'tel:${PortfolioData.phone.replaceAll(RegExp(r'[^\d+]'), '')}',
      ),
      ContactCard(
        icon: Icons.code_rounded,
        title: 'GitHub Profile',
        detail: 'github.com/mariyavarghese084',
        url: PortfolioData.githubUrl,
      ),
      ContactCard(
        icon: Icons.link_rounded,
        title: 'LinkedIn Profile',
        detail: 'linkedin.com/in/mariya-varghese',
        url: PortfolioData.linkedinUrl,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final useStackedLayout = isMobile || constraints.maxWidth < 850;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 32.0 : 56.0,
            horizontal: AppSpacing.elementSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Get In Touch',
                subtitle: 'Direct Channels & Contact',
              ),
              const SizedBox(height: AppSpacing.sectionSpacing * 0.8),

              if (useStackedLayout) ...[
                // Stacked Layout: Contact Cards first, then Form below
                ...contactCards.map(
                  (card) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSpacing.itemSpacing),
                    child: card,
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionSpacing * 0.4),
                _buildContactForm(context, isDark, primaryColor),
              ] else ...[
                // Two-Column Desktop Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Interactive Contact Cards
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: contactCards
                            .map(
                              (card) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.itemSpacing),
                                child: card,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sectionSpacing * 0.8),

                    // Right Column: Frontend Form Card
                    Expanded(
                      flex: 6,
                      child: _buildContactForm(context, isDark, primaryColor),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactForm(
      BuildContext context, bool isDark, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.elementSpacing * 1.2),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Send a Message',
                    style: AppTextStyles.cardTitle(isDark).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                // Notice Chip: Frontend Only
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Text(
                    'Frontend Only',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Fill in the fields below to simulate sending a message.',
              style: AppTextStyles.bodySmall(isDark).copyWith(fontSize: 12),
            ),
            const SizedBox(height: AppSpacing.elementSpacing),

            // Name Input
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                prefixIcon: const Icon(Icons.person_outline_rounded, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
              validator: (val) =>
                  (val == null || val.isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: AppSpacing.itemSpacing),

            // Email Input
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Your Email',
                prefixIcon: const Icon(Icons.email_outlined, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Please enter your email';
                if (!val.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.itemSpacing),

            // Message Input
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
              validator: (val) => (val == null || val.isEmpty)
                  ? 'Please enter a message'
                  : null,
            ),
            const SizedBox(height: AppSpacing.elementSpacing),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleSubmitForm,
                icon: const Icon(Icons.send_rounded, size: 16),
                label: const Text('Send Message'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
