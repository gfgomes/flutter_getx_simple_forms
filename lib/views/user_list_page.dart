import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller_v3.dart';
import 'package:get/get.dart';

class UserListPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ListView.builder(
              itemCount: userController.userList.length,
              itemBuilder: (context, index) {
                final user = userController.userList[index];
                return ListTile(
                  title: Text(user.name ?? ''),
                  subtitle: Text(user.gender ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      userController.deleteUser(index);
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}
