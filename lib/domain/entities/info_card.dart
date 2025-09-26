class InfoCard {
  final String title;
  final String description;

  InfoCard({required this.title, required this.description});

  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}
