class Experience {
  final String role;
  final String company;
  final String duration;
  final List<String> responsibilities;
  final bool isCurrent;

  const Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.responsibilities,
    this.isCurrent = false,
  });
}

class Education {
  final String degree;
  final String institution;
  final String duration;

  const Education({
    required this.degree,
    required this.institution,
    required this.duration,
  });
}
