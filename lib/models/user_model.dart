class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  double? latitude = 0;
  double? longitude = 0;
  // String? bio = 'Bio';
  bool? isEmailVerified;

  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.latitude,
      this.longitude,
      this.isEmailVerified,
      this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
