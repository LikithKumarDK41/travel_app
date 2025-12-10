import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/tour_repository.dart';
import '../../models/tour_model.dart';
import '../../layout/header.dart';
import '../../layout/sidebar.dart';
import '../../layout/footer.dart';
import '../../widgets/image_placeholder.dart';
import 'tour_details_page.dart';
import '../../core/localization/app_localizations.dart';

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
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTours();
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppSidebar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroSection(l10n),
                const SizedBox(height: 40),
                _buildSectionInfo(l10n),
                const SizedBox(height: 32),
                _buildSectionTitle(l10n.get('categories_title'), l10n),
                const SizedBox(height: 20),
                _buildCategoryList(l10n),
                const SizedBox(height: 40),
                _buildSectionTitle(l10n.get('popular_title'), l10n),
                const SizedBox(height: 20),
                _buildSpotsList(context, l10n),
                const SizedBox(height: 60),
                const AppFooter(),
              ],
            ),
          ),

          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: AppHeader(isTransparent: true)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(AppLocalizations l10n) {
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
          // Background Image (Mockup for Gose)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(48),
              bottomRight: Radius.circular(48),
            ),
            child: Image.network(
              "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?q=80&w=1200", // Nature/Japan vibe
              height: 520,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
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

          // Content
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
                Text(
                  l10n.get('hero_title'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
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
                  l10n.get('hero_subtitle'),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionInfo(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryTeal.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.get('nav_title'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.get('nav_subtitle'),
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.secondaryPink.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.secondaryPink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppLocalizations l10n) {
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
          Text(
            l10n.get('view_all'),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTeal,
              fontSize: 14,
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
      height: 380,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: _tours.length,
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
                      // backdropFilter: const ColorFilter.mode(Colors.white, BlendMode.srcOver), // This is not a valid property for BoxDecoration
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l10n.get('guided_tag'),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.get('duration_label'),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryPink.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppColors.secondaryPink,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryPink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
