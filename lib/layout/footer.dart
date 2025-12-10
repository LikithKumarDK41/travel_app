import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../layout/header.dart';
import '../../core/localization/app_localizations.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Container(
      color: AppColors.primaryGreen,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.get('app_title'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.get('footer_desc'),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(width: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterTitle(l10n.get('footer_company')),
                      _buildFooterLink(l10n.get('footer_about')),
                      _buildFooterLink(l10n.get('footer_careers')),
                      _buildFooterLink(l10n.get('footer_contact')),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterTitle(l10n.get('footer_legal')),
                      _buildFooterLink(l10n.get('footer_terms')),
                      _buildFooterLink(l10n.get('footer_privacy')),
                      _buildFooterLink(l10n.get('footer_cookies')),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.get('footer_copyright'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  _buildSocialIcon(Icons.facebook),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.camera_alt), // Instagram-like
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.alternate_email), // Twitter-like
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Icon(icon, color: Colors.white, size: 20);
  }
}
