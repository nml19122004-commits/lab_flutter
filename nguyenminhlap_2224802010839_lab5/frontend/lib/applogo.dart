import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle_outline, size: 80, color: Colors.white),
        const SizedBox(height: 10),
        'To-Do App'.text.xl2.italic.white.make(),
        'Make a list of your tasks'.text.light.white.wider.lg.make(),
      ],
    );
  }
}
