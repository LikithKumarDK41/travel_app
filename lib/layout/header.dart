import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../main.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final bool isTransparent;

  const AppHeader({super.key, this.onMenuPressed, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: isTransparent
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.95)],
              ),
        boxShadow: isTransparent
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Row(
        children: [
          // Logo and Title
          if (!isTransparent)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryTeal,
                        AppColors.primaryTeal.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTeal.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.location_city_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.get('splash_title'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      l10n.get('splash_tagline'),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          const Spacer(),

          // Right Icons
          Row(
            children: [
              _buildHeaderIcon(
                Icons.search_rounded,
                isTransparent,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildHeaderIcon(
                Icons.notifications_none_rounded,
                isTransparent,
                showBadge: true,
                onTap: () {},
              ),
              const SizedBox(width: 12),
              // Profile Menu
              PopupMenuButton<String>(
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primaryTeal, AppColors.accentYellow],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTeal.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                itemBuilder: (BuildContext context) => [
                  // User Profile Section
                  PopupMenuItem<String>(
                    enabled: false,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryTeal,
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sarah Johnson',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'sarah.j@example.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),

                  // Language Section Header
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Row(
                      children: [
                        Icon(
                          Icons.translate_rounded,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Language',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'lang_en',
                    child: Row(
                      children: [
                        const SizedBox(width: 26),
                        Icon(
                          Localizations.localeOf(context).languageCode == 'en'
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: 20,
                          color:
                              Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? AppColors.primaryTeal
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        const Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'lang_ja',
                    child: Row(
                      children: [
                        const SizedBox(width: 26),
                        Icon(
                          Localizations.localeOf(context).languageCode == 'ja'
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: 20,
                          color:
                              Localizations.localeOf(context).languageCode ==
                                  'ja'
                              ? AppColors.primaryTeal
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        const Text('日本語'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),

                  // Theme Toggle
                  PopupMenuItem<String>(
                    value: 'theme',
                    child: Row(
                      children: [
                        Icon(
                          Icons.brightness_6_rounded,
                          size: 20,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('Dark Mode')),
                        Switch(
                          value: false, // TODO: Connect to theme provider
                          onChanged: (value) {},
                          activeColor: AppColors.primaryTeal,
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),

                  // Logout
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 20,
                          color: Colors.red.shade700,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.get('logout'),
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (String value) {
                  if (value == 'lang_en') {
                    MyApp.of(context)?.setLocale(const Locale('en'));
                  } else if (value == 'lang_ja') {
                    MyApp.of(context)?.setLocale(const Locale('ja'));
                  } else if (value == 'logout') {
                    // Handle logout
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(
    IconData icon,
    bool isTransparent, {
    bool showBadge = false,
    VoidCallback? onTap,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isTransparent
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: isTransparent
                    ? Border.all(color: Colors.white.withOpacity(0.3), width: 1)
                    : null,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isTransparent ? Colors.white : AppColors.textDark,
              ),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
