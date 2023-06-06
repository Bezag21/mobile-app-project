
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:property/application/signup_form/bloc/signup_bloc.dart';
import 'package:property/presentation/pages/admin/admin.dart';

void main() {
  testWidgets('Sign up screen widget test', (WidgetTester tester) async {
    final addFullName = find.byKey(const ValueKey("fullname"));
    final createUsername = find.byKey(const ValueKey("username"));
    final createPassword = find.byKey(const ValueKey("password"));
    final confirmPassword = find.byKey(const ValueKey("confirmpassword"));
    final Button = find.byKey(const ValueKey("button"));
    final dropdown = find.byKey(const ValueKey("drop"));
    
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: AdminAdd(),
      ),
    ));
    await tester.enterText(addFullName, "Admin");
    await tester.enterText(createUsername, "admin123");
    await tester.enterText(createPassword, "adminadmin");
    await tester.enterText(confirmPassword, "adminadmin");
    await tester.tap(Button);

    expect(find.text("Admin"), findsOneWidget);
    expect(dropdown,findsOneWidget);
    expect(find.text("admin123"), findsOneWidget);
    expect(find.text("adminadmin"), findsWidgets);
  });
}
