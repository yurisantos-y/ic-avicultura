// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? aviaryName;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.aviaryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'aviaryName': aviaryName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      aviaryName: map['aviaryName'] != null ? map['aviaryName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? aviaryName,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      aviaryName: aviaryName ?? this.aviaryName,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.aviaryName == aviaryName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ 
           email.hashCode ^ 
           password.hashCode ^
           name.hashCode ^
           aviaryName.hashCode;
  }
}