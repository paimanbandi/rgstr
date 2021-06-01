class Registration {
  static const String TABLE = "registrations";

  final int id;
  final String imei;
  final String firstName;
  final String lastName;
  final String dob;
  final String passport;
  final String email;
  final String picture;
  final String osName;
  final String osVersion;
  final double longitude;
  final double latitude;

  Registration(
      {this.id, this.imei, this.firstName, this.lastName, this.dob, this.passport, this.email, this.picture, this.osName, this.osVersion, this.longitude, this.latitude});
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'],
      imei: json['imei'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['dob'],
      passport: json['passport'],
      email: json['email'],
      picture: json['picture'],
      osName: json['os_name'],
      osVersion: json['os_version'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imei': imei,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'passport': passport,
      'email': email,
      'picture': picture,
      'os_name': osName,
      'os_version': osVersion,
      'longitude': longitude,
      'latitude': latitude
    };
  }
}
