import '../../../application/signup_form/bloc/signup_bloc.dart';
import '../../../domain/signup/confirm_password_validator.dart';

import '../../../domain/signup/fullname_domain.dart';
import '../../../domain/signup/password_domain.dart';
import '../../../domain/signup/signup_user_domain.dart';
import '../../../domain/signup/signup_validator.dart';
import '../../../domain/signup/username_domain.dart';
import '../../../presentation/routes/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

import '../../core/widgets/brand_name.dart';

import '../../core/widgets/custom_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late bool _passwordVisible;
  late bool _passwordConfirmVisible;

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  
  late String formattedDate;
  @override
  void initState() {
    _passwordVisible = true;
    _passwordConfirmVisible = true;
   
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
   
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 60, 15, 5),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Signup",
                      style: newTheme.lightTextTheme.headline2,
                    ),
                    Text(
                      "Welcome",
                      style: newTheme.lightTextTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    BrandName(),
                    // Form(child: child)
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  TextFormField(
                                      key: Key("fullname"),
                                      controller: fullNameController,
                                      decoration: const InputDecoration(
                                        labelText: "Enter full name",
                                      ),
                                      validator: (value) => SignupValidator()
                                          .fullNameValidater(value)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  
                                  

                                  // const SizedBox(height: 25),
                                  TextFormField(
                                    key: Key("username"),
                                    controller: usernameController,
                                    decoration: const InputDecoration(
                                      labelText: "Create username",
                                    ),
                                    validator: (value) => SignupValidator()
                                        .usernameValidater(value),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    key: Key("password"),
                                    obscureText: _passwordVisible,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(_passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      // suffixIcon: Icon(Icons.scuba_diving),
                                      labelText: "Enter password",
                                    ),
                                    validator: (value) => SignupValidator()
                                        .passwordValidater(value),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    key: Key("confirmpassword"),
                                    controller: passwordConfirmController,
                                    obscureText: _passwordConfirmVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordConfirmVisible =
                                                !_passwordConfirmVisible;
                                          });
                                        },
                                        icon: Icon(_passwordConfirmVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      // suffixIcon: Icon(Icons.scuba_diving),
                                      labelText: "confirm password",
                                    ),
                                    validator: (value) => SignupValidator()
                                        .confrimPasswordValidator(
                                            value, passwordController.text),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            BlocConsumer<SignupBloc, SignupState>(
                                listener: (context, state) {
                              if (state is SignupSuccessful) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(108, 60, 120, 158),
                                      content: Text('Signup Successful')),
                                );
                                context.go(Screen().login);
                              } else if (state is SignupLoading) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              } else if (state is SignupFailed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Signup Failed Try again')),
                                );
                              }
                            }, builder: (context, state) {
                              return TextButton(
                                key:Key("signup"),
                                  onPressed: () {
                                    
                                    if (_formKey.currentState!.validate()) {
                                      final blocProv =
                                          BlocProvider.of<SignupBloc>(context);
                                      final SignupDomain signupDomain =
                                          SignupDomain(
                                              username: Username(
                                                  username:
                                                      usernameController.text),
                                              fullName: FullName(
                                                  fullName:
                                                      fullNameController.text),
                                              
                                              password: Password(
                                                  password:
                                                      passwordController.text),
                                              confirmPassword: Password(
                                                  password:
                                                      passwordConfirmController
                                                          .text));
                                      blocProv.add(SignUpEvent(signupDomain));
                                    }
                                  },
                                  child: CustomButton(title: "Sign up"));
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Have an account? "),
                                TextButton(
                                  key: Key("login"),
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () {
                                      context.go(Screen().login);
                                    },
                                    child: Text("Login")),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
