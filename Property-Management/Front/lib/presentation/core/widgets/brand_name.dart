import 'package:flutter/material.dart';
import '../theme.dart';

class BrandName extends StatelessWidget {
  const BrandName({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "LandLorder",
          style: newTheme.lightTextTheme.headline1!
              .copyWith(fontWeight: FontWeight.normal),
        ),
       
      ],
    );
  }
}
