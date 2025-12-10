import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final bool isTransparent;

  const AppHeader({super.key, this.onMenuPressed, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 70, // Slightly taller for premium feel
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isTransparent ? Colors.transparent : Colors.white,
        boxShadow: isTransparent
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          // Custom Menu Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (onMenuPressed != null) {
                  onMenuPressed!();
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isTransparent
                        ? Colors.white70
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: isTransparent
                      ? Colors.black.withValues(alpha: 0.1)
                      : Colors.white,
                ),
                child: Icon(
                  Icons.menu_rounded,
                  color: isTransparent ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          ),

          const Spacer(),

          // Title (Optional, maybe just showing it in non-transparent mode)
          if (!isTransparent)
            Text(
              l10n.get('splash_title'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isTransparent ? Colors.white : AppColors.textDark,
              ),
            ),

          const Spacer(),

          // Right Icons (Mail, Bell)
          Row(
            children: [
              _buildHeaderIcon(Icons.mail_outline_rounded, isTransparent),
              const SizedBox(width: 12),
              _buildHeaderIcon(Icons.notifications_none_rounded, isTransparent),
              const SizedBox(width: 12),
              // User Profile Avatar
              Container(
                width: 40,
                height: 40,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, bool isTransparent) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isTransparent
            ? Colors.black.withValues(alpha: 0.1)
            : Colors.grey.shade100,
      ),
      child: Icon(
        icon,
        size: 20,
        color: isTransparent ? Colors.white : AppColors.textDark,
      ),
    );
  }
}
