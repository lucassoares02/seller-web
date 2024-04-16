import 'package:profair/src/components/header_list.dart';
import 'package:profair/src/components/loading_list.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/src/views/home/state_management.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/users/components/printing.dart';
import 'package:profair/src/views/users/components/table_user.dart';
import 'package:profair/src/views/users/user_controller.dart';

class ComponentList extends StatefulWidget {
  ComponentList({
    super.key,
    this.description,
    required this.state,
    required this.userController,
  });

  final String? description;
  final ValueListenable state;
  final UserController userController;

  @override
  State<ComponentList> createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // return SizedBox(width: 400, height: 500, child: Printing("Printando"));
    return StateManagement(
      width: width,
      listenable: widget.state,
      widgetLoading: LoadingList(icon: Icons.swap_horiz_rounded, label: "Usuários"),
      component: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderList(
                onBack: false,
                label: "Organização",
                activeSearch: true,
                onSearch: (value) {
                  widget.userController.search(value);
                },
              ),
              // SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: Text(
                  "Equipe que faz parte do gerenciamento do evento",
                  style: TextStyle(fontSize: 14, color: colorGrey),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: widget.userController.stateUsers,
            builder: (context, value, child) {
              return value == StateApp.loading ? LoadingList(loadingHeader: false) : TableUser(users: widget.userController.users);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderList(
                onBack: false,
                label: "Fornecedores",
                activeSearch: true,
                onSearch: (value) {
                  widget.userController.searchProviders(value);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: Text(
                  "Equipe que faz parte dos consutores de venda",
                  style: TextStyle(fontSize: 14, color: colorGrey),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: widget.userController.stateUsersProvider,
            builder: (context, value, child) {
              return value == StateApp.loading ? LoadingList(loadingHeader: false) : TableUser(users: widget.userController.usersProvider);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderList(
                onBack: false,
                label: "Associados",
                activeSearch: true,
                onSearch: (value) {
                  widget.userController.searchClients(value);
                },
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding),
                child: Text(
                  "Usuários e clientes e suas lojas",
                  style: TextStyle(fontSize: 14, color: colorGrey),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: widget.userController.stateUsersAssociate,
            builder: (context, value, child) {
              return value == StateApp.loading ? LoadingList(loadingHeader: false) : TableUser(users: widget.userController.usersAssociate);
            },
          ),
        ],
      ),
    );
  }
}
