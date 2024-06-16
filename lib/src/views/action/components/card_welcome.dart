import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:flutter/material.dart';

class CardWelcome extends StatefulWidget {
  CardWelcome({super.key});

  @override
  State<CardWelcome> createState() => _CardWelcomeState();
}

class _CardWelcomeState extends State<CardWelcome> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool valor = false;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('profile');
      },
      child: Container(
        margin: const EdgeInsets.only(top: appPadding),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(appRadius),
        ),
        padding: const EdgeInsets.all(appPadding),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seu banco digital!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Seja bem vindo!',
                      style: TextStyle(fontSize: 16, color: colorGreyDark),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
