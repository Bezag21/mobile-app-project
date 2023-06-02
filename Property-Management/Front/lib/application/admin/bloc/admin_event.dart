part of 'admin_bloc.dart';


abstract class AdminEvent {}
class AdminRegisterUser extends AdminEvent{
  final AddUserDomainRequest addUserDomainRequest;
  AdminRegisterUser(this.addUserDomainRequest);

}