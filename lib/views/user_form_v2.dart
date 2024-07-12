import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller_v2.dart';
import 'package:get/get.dart';

class UserForm extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(() => TextFormField(
                        controller: userController.nameController.value,
                        onChanged: userController.setName,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          // errorText: userController.nameError.value.isEmpty
                          //     ? null
                          //     : userController.nameError.value,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 20),
                  Obx(() => DropdownButtonFormField<String>(
                        value: userController.gender.value,
                        onChanged: userController.setGender,
                        items: ['Masculino', 'Feminino', 'Outro']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Gênero',
                          // errorText: userController.genderError.value.isEmpty
                          //     ? null
                          //     : userController.genderError.value,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gênero é obrigatório';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userController.saveUser();
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      userController.clearUser();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Text('Limpar'),
                  ),
                ],
              ),
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