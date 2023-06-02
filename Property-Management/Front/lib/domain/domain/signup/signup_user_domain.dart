// ignore_for_file: public_member_api_docs, sort_constructors_first



import '../../../domain/signup/fullname_domain.dart';
import '../../../domain/signup/password_domain.dart';
import '../../../domain/signup/username_domain.dart';

class SignupDomain {
  Username username;
  FullName fullName;
  
  Password password;
  Password confirmPassword;
  SignupDomain({
    required this.username,
    required this.fullName,
    
    required this.password,
    required this.confirmPassword,
  });
}

