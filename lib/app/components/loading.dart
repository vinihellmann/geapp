import 'package:geapp/app/components/layout.dart';
import 'package:geapp/themes/color.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: const Text(""),
      body: Center(
        child: CircularProgressIndicator(
          color: TColor.primary.light,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
