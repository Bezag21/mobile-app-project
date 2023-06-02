class SignupUser {
  String username;
  String fullName;

  String password;

  SignupUser({
    required this.username,
    required this.fullName,
    
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "name": fullName,
        
      };
}
