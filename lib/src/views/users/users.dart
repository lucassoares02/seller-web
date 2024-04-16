import 'package:auto_route/auto_route.dart';
import 'package:profair/generated/l10n.dart';
import 'package:profair/src/views/users/components/list.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/users/user_controller.dart';
import 'package:profair/src/views/users/user_repository.dart';

@RoutePage()
class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final UserController userController = UserController(StateApp.start, UserRepository());

  @override
  void initState() {
    userController.findUsers();
    userController.findUsersProvider();
    userController.findUsersAssociate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: userController.stateUsers,
            builder: (context, value, child) {
              return ComponentList(
                state: userController.stateUsers,
                description: S.of(context).text_select_branch,
                userController: userController,
              );
            },
          ),
        ),
      ),
    );
  }
}
