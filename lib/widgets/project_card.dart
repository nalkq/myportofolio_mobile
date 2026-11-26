import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () async {
          if (item.name == 'Lihat Proyek') {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (_) => const ProjectListScreen(),
              ),
            );
            return;
          }

          if (item.name == 'Tambah Proyek') {
            final allowed = await ensureLoggedIn(context);
            if (!context.mounted || !allowed) return;

            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(builder: (_) => const ProjectFormPage()),
            );
            return;
          }

          if (item.name == 'Logout') {
            final auth = context.read<AuthState>();
            if (!auth.isLoggedIn) return;

            await auth.logout();
            if (!context.mounted) return;

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Kamu sudah logout.')));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
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
