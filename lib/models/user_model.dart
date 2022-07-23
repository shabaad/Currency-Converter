import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.result,
    this.id,
    this.createdAt,
  });

  String? name;
  String? email;
  String? result;
  String? id;
  DateTime? createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        result: json["result"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "result": result,
        "id": id,
        "createdAt": createdAt!.toIso8601String(),
      };
}
