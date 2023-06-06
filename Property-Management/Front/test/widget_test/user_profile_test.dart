
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:property/application/profile/bloc/profile_bloc.dart';
import 'package:property/presentation/pages/user_profile/profile.dart';

void main() {
  testWidgets('Sign up screen widget test', (WidgetTester tester) async {
    final oldPass = find.byKey(const ValueKey("oldpassword"));
    final newPass = find.byKey(const ValueKey("newpasssword"));
    final confirmpass = find.byKey(const ValueKey("confirmpassword"));

    final button = find.byKey(const ValueKey("button"));
    final logout = find.byKey(const ValueKey("logout"));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(),
        child:  UserProfile(),
      ),
    ));
    await tester.tap(logout);
    await tester.enterText(oldPass, "Password");
    await tester.enterText(newPass, "newpassword");
    await tester.enterText(confirmpass, "newpassword");

    await tester.tap(button);
   

    expect(find.text("Password"), findsOneWidget);
    expect(find.text("newpassword"), findsWidgets);
  });
}
