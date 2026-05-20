import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class ClientProfileInfoPage extends StatelessWidget {
  final ClientProfileInfoController con =
      Get.put(ClientProfileInfoController());

  ClientProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final user = con.user.value;

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      _header(context, isWide, user),
                      Transform.translate(
                        offset: const Offset(0, -46),
                        child: _profileCard(context, isWide, user),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, bool isWide, User user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(22, isWide ? 42 : 30, 22, 78),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.ink, Color(0xFF263648)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _headerAction(
                  icon: Icons.supervised_user_circle_outlined,
                  onPressed: () => con.goToRoles(),
                ),
                const SizedBox(width: 8),
                _headerAction(
                  icon: Icons.power_settings_new,
                  onPressed: () => con.signOut(),
                ),
              ],
            ),
            const SizedBox(height: 6),
            CircleAvatar(
              backgroundImage: user.image != null
                  ? NetworkImage(user.image!)
                  : const AssetImage('assets/img/user_profile.png')
                      as ImageProvider,
              radius: 58,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              '${user.name ?? ''} ${user.lastname ?? ''}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.email ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerAction({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.14),
        foregroundColor: Colors.white,
      ),
      icon: Icon(icon),
    );
  }

  Widget _profileCard(BuildContext context, bool isWide, User user) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWide ? 520 : 390),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              children: [
                _infoTile(Icons.person_outline, 'Nombre del usuario',
                    '${user.name ?? ''} ${user.lastname ?? ''}'),
                _infoTile(Icons.email_outlined, 'Email', user.email ?? ''),
                _infoTile(Icons.phone_outlined, 'Teléfono', user.phone ?? ''),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => con.goToProfileUpdate(),
                    child: const Text('Actualizar datos'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(label),
    );
  }
}
