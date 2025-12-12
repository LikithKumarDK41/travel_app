class Shortcut {
  final String id;
  final String title;
  final String imageUrl;
  final String? link;
  final int priority;

  Shortcut({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.link,
    this.priority = 0,
  });

  factory Shortcut.fromJson(Map<String, dynamic> json) {
    String extractImage(Map<String, dynamic> json) {
      if (json['icon'] != null && json['icon']['secure_url'] != null) {
        return json['icon']['secure_url'];
      }
      if (json['image'] != null && json['image']['secure_url'] != null) {
        return json['image']['secure_url'];
      }
      return "";
    }

    return Shortcut(
      id: json['_id'] ?? "",
      title: json['title'] ?? json['name'] ?? "Shortcut",
      imageUrl: extractImage(json),
      link: json['link'] as String?,
      priority: json['priority'] is int ? json['priority'] : 0,
    );
  }
}
