class Users {
  String? id;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  String? otp;
  String? newPassword;
  String? pfp;

  Users(
      {this.userName,
      this.password,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.otp,
      this.newPassword,
      this.pfp});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    (json['profilePic'] != null)
        ? pfp = json['profilePic']
        : pfp =
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOC9SJyjR7x4e6ar9aEc6UpgmyrSfpZaGzUVu_iRpmwOQTp-GKhoy73iNQFRo28VR3GR8&usqp=CAU';
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (id != null) ? data["id"] = id : null;
    (userName != null) ? data["userName"] = userName : null;
    (email != null) ? data["email"] = email : null;
    (password != null) ? data["password"] = password : null;
    (firstName != null) ? data["firstName"] = firstName : null;
    (lastName != null) ? data["lastName"] = lastName : null;
    (otp != null) ? data["otp"] = otp : null;
    (newPassword != null) ? data["newPassword"] = newPassword : null;
    data["profilePic"] = pfp;

    return data;
  }
}
