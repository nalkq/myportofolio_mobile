import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class ExperienceCard extends StatelessWidget {
  final ItemHomepage item;

  const ExperienceCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (item.name == 'Lihat Experience') {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (_) => const ExperienceListScreen(),
              ),
            );
            return;
          }

          final allowed = await ensureLoggedIn(context);
          if (!context.mounted || !allowed) return;

          Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(builder: (_) => const ExperienceFormPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
