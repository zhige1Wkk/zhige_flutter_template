class User {
  final int id;
  final String username;
  final String? avatarUrl;
  final String? name;
  final String? email;
  final String? bio;
  final String? location;

  User({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.name,
    this.email,
    this.bio,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'name': name,
      'email': email,
      'bio': bio,
      'location': location,
    };
  }
} 