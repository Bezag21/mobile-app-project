import '../../../domain/profile/profile_domain.dart';
import '../../../infrastructure/core/sharedPref.dart';
import '../../../infrastructure/profile/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo profileRepo = ProfileRepo();
  SharedPref sharedPref = SharedPref();
  ProfileBloc() : super(ProfileInitial()) {
    on<EditPassword>((event, emit) async {
      emit(ChangingProfile());
      try {
        await profileRepo.editPassword(event.profileDomain);
        emit(ProfileChanged());
      } catch (e) {
        emit(ProfileChangeFailed());
      }
    });
    on<Logout>(((event, emit) async {
      emit(LoggingOut());
      try {
        final token = await (sharedPref.getToken());
        await profileRepo.logout();
        await sharedPref.deleteToken();
        await sharedPref.deleteName();
        emit(LoggedOut());
      } catch (e) {
        emit(LoggoutFailed());
      }
    }));

    on<DeleteAccount>(((event, emit) async {
      emit(DeletingAccount());
      try {
        await profileRepo.deleteAccount();
        await sharedPref.deleteToken();
        await sharedPref.deleteName();
        emit(AccountDeleted());
      } catch (e) {
        emit(DeletingAccoutnFailed());
      }
    }));
  }
}
