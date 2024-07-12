class User {
  String? name;
  String? gender;

  User({required this.name, required this.gender});

  factory User.empty() => User(name: null, gender: null);
}
