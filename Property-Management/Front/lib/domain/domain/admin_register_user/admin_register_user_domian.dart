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
'The purpose of this class is to simplify the process of creating a request payload for adding a new user in a specific domain. 
The toJson() method is used to convert the instance of this class into a JSON object, which can be used as the request payload for an API call.'
