
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryGreen,
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
                    border: Border.all(color: AppColors.sakuraPink, width: 2),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Akiko",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Explorer Level 3",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(Icons.dashboard_outlined, "Overview", true),
                _buildMenuItem(Icons.map_outlined, "Map & Tours", false),
                _buildMenuItem(Icons.favorite_border, "Saved Places", false),
                _buildMenuItem(Icons.calendar_today_outlined, "Itinerary", false),
                _buildMenuItem(Icons.settings_outlined, "Settings", false),
              ],
            ),
          ),

          // Logout / Footer
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                 Icon(Icons.logout, color: Colors.white.withValues(alpha: 0.6), size: 20),
                 const SizedBox(width: 12),
                 Text(
                   "Log Out",
                   style: TextStyle(
                       color: Colors.white.withValues(alpha: 0.6),
                       fontWeight: FontWeight.bold),
                 )
              ],
            ),
          )
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
          color: isActive ? AppColors.sakuraPink : Colors.white70,
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