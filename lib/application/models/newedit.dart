class Profilee {
  final String name;
  final String username;
  final String bio;
  final String links;
  Profilee(
      {required this.name,
      required this.username,
      this.bio = '',
      this.links = ''});

  factory Profilee.fromJson(Map<String, dynamic> json) {
    return Profilee(
        name: json['name'],
        username: json['username'],
        bio: json['bio'],
        links: json['links']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'username': username, 'bio': bio, 'links': links};
  }

  Profilee copyWith({
    String? name,
    String? username,
    String? bio,
    String? links,
  }) {
    return Profilee(
        name: name ?? this.name,
        username: username ?? this.username,
        bio: bio ?? this.bio,
        links: links ?? this.links);
  }
}
