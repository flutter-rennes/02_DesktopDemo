import 'dart:convert';

List<Item> itemFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Item>.from(jsonData.map((x) => Item.fromJson(x)));
}

String itemToJson(List<Item> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Item {
  int id;
  String firstName;
  String lastName;
  String email;

  Item({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  String get fullName => '$firstName $lastName';

  factory Item.fromJson(Map<String, dynamic> json) => new Item(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
      };
}
