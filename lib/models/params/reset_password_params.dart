class ResetPasswordParams {
  String? phone;
  String? password;
  String? repeatPassword;
  String? oldPassword;

  ResetPasswordParams({this.phone, this.password, this.repeatPassword,this.oldPassword});

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "confirm_password": repeatPassword,
    "old_password":oldPassword
      };
}
