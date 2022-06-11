class RequestModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  double? latitude = 0;
  double? longitude = 0;

  RequestModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.latitude,
    this.longitude,
  });

  RequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
