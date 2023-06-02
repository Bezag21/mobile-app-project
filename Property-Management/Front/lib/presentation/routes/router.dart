//import 'package:property/application/signup_form/bloc/signup_bloc.dart';
//import 'package:property/domain/inspection/inspection_Domain.dart';

import '../../../application/auth/bloc/authentication_bloc.dart';
import '../../../infrastructure/core/sharedPref.dart';
import '../../../presentation/pages/admin/adminscreen.dart';

import '../../../presentation/pages/admin/admin.dart';
import '../../../presentation/pages/intro/intro_screen.dart';
import '../../../presentation/pages/login/login.dart';
import '../../../presentation/pages/splash/splash_screen.dart';

import '../../../presentation/routes/path.dart';

import '../pages/admin/add_inspection.dart';
//import '../pages/admin/inspection_detail.dart';
import '../pages/admin/list_of_inspections.dart';
import '../pages/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/user_profile/profile.dart';

class RouterMain extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;
  SharedPref pref = SharedPref();
  late final GoRouter _router;
  static const String title = 'router';
  String? redirector(state) {
    print("*********************");
    print(state.location);
    print(authenticationBloc.state);

    if (authenticationBloc.state is FirstUse &&
        state.location == Screen().splashScreen &&
        state.location != Screen().intro) {
      return Screen().intro;
    } else if (authenticationBloc.state is BoardingCompleted &&
        state.location != Screen().login &&
        state.location != Screen().signup ) {
      return Screen().login;
    } else if (authenticationBloc.state is AuthenticationInitial &&
        state.location != Screen().splashScreen &&
        state.location != Screen().login &&
        state.location != Screen().mainscreen 
       ) {
      return Screen().splashScreen;
    } else if (authenticationBloc.state is AuthenticationNotAuthenticated &&
        state.location != Screen().signup &&
        state.location != Screen().login) {
      return Screen().login;
    } else if (authenticationBloc.state is AuthenticationAuthenticatedadmin &&
        state.location != Screen().adminScreen) {
      return Screen().adminScreen;
    } 
     else if (authenticationBloc.state is AuthenticationAuthenticatedadmin &&
        state.location != Screen().adminScreen) {
      return Screen().addInspection;
    }
    else if (authenticationBloc.state is AuthenticationAuthenticatedadmin &&
        state.location != Screen().adminScreen ){
      return Screen().ListofInspection;
    }
    else if (authenticationBloc.state is AuthenticationAuthenticatedadmin &&
        state.location != Screen().ListofInspection && state.location != Screen().adminScreen){
      return Screen().inspectionDetail;
    }
    return null;
  }

  RouterMain({Key? key, required this.authenticationBloc}) : super(key: key) {
    _router = GoRouter(
      refreshListenable: GoRouterRefreshStream(authenticationBloc.stream),
      redirect: (state) => redirector(state),
      initialLocation: Screen().splashScreen,
      routes: <GoRoute>[
        
        GoRoute(
          path: Screen().profile,
          builder: (BuildContext context, GoRouterState state) =>
              const UserProfile(),
        ),
        GoRoute(
          path: Screen().admin,
          builder: (BuildContext context, GoRouterState state) =>
              const AdminAdd(),
        ),
        GoRoute(
          path: Screen().adminScreen,
          builder: (BuildContext context, GoRouterState state) =>
              const AdminScreen(),
        ),
       
        GoRoute(
          path: Screen().intro,
          builder: (BuildContext context, GoRouterState state) =>
              const IntroScreen(),
        ),
       GoRoute(
          path: Screen().addInspection,
          builder: (BuildContext context, GoRouterState state) =>
               AddInspection(context),
        ),
        GoRoute(
          path: Screen().login,
          builder: (BuildContext context, GoRouterState state) => Login(),
        ),
       
      //  GoRoute(
      //     path: '${Screen().inspectionDetail}',
      //     builder: (BuildContext context, GoRouterState state) {
      //       final inspectionId = int.parse(state.params["id"]!);
      //       return InspectionDetail( inspectionId:inspectionId);
      //     },
      //   ),
       
        GoRoute(
          path: Screen().signup,
          builder: (BuildContext context, GoRouterState state) =>
              const Signup(),
        ),
        
        GoRoute(
          path: Screen().intro,
          builder: (BuildContext context, GoRouterState state) =>
              const IntroScreen(),
        ),
         GoRoute(
          path: Screen().inspection,
          builder: (BuildContext context, GoRouterState state) =>
              const ListOfInspection(),
        ),
        GoRoute(
          path: Screen().splashScreen,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
      );
}
