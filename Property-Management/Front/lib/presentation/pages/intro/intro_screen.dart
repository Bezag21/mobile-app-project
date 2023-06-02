import '../../../application/auth/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/brand_name.dart';

import '../../core/widgets/custom_button.dart';
import 'intro_text.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
     

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    const BrandName(),
                    const SizedBox(
                      height: 20,
                    ),
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                       
                        const SizedBox(
                          height: 10,
                        ),
                        Text(IntroText().introDetails),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          key: Key("button"),
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(BoardingComplete());
                          },
                          child: const CustomButton(
                            
                            title: "Get Started",
                            icon: Icons.arrow_forward_outlined,
                            iconVisiblity: true,
                          ),

                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 90,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
