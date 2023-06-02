import '../../../domain/auth/loggedIn_domain.dart';
import '../../../domain/auth/login_user_domain.dart';
import '../../../domain/auth/role_domain.dart';
import '../../../domain/auth/token.dart';
import '../../../domain/auth/user_name_domain.dart';
import '../../../infrastructure/auth/login_model.dart';
import '../../../infrastructure/auth/login_data_provider.dart';
import '../../../infrastructure/auth/login_response_model.dart';
import '../../../data/database_helper.dart'
class LoginRepo {
  LoginRepo();
  AuthDataProvider authDataProvider = AuthDataProvider();

  Future<LoggedInDomain> login(LoginDomain loginDomain) async {
    LoginUser loginUser = LoginUser(
        username: loginDomain.username.toString(),
        password: loginDomain.password.toString());
    print(loginUser.username);
    print(loginUser.password);
    LoginResponse response = await authDataProvider.login(loginUser);
    await DatabaseHelper.instance.queryUser(loginDomain.username.toString()); 
    print(response.role);
    LoggedInDomain loggedInDomain = LoggedInDomain(
        token: Token(token: response.token),
        username: Username(username: response.name),
        role: Role(role: response.role));

    return loggedInDomain;
  }
}
