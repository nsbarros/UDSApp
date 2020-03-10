class User{
  final String id;
  final String name;
  final String email;
  final String password;

  User(this.id, this.name, this.email, this.password);

  User.fromMap(Map snapshot,String id) :
        id = snapshot['id'],
        name = snapshot['name'] ?? '',
        email = snapshot['email'] ?? '',
        password = snapshot['password'] ?? '';

  toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
    };
  }

  toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;
    map['email'] = this.email;
    map['password'] = this.password;
    return map;
  }

}