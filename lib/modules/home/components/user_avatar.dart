import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        CircleAvatar(
          backgroundColor: TColor.text.primary,
          radius: 20,
          child: Text(
            "Usuário"[0].toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColor.primary.light,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text("Usuário".toUpperCase(), style: TText.ml)
      ],
    );
  }
}
