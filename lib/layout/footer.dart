
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../layout/header.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      "NARA GUIDE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Your ultimate companion for exploring the ancient capital of Japan. Discover serenity, history, and nature.",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (MediaQuery.of(context).size.width > 600) ...[
                const SizedBox(width: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterTitle("Company"),
                      _buildFooterLink("About Us"),
                      _buildFooterLink("Careers"),
                      _buildFooterLink("Contact"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterTitle("Legal"),
                      _buildFooterLink("Terms"),
                      _buildFooterLink("Privacy"),
                      _buildFooterLink("Cookies"),
                    ],
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© 2024 Nara Guide. All rights reserved.",
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
              )
            ],
          )
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
    return Icon(
      icon,
      color: Colors.white,
      size: 20,
    );
  }
}