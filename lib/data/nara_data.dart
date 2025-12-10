
class TouristSpot {
  final String title;
  final String description;
  final String imageUrl;
  final String type; // 'Temple', 'Park', 'Food'
  final double rating;

  const TouristSpot({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.rating,
  });
}

final List<TouristSpot> naraSpots = [
  TouristSpot(
    title: "Todai-ji Temple",
    description: "Home to the Great Buddha (Daibutsu), this ancient buddhist temple is a UNESCO World Heritage site and a masterpiece of wooden architecture.",
    imageUrl: "https://images.unsplash.com/photo-1570459027562-4a916cc41139?q=80&w=600&auto=format&fit=crop",
    type: "Temple",
    rating: 4.8,
  ),
  TouristSpot(
    title: "Nara Park",
    description: "Famous for its hundreds of freely roaming Sika deer, considered messengers of the gods. A serene place to walk and feed the deer shika-senbei.",
    imageUrl: "https://images.unsplash.com/photo-1545569341-9eb8b30979d9?q=80&w=600&auto=format&fit=crop",
    type: "Park",
    rating: 4.9,
  ),
  TouristSpot(
    title: "Kasuga-taisha",
    description: "Nara's most celebrated shrine. It is famous for its hundreds of bronze and stone lanterns which are lit during special festivals.",
    imageUrl: "https://images.unsplash.com/photo-1572979858525-44280b271638?q=80&w=600&auto=format&fit=crop",
    type: "Shrine",
    rating: 4.7,
  ),
  TouristSpot(
    title: "Yoshikien Garden",
    description: "A beautiful Japanese garden featuring three distinct styles: pond garden, moss garden, and tea ceremony flower garden.",
    imageUrl: "https://images.unsplash.com/photo-1596501060936-2358fb2179d6?q=80&w=600&auto=format&fit=crop",
    type: "Garden",
    rating: 4.6,
  ),
];
