import '../../../domain/signup/confirm_password_validator.dart';

import '../../../domain/signup/fullname_domain.dart';
import '../../../domain/signup/password_domain.dart';
import '../../../domain/signup/username_domain.dart';

class SignupValidator {
  String? usernameValidater(String? value) {
    try {
      Username(username: value);
      return null;
    } catch (e) {
      return e.toString().substring(10);
    }
  }

  String? passwordValidater(String? value) {
    try {
      Password(password: value);
      return null;
    } catch (e) {
      return e.toString().substring(10);
    }
  }

  String? fullNameValidater(String? value) {
    try {
      FullName(fullName: value);
      return null;
    } catch (e) {
      return e.toString().substring(10);
    }
  }


  String? confrimPasswordValidator(String? value, String password) {
    try {
      ConfirmPassword(confirmPassword: value, password: password);
      return null;
    } catch (e) {
      return e.toString().substring(10);
    }
  }
}
'Each validation method uses a try-catch block to create an instance of a domain class that represents the corresponding input field, such as Username, Password, FullName, or ConfirmPassword. 
If an exception is thrown during the creation of the domain object, the catch block returns the error message as a string.'
