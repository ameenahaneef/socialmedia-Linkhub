class UserModel {
  String name;
  String userName;
  String emailid;
  String password;
  String confirmPassword;

  UserModel(
      {required this.name,
      required this.userName,
      required this.emailid,
      required this.password,
      required this.confirmPassword});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        userName: json['username'],
        emailid: json['email'],
        password: json['password'],
        confirmPassword: json['confirmpassword']);
  }
}
