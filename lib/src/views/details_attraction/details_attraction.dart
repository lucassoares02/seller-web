import 'package:auto_route/auto_route.dart';
import 'package:profair/src/views/details_attraction/components/details.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class DetailsAttractions extends StatefulWidget {
  const DetailsAttractions({super.key});

  @override
  State<DetailsAttractions> createState() => _DetailsAttractionsState();
}

class _DetailsAttractionsState extends State<DetailsAttractions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: colorSecondary),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: ComponentDetails(),
          ),
        ),
      ),
    );
  }
}
