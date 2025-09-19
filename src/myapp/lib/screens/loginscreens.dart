import 'package:flutter/material.dart';
import 'mainscreen.dart';
import 'registrationscreen.dart';
import '/models/userdata.dart';

// Экран логина (StatefulWidget, т.к. нужно хранить состояние формы)
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

// Класс состояния для LoginForm
class _LoginFormState extends State<LoginForm> {
  // Ключ для формы, позволяет вызывать валидацию и доступ к состоянию формы
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для полей ввода email и пароля
  final _emailCtrl = TextEditingController();
  final _loginCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // Флаг: скрывать/показывать пароль
  bool _obscure = true;

  @override
  void dispose() {
    // Освобождаем ресурсы контроллеров при удалении виджета
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // Метод отправки формы
  void _submit() {
    // Проверяем валидность формы
    if (_formKey.currentState!.validate()) {
      final userData = UserData(email: _emailCtrl.text, login: _loginCtrl.text);
      // Показываем SnackBar с введённым email
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email: ${_emailCtrl.text}')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(userData: userData)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold — базовый каркас экрана (AppBar, body)
    return Scaffold(
      appBar: AppBar(title: const Text('Enter')), // верхняя панель
      body: SafeArea(
        // защищает от «вырезов» и панели статуса
        child: SingleChildScrollView(
          // прокрутка, если появится клавиатура
          padding: const EdgeInsets.all(16), // отступы по краям
          child: Form(
            key: _formKey, // связываем форму с ключом
            child: Column(
              children: [
                TextFormField(
                  controller: _loginCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'login',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                // Поле для ввода email
                TextFormField(
                  controller: _emailCtrl, // контроллер для чтения текста
                  keyboardType: TextInputType.emailAddress, // тип клавиатуры
                  textInputAction:
                      TextInputAction.next, // переход к следующему полю
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),

                  // Валидатор: проверка введённых данных
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Enter email';
                    if (!v.contains('@gmail.com')) return 'Incorrect  email';
                    return null; // null = ошибок нет
                  },
                ),
                const SizedBox(height: 12),

                // Поле для ввода пароля
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscure, // скрывать или показывать текст
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),

                    // Кнопка справа для показа/скрытия пароля
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),

                  // Валидатор: проверка длины пароля
                  validator: (value) {
                    final v = value ?? '';
                    if (v.length < 6) return 'Минимум 6 символов';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Кнопка входа
                SizedBox(
                  width: double.infinity, // растянуть по ширине
                  child: ElevatedButton(
                    onPressed: _submit, // обработчик при нажатии
                    child: const Text('Enter'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Переход к экрану регистрации
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
