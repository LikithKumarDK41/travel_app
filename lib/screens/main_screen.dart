import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/tour_model.dart';
import '../services/tour_repository.dart';
import '../core/localization/app_localizations.dart';
import '../layout/sidebar.dart';
import 'landing/landing_page.dart';
import 'tours/all_tours_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // Home is center
  final TourRepository _tourRepository = TourRepository();
  List<Tour> _allTours = [];
  bool _isLoadingTours = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final tours = await _tourRepository.fetchTours();
      if (mounted) {
        setState(() {
          _allTours = tours;
          _isLoadingTours = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingTours = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final pages = [
      _buildPageWithPadding(
        Center(
          child: Text(
            l10n.get('menu_info'),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      _isLoadingTours
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryTeal),
            )
          : AllToursPage(tours: _allTours),
      const LandingPage(),
      _buildPageWithPadding(
        Center(
          child: Text(
            l10n.get('menu_bookmarks'),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      _buildPageWithPadding(
        Center(
          child: Text(
            l10n.get('menu_settings'),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: const AppSidebar(),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: pages),

          // Floating Menu Button - Attached to left edge, vertically centered
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height / 2 - 28,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryTeal.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryTeal,
              AppColors.primaryTeal.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryTeal.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _currentIndex = 2),
            customBorder: const CircleBorder(),
            child: const Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 0,
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.info_outline_rounded,
                activeIcon: Icons.info_rounded,
                label: l10n.get('menu_info'),
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.list_alt_rounded,
                activeIcon: Icons.list_alt_rounded,
                label: l10n.get('menu_tour_list'),
              ),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(
                index: 3,
                icon: Icons.bookmark_border_rounded,
                activeIcon: Icons.bookmark_rounded,
                label: l10n.get('menu_bookmarks'),
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings_rounded,
                label: l10n.get('menu_settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageWithPadding(Widget child) {
    return Padding(padding: const EdgeInsets.only(bottom: 80), child: child);
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryTeal.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? AppColors.primaryTeal
                    : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                color: isSelected
                    ? AppColors.primaryTeal
                    : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
