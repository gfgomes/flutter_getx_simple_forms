import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_without_form_controller.dart';
import 'package:get/get.dart';

class UserFormWithoutForm extends StatelessWidget {
  final UserWithoutFormController userController =
      Get.put(UserWithoutFormController());
  final TextEditingController nameTextEditingController =
      TextEditingController();

  UserFormWithoutForm({super.key});

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
                  controller: nameTextEditingController,
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
                userController.clearUser();
                nameTextEditingController.clear();
                nameTextEditingController.text = '';
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text('Limpar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (userController.saveUser()) {
                  nameTextEditingController.clear();
                  nameTextEditingController.text = '';
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              child: const Text('Salvar'),
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
          ],
        ),
      ),
    );
  }
}
