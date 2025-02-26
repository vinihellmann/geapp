import 'dart:convert';

class LoginModel {
  String user;
  String password;

  LoginModel({required this.user, required this.password});

  LoginModel copyWith({String? user, String? password}) {
    return LoginModel(
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user': user, 'password': password};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      user: map['user'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginModel(user: $user, password: $password)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.password == password;
  }

  @override
  int get hashCode => user.hashCode ^ password.hashCode;
}
