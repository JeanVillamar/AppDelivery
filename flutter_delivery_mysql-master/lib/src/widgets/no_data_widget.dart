import 'package:flutter/material.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 132,
                height: 132,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Image.asset(
                  'assets/img/cero-items.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.ink,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cuando haya información disponible aparecerá aquí.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
