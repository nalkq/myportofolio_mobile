import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

class ExperienceDetailScreen extends StatefulWidget {
  const ExperienceDetailScreen({super.key, required this.experienceId});

  final int experienceId;

  @override
  State<ExperienceDetailScreen> createState() => _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState extends State<ExperienceDetailScreen> {
  late final Future<Experience> _experienceFuture;

  @override
  void initState() {
    super.initState();
    _experienceFuture = context.read<ApiClient>().getExperience(
      widget.experienceId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Experience')),
      body: FutureBuilder<Experience>(
        future: _experienceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat detail Experience.'));
          }

          final item = snapshot.requireData;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('ID: ${item.id}'),
              Text('Perusahaan/Organisasi: ${item.company}'),
              Text('Periode: ${item.dateRange}'),
              Text('Status aktif: ${item.isActive ? 'Ya' : 'Tidak'}'),
              const SizedBox(height: 16),
              Text(item.description),
              const SizedBox(height: 16),
              Text('Jumlah bintang: ${item.starCount}'),
              Text('Dibintangi oleh saya: ${item.isStarred ? 'Ya' : 'Tidak'}'),
              Text(
                'Pemberi bintang: '
                '${item.starredByNames.isEmpty ? '—' : item.starredByNames}',
              ),
            ],
          );
        },
      ),
    );
  }
}
