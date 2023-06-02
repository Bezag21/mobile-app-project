import '../../../application/admin/bloc/admin_bloc.dart';
import '../../../application/auth/bloc/authentication_bloc.dart';

import '../../../application/profile/bloc/profile_bloc.dart';

import '../../../application/inspection/inspection_bloc.dart';
//import '../../../application/inspection/inspection_event.dart';


import '../../../application/signin_form/signin_form_bloc.dart';
import '../../../application/signup_form/bloc/signup_bloc.dart';
import '../../../presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/upload/upload_bloc.dart';

void main() async {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // final LoginRepo loginRepo;
  MyApp();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()..add(AppStarted())),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
        BlocProvider<ProfileBloc>(create: (context)=> ProfileBloc()),
        
        BlocProvider<AdminBloc>(create: (context) => AdminBloc()),
       
        BlocProvider<InspectionBLoc>(create: (context) => InspectionBLoc()),//..add(inspectionLoadAllEvent())),
        BlocProvider<UploadBLoc>(create: (context) => UploadBLoc()),
      ],
    child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) => RouterMain(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context)),
          )),
    );

  }
}
