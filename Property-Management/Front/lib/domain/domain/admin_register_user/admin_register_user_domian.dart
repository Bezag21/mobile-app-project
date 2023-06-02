class AddUserDomainRequest {
  String username;
  String name;
  
  String password;
  String roles;

  AddUserDomainRequest({required this.username, required this.name,  required this.password, required this.roles});
  
  Map<String, dynamic> toJson() => {

        "username": username,
        "password": password,
        "name": name,
        "roles" : roles

      };
}