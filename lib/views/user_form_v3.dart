import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller_v3.dart';
import 'package:get/get.dart';
import 'user_list_page.dart';

class UserFormPageV3 extends StatelessWidget {
  final UserControllerV3 userController = Get.put(UserControllerV3());
  final _formKey = GlobalKey<FormState>();

  UserFormPageV3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Get.to(UserListPage());
            },
          ),
        ],
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
                        value: userController.gender.value!.isEmpty
                            ? null
                            : userController.gender.value,
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
                      _formKey.currentState!.reset();
                      userController.clearUser();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
