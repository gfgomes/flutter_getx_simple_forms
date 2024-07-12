import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller.dart';
import 'package:get/get.dart';

class UserForm extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();

  UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => TextField(
                  controller: nameController,
                  onChanged: userController.setName,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    errorText: userController.nameError.value.isEmpty
                        ? null
                        : userController.nameError.value,
                  ),
                )),
            const SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
                  value: userController.user.value.gender,
                  onChanged: userController.setGender,
                  items: ['Masculino', 'Feminino', 'Outro'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Gênero',
                    errorText: userController.genderError.value.isEmpty
                        ? null
                        : userController.genderError.value,
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (userController.saveUser()) {
                  nameController.clear();
                  nameController.text = '';
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userController.clearUser();
                nameController.clear();
                nameController.text = '';
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text('Limpar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: userController.userList.length,
                    itemBuilder: (context, index) {
                      final user = userController.userList[index];
                      return ListTile(
                        title: Text(user.name ?? ''),
                        subtitle: Text(user.gender ?? ''),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
