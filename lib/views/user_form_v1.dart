// lib/views/user_form_v1.dart
import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/controller/user_controller_v1.dart';
import 'package:get/get.dart';

class UserFormV1 extends StatelessWidget {
  final UserControllerV1 userController = Get.put(UserControllerV1());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Obx(() {
                    return TextFormField(
                      initialValue: userController.getUserName(),
                      onChanged: (value) {
                        userController.setName(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      value: userController.user.value.gender,
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gênero é obrigatório';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userController.saveUser();
                        _formKey.currentState!.reset();
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
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
