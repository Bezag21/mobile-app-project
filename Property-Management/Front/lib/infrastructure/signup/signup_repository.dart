import '../../../domain/signup/signup_user_domain.dart';
import '../../../infrastructure/signup/signup_data_provider.dart';
import '../../../infrastructure/signup/signup_model.dart';
import '../../../presentation/pages/signup/signup.dart';
import '../../../data/database_helper.dart';
class SignupRepo {
  SignupRepo();
  SignupDataProvider signupDataProvider = SignupDataProvider();

  Future<void> signup(SignupDomain signupDomain) async {
    SignupUser signupUser = SignupUser(
        username: signupDomain.username.toString(),
        fullName: signupDomain.fullName.toString(),
        
        password: signupDomain.password.toString());

    try {
      await signupDataProvider.signup(signupUser);
      await DatabaseHelper.instance.queryUser(signupUser.username);
      print("repo");
      return;
    } catch (e) {
      print(e);
      throw Exception("Unable to SignIn");
    }
  }
}
