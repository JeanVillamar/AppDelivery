import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/register/register_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController con = Get.put(RegisterController());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      _header(context, isWide),
                      Transform.translate(
                        offset: const Offset(0, -48),
                        child: _boxForm(context, isWide),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          _buttonBack(),
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, top: 6),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _header(BuildContext context, bool isWide) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, isWide ? 54 : 38, 24, 78),
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
          _imageUser(context),
          const SizedBox(height: 16),
          const Text(
            'Crea tu cuenta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tus datos quedan listos para pedir más rápido.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context, bool isWide) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWide ? 520 : 390),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Información personal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                _textFieldEmail(),
                const SizedBox(height: 12),
                _textFieldName(),
                const SizedBox(height: 12),
                _textFieldLastName(),
                const SizedBox(height: 12),
                _textFieldPhone(),
                const SizedBox(height: 12),
                _textFieldPassword(),
                const SizedBox(height: 12),
                _textFieldConfirmPassword(),
                const SizedBox(height: 22),
                _buttonRegister(context),
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
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  Widget _textFieldName() {
    return TextField(
      controller: con.nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        prefixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  Widget _textFieldLastName() {
    return TextField(
      controller: con.lastnameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Apellido',
        prefixIcon: Icon(Icons.badge_outlined),
      ),
    );
  }

  Widget _textFieldPhone() {
    return TextField(
      controller: con.phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Teléfono',
        prefixIcon: Icon(Icons.phone_outlined),
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
        prefixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return TextField(
      controller: con.confirmPasswordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirmar contraseña',
        prefixIcon: Icon(Icons.lock_reset),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return ElevatedButton(
      onPressed: () => con.register(context),
      child: const Text('Crear cuenta'),
    );
  }

  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context),
      child: GetBuilder<RegisterController>(
        builder: (value) => Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: con.imageFile != null
                  ? FileImage(con.imageFile!)
                  : const AssetImage('assets/img/user_profile.png')
                      as ImageProvider,
              radius: 58,
              backgroundColor: Colors.white,
            ),
            Positioned(
              right: -2,
              bottom: 0,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
