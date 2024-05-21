class Users {
  String? id;
  String? userName;
  String? email;
  String? password;

  Users({
    this.id,
    this.userName,
    this.email,
    this.password
  });

  Map<String,dynamic> toFirestore() {
    return {
      "id" : id,
      "name" : userName,
      "email" : email,
      "password" : password
    };

  }

  factory Users.fromFirestore(Map<String,dynamic> json) {
    return Users(
      id: json["id"],
      userName : json["name"],
      email : json ["email"],
      password : json["password"]

    );
  }
}