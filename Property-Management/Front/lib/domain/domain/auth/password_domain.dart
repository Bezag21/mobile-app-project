class Password {
  String? password;
  Password({required this.password}) {
    if (this.password!.length < 8) {
      throw Exception("Password should not below 8 character");
    }
  }
  @override
  String toString() {
    return password!;
  }
}
'By using this Password class, the code that validates the user input for the password field can be centralized and simplified. 
It also helps to ensure that the password validation is consistent throughout the application.'
