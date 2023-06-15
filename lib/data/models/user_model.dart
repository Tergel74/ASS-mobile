class Users {
  String? id;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  String? otp;
  String? newPassword;
  String? gender;
  String? pfp;
  String? houseId;
  String? role;
  String? phone;

  Users({
    this.userName,
    this.password,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.otp,
    this.newPassword,
    this.gender,
    this.pfp,
    this.houseId,
    this.role,
    this.phone,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    (json['imgUrl'] != null)
        ? pfp = json['imgUrl']
        : pfp =
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOC9SJyjR7x4e6ar9aEc6UpgmyrSfpZaGzUVu_iRpmwOQTp-GKhoy73iNQFRo28VR3GR8&usqp=CAU';
    (json['sex'] != null) ? gender = json['sex'] : gender = 'male';
    email = json['email'];
    houseId = json['houseId'];
    role = json['role'];
    phone = json['phone'];
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
    data["imgUrl"] = pfp;

    return data;
  }
}
