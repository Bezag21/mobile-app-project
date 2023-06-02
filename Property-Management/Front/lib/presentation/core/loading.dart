
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Center(child: CircularProgressIndicator())],
          )
        ],
      ),
    );
  }
}
