import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/login/login_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  final LoginController con = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 720;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  _hero(context, isWide),
                  Transform.translate(
                    offset: const Offset(0, -46),
                    child: _boxForm(context, isWide),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: _textDontHaveAccount(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _hero(BuildContext context, bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, isWide ? 54 : 34, 24, 84),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),
      child: Column(
        children: [
          Container(
            width: isWide ? 132 : 112,
            height: isWide ? 132 : 112,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Image.asset('assets/img/delivery.png'),
          ),
          const SizedBox(height: 18),
          const Text(
            'RapiBite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Entrega rápida, comida caliente',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context, bool isWide) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWide ? 440 : 360),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bienvenido de nuevo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Ingresa tus datos para continuar.',
                  style: TextStyle(color: AppColors.muted, fontSize: 14),
                ),
                const SizedBox(height: 24),
                _textFieldEmail(),
                const SizedBox(height: 14),
                _textFieldPassword(),
                const SizedBox(height: 24),
                _buttonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return TextField(
      controller: con.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
        hintText: 'correo@ejemplo.com',
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  Widget _textFieldPassword() {
    return TextField(
      controller: con.passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        hintText: 'Ingresa tu contraseña',
        prefixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: () => con.login(),
      child: const Text('Ingresar'),
    );
  }

  Widget _textDontHaveAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 6,
        children: [
          const Text(
            '¿No tienes cuenta?',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () => con.goToRegisterPage(),
            child: const Text(
              'Regístrate aquí',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
