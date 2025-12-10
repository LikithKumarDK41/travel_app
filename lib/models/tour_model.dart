class Tour {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final bool isFeatured;

  Tour({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.duration = "",
    this.isFeatured = false,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    String extractImage(Map<String, dynamic> json) {
      if (json['image'] != null && json['image']['secure_url'] != null) {
        return json['image']['secure_url'];
      }
      return ""; // No fallback image
    }

    String extractDesc(Map<String, dynamic> json) {
      if (json['content'] != null && json['content']['brief'] != null) {
        // Simple HTML tag cleaner if needed, or use as is
        return json['content']['brief'].toString().replaceAll(
          RegExp(r'<[^>]*>'),
          '',
        );
      }
      return "";
    }

    return Tour(
      id: json['_id'] ?? "",
      title: json['title'] ?? "Unknown Tour",
      description: extractDesc(json),
      imageUrl: extractImage(json),
      duration: json['duration'] ?? "",
      isFeatured: json['featured'] ?? false,
    );
  }
}
