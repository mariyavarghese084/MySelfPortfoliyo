class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final List<String> features;
  final String? highlights;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.features,
    this.highlights,
    this.githubUrl,
    this.liveUrl,
  });
}
