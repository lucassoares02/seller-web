import 'package:profair/src/state/state_app.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/users/user_model.dart';
import 'package:profair/src/views/users/user_repository.dart';

class UserController extends ValueNotifier<StateApp> {
  List<UserModel> users = [];
  List<UserModel> usersBackup = [];
  List<UserModel> usersProvider = [];
  List<UserModel> usersProviderBackup = [];
  List<UserModel> usersAssociate = [];
  List<UserModel> usersAssociateBackup = [];

  final stateUsers = ValueNotifier<StateApp>(StateApp.start);
  final stateUsersProvider = ValueNotifier<StateApp>(StateApp.start);
  final stateUsersAssociate = ValueNotifier<StateApp>(StateApp.start);

  final UserRepository userRepository;

  UserController(super.value, this.userRepository);

  Future findUsers() async {
    stateUsers.value = StateApp.loading;
    try {
      users = await userRepository.getUsers();
      usersBackup = users;
      stateUsers.value = StateApp.success;
    } catch (e) {
      stateUsers.value = StateApp.error;
    }
  }

  Future findUsersProvider() async {
    stateUsersProvider.value = StateApp.loading;
    try {
      usersProvider = await userRepository.getUsersProvider();
      usersProviderBackup = usersProvider;
      stateUsersProvider.value = StateApp.success;
    } catch (e) {
      stateUsersProvider.value = StateApp.error;
    }
  }

  Future findUsersAssociate() async {
    stateUsersAssociate.value = StateApp.loading;
    try {
      usersAssociate = await userRepository.getUsersAssociate();
      usersAssociateBackup = usersAssociate;
      stateUsersAssociate.value = StateApp.success;
    } catch (e) {
      stateUsersAssociate.value = StateApp.error;
    }
  }

  search(String? value) async {
    stateUsers.value = StateApp.loading;
    try {
      if (value! == "") {
        users = usersBackup;
      }
      users = usersBackup.where((item) {
        return item.nameUser!.toLowerCase().contains(value.toLowerCase());
      }).toList();

      stateUsers.value = StateApp.success;
    } catch (e) {
      print("Error search Requests Stores: $e");
      stateUsers.value = StateApp.error;
    }
  }

  searchProviders(String? value) async {
    stateUsersProvider.value = StateApp.loading;
    try {
      if (value! == "") {
        usersProvider = usersProviderBackup;
      }
      usersProvider = usersProviderBackup.where((item) {
        return item.nameUser!.toLowerCase().contains(value.toLowerCase());
      }).toList();

      stateUsersProvider.value = StateApp.success;
    } catch (e) {
      print("Error search Requests Stores: $e");
      stateUsersProvider.value = StateApp.error;
    }
  }

  searchClients(String? value) async {
    stateUsersAssociate.value = StateApp.loading;
    try {
      if (value! == "") {
        usersAssociate = usersAssociateBackup;
      }
      usersAssociate = usersAssociateBackup.where((item) {
        return item.nameUser!.toLowerCase().contains(value.toLowerCase());
      }).toList();

      stateUsersAssociate.value = StateApp.success;
    } catch (e) {
      print("Error search Requests Stores: $e");
      stateUsersAssociate.value = StateApp.error;
    }
  }
}
