import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/Rol.dart';
import 'package:udemy_flutter_delivery/src/pages/roles/roles_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class RolesPage extends StatelessWidget {
  final RolesController con = Get.put(RolesController());

  RolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = con.user.roles ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige tu perfil'),
      ),
      body: roles.isEmpty
          ? const NoDataWidget(text: 'No hay roles disponibles')
          : LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth >= 900
                    ? 3
                    : constraints.maxWidth >= 560
                        ? 2
                        : 1;

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisExtent: 190,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: roles.length,
                  itemBuilder: (context, index) =>
                      _cardRol(context, roles[index]),
                );
              },
            ),
    );
  }

  Widget _cardRol(BuildContext context, Rol rol) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => con.goToPageRol(rol),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 92,
                width: 92,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: FadeInImage(
                  image: rol.image != null
                      ? NetworkImage(rol.image!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider,
                  fit: BoxFit.contain,
                  fadeInDuration: const Duration(milliseconds: 120),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                rol.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              const Text(
                'Entrar',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
