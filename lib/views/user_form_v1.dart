import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller_v1.dart';
import 'package:get/get.dart';

class UserFormV1 extends StatelessWidget {
  final UserControllerV1 userController = Get.put(UserControllerV1());
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  UserFormV1({super.key});

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
                        controller: nameController,
                        onChanged: userController.setName,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          errorText: userController.nameError.value.isEmpty
                              ? null
                              : userController.nameError.value,
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
                        value: userController.user.value.gender,
                        onChanged: userController.setGender,
                        items: ['Masculino', 'Feminino', 'Outro']
                            .map((String value) {
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
                        nameController.clear();
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
                      nameController.clear();
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
