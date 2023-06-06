

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:property/application/auth/bloc/authentication_bloc.dart';
import 'package:property/presentation/pages/intro/intro_screen.dart';

void main() {
  testWidgets('Patient Details screen widget test',
      (WidgetTester tester) async {
    final startButton = find.byKey(const ValueKey("button"));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(),
        child: IntroScreen(),
      ),
    ));

    await tester.tap(startButton);

  });
}
