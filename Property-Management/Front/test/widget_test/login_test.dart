
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:property/application/signin_form/signin_form_bloc.dart';
import 'package:property/presentation/pages/login/login.dart';

void main() {
  testWidgets('Sign in authentication', (WidgetTester tester) async {
    final addUserName = find.byKey(const ValueKey("username"));
    final addPassword = find.byKey(const ValueKey("password"));
    final form = find.byType(TextFormField);
    final signButton = find.byKey(const ValueKey("login"));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
        child: Login(),
      ),
    ));
    await tester.tap(signButton);
    await tester.pump();
    await tester.enterText(addUserName, "user");
    await tester.enterText(addPassword, "user123");
    
    expect(form, findsWidgets);
    expect(find.textContaining("user"), findsOneWidget);
    expect(find.textContaining("user123"), findsOneWidget);
  });
}
