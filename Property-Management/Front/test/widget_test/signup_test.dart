
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:property/application/signup_form/bloc/signup_bloc.dart';
import 'package:property/presentation/pages/signup/signup.dart';

void main() {
  testWidgets('Sign up screen widget test', (WidgetTester tester) async {
    final addFullName = find.byKey(const ValueKey("fullname"));
    final createUsername = find.byKey(const ValueKey("username"));
    final createPassword = find.byKey(const ValueKey("password"));
    final confirmPassword = find.byKey(const ValueKey("confirmpassword"));
    final signupButton = find.byKey(const ValueKey("signup"));
    final signButton = find.byKey(const ValueKey("login"));

  
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: Signup(),
      ),
    ));
    await tester.enterText(addFullName, "Alex Kebede");
    await tester.enterText(createUsername, "alex123");
    await tester.enterText(createPassword, "alexkebede");
    await tester.enterText(confirmPassword, "alexkebede");
    await tester.tap(signupButton);
    await tester.tap(signButton);

    expect(find.text("Alex Kebede"), findsOneWidget);
    expect(find.text("alex@123"), findsOneWidget);
    expect(find.text("alexkebede"), findsWidgets);
  });
}
