import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/tour_repository.dart';
import '../../models/tour_model.dart';
import '../../models/shortcut_model.dart';
import '../../layout/header.dart';
import '../../layout/sidebar.dart';
import '../../widgets/image_placeholder.dart';
import 'tour_details_page.dart';
import '../../core/localization/app_localizations.dart';
import '../tours/all_tours_page.dart';

// Mapping Tour model to UI expectations temporarily or updating UI to use Tour model
// For now, let's adapt the UI to use the new Tour model directly.

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TourRepository _tourRepository = TourRepository();
  List<Tour> _tours = [];
  List<Shortcut> _mainShortcuts = [];
  List<Shortcut> _otherShortcuts = [];
  bool _isLoading = true;
  bool _isShortcutsLoading = true;
  String? _error;

  int _currentHeroIndex = 0;
  late PageController _heroPageController;
  // Timer is not easily importable if we don't import dart:async, but let's assume valid scope or manage without timer for now, or just use simple interaction. Actually user asked for animation.
  // Let's rely on manual swipe or basic auto scroll if we can add 'dart:async'.
  // I will add 'dart:async' import first.

  @override
  void initState() {
    super.initState();
    _heroPageController = PageController();
    _loadTours();
    _loadShortcuts();

    // Simple auto-play
    Future.delayed(const Duration(seconds: 4), _autoScrollHero);
  }

  void _autoScrollHero() {
    if (!mounted) return;
    if (_heroPageController.hasClients) {
      final nextPage = (_currentHeroIndex + 1) % 3;
      _heroPageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
    Future.delayed(const Duration(seconds: 4), _autoScrollHero);
  }

  @override
  void dispose() {
    _heroPageController.dispose();
    super.dispose();
  }

  Future<void> _loadTours() async {
    try {
      final tours = await _tourRepository.fetchTours();
      if (!mounted) return;
      setState(() {
        _tours = tours;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadShortcuts() async {
    try {
      final shortcuts = await _tourRepository.fetchShortcuts();
      shortcuts.sort((a, b) => a.priority.compareTo(b.priority));

      if (!mounted) return;
      setState(() {
        _mainShortcuts = shortcuts
            .where((s) => s.priority >= 0 && s.priority <= 3)
            .toList();
        _otherShortcuts = shortcuts
            .where((s) => s.priority >= 4 && s.priority <= 9)
            .toList();
        _isShortcutsLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isShortcutsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppSidebar(),
      body: Column(
        children: [
          const SafeArea(bottom: false, child: AppHeader(isTransparent: false)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(l10n),
                  const SizedBox(height: 40),

                  _buildDynamicShortcutSections(l10n),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      l10n.get('popular_title'),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSpotsList(context, l10n),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AllToursPage(tours: _tours),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.get('view_all'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.explore_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ), // Space after button and for bottom navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(AppLocalizations l10n) {
    final heroItems = [
      {
        "image":
            "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?q=80&w=1200",
        "title": l10n.get('hero_title_1'),
        "subtitle": l10n.get('hero_subtitle_1'),
      },
      {
        "image":
            "https://images.unsplash.com/photo-1492571350019-22de08371fd3?q=80&w=1200", // Japan street/garden
        "title": l10n.get('hero_title_2'),
        "subtitle": l10n.get('hero_subtitle_2'),
      },
      {
        "image":
            "https://images.unsplash.com/photo-1542051841857-5f90071e7989?q=80&w=1200", // Food/Sake
        "title": l10n.get('hero_title_3'),
        "subtitle": l10n.get('hero_subtitle_3'),
      },
    ];

    return Container(
      height: 520,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryTeal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: Stack(
        children: [
          // 1. Swiping Images
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(48),
              bottomRight: Radius.circular(48),
            ),
            child: PageView.builder(
              controller: _heroPageController,
              itemCount: heroItems.length,
              onPageChanged: (index) {
                setState(() {
                  _currentHeroIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  heroItems[index]["image"]!,
                  height: 520,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          // 2. Static Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(48),
                bottomRight: Radius.circular(48),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.3),
                  AppColors.primaryTeal.withOpacity(0.9),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // 3. Animated Text Content
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    l10n.get('hero_badge'),
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey<int>(_currentHeroIndex),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heroItems[_currentHeroIndex]["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          height: 1.1,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        heroItems[_currentHeroIndex]["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48), // Space for dots
              ],
            ),
          ),

          // 4. Dots Indicator
          Positioned(
            bottom: 32,
            left: 32,
            child: Row(
              children: List.generate(heroItems.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  width: _currentHeroIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentHeroIndex == index
                        ? AppColors.accentYellow
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    AppLocalizations l10n, {
    VoidCallback? onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.get('view_all'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTeal,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: AppColors.primaryTeal,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSpotsList(BuildContext context, AppLocalizations l10n) {
    if (_isLoading) {
      return SizedBox(
        height: 340,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 20),
          itemBuilder: (_, __) => _buildSkeletonCard(),
        ),
      );
    }

    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          l10n.get('loading_error'),
          style: TextStyle(color: Colors.red[300]),
        ),
      );
    }

    if (_tours.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(l10n.get('no_tours')),
      );
    }

    return SizedBox(
      height: 480, // Increased height for details button
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _tours.length > 5 ? 5 : _tours.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final tour = _tours[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TourDetailsPage(spot: tour),
                ),
              );
            },
            child: _PopularSpotCard(tour: tour, l10n: l10n),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 16, width: 100, color: Colors.grey[100]),
                const SizedBox(height: 10),
                Container(height: 20, width: 200, color: Colors.grey[100]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicShortcutSections(AppLocalizations l10n) {
    if (_isShortcutsLoading) {
      return SizedBox(
        height: 110,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primaryTeal),
        ),
      );
    }

    // Fallback if no data at all
    if (_mainShortcuts.isEmpty && _otherShortcuts.isEmpty) {
      return Column(
        children: [
          _buildSectionTitle(l10n.get('categories_title'), l10n),
          const SizedBox(height: 20),
          _buildCategoryList(l10n),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Main Categories (0-3)
        if (_mainShortcuts.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              l10n.get('categories_title'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildMainShortcutsGrid(),
        ],

        // Section 2: Other Options (4-9)
        if (_otherShortcuts.isNotEmpty) ...[
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              l10n.get('other_options'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildOtherShortcutsList(),
        ],
      ],
    );
  }

  Widget _buildMainShortcutsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _mainShortcuts.map((shortcut) {
          return Expanded(child: _buildShortcutItem(shortcut));
        }).toList(),
      ),
    );
  }

  Widget _buildOtherShortcutsList() {
    return SizedBox(
      height: 135,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: _otherShortcuts.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return _buildShortcutItem(_otherShortcuts[index]);
        },
      ),
    );
  }

  Widget _buildShortcutItem(Shortcut shortcut) {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryTeal.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: const Offset(-2, -2),
              ),
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: shortcut.imageUrl.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.network(
                    shortcut.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(), // Fallback to nothing or placeholder if really needed
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 80,
          child: Text(
            shortcut.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(AppLocalizations l10n) {
    final categories = [
      {
        "name": l10n.get('cat_shrines'),
        "icon": Icons.temple_hindu,
      }, // Closest to shrine
      {"name": l10n.get('cat_hiking'), "icon": Icons.hiking},
      {"name": l10n.get('cat_history'), "icon": Icons.history_edu},
      {"name": l10n.get('cat_food'), "icon": Icons.ramen_dining},
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey.shade50],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryTeal.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                      offset: const Offset(-2, -2),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Icon(
                  categories[index]["icon"] as IconData,
                  color: AppColors.primaryTeal,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                categories[index]["name"] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontSize: 13,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PopularSpotCard extends StatelessWidget {
  final Tour tour;
  final AppLocalizations l10n;

  const _PopularSpotCard({required this.tour, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D3142).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Hero(
                  tag: tour.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: tour.imageUrl.isEmpty
                        ? const ImagePlaceholder(height: 220, text: "No Image")
                        : Image.network(
                            tour.imageUrl,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const ImagePlaceholder(
                                height: 220,
                                text: "Image Error",
                              );
                            },
                          ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 12,
            ),
            child: SizedBox(
              height: 180, // Fixed height for consistent button positioning
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tour.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tour.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textGrey,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (tour.duration.isNotEmpty) ...[
                              const Icon(
                                Icons.access_time_rounded,
                                size: 16,
                                color: AppColors.textGrey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tour.duration,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TourDetailsPage(spot: tour),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.get('details_btn')),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
