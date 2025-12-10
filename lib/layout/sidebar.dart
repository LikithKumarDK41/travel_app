import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

import '../../main.dart';
import '../../core/localization/app_localizations.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: AppColors.primaryTeal,
      child: Column(
        children: [
          // User Info Header
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 24, bottom: 40),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondaryPink,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.get('nav_title'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.get('nav_subtitle'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(
                  Icons.dashboard_outlined,
                  l10n.get('menu_home'),
                  true,
                ),
                _buildMenuItem(Icons.map_outlined, l10n.get('menu_map'), false),
                _buildMenuItem(
                  Icons.favorite_border,
                  l10n.get('menu_tours'),
                  false,
                ),
                _buildMenuItem(
                  Icons.settings_outlined,
                  l10n.get('menu_settings'),
                  false,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: Colors.white12),
                ),

                // Language Switcher
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _LanguageButton(
                        label: "English",
                        locale: const Locale('en'),
                        isActive:
                            Localizations.localeOf(context).languageCode ==
                            'en',
                      ),
                      const SizedBox(width: 16),
                      _LanguageButton(
                        label: "日本語",
                        locale: const Locale('ja'),
                        isActive:
                            Localizations.localeOf(context).languageCode ==
                            'ja',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Logout / Footer
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.get('logout'),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.secondaryPink : Colors.white70,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final Locale locale;
  final bool isActive;

  const _LanguageButton({
    required this.label,
    required this.locale,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => MyApp.of(context)?.setLocale(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondaryPink : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.secondaryPink : Colors.white30,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
