import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:http/http.dart' show ClientException;
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _company = '';
  String _dateRange = '';
  String _description = '';
  bool _isActive = false;
  bool _isSaving = false;

  // Validasi bersama untuk input teks.
  String? _validateText(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return '$label tidak boleh kosong atau hanya berisi spasi.';
    }

    if (maxLength != null && text.runes.length > maxLength) {
      return '$label maksimal $maxLength karakter.';
    }

    return null;
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (_isSaving || form == null || !form.validate()) return;
    form.save();

    setState(() => _isSaving = true);

    try {
      final allowed = await ensureLoggedIn(context);
      if (!mounted || !allowed) return;

      final token = context.read<AuthState>().token;
      if (token == null) return;

      final saved = await context.read<ApiClient>().createExperience(
        Experience(
          title: _title,
          company: _company,
          dateRange: _dateRange,
          description: _description,
          isActive: _isActive,
        ),
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Experience berhasil ditambahkan'),
          content: Text(saved.title),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.of(context).pop(true);
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        context.read<AuthState>().clearSession();
        await ensureLoggedIn(context);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan Experience (HTTP ${error.statusCode}).',
          ),
        ),
      );
    } on ClientException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa terhubung ke server.')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Experience'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Judul/Posisi',
                    hintText: 'Contoh: Asisten Dosen',
                    helperText: 'Maksimal 100 karakter',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    return _validateText(value, 'Judul/Posisi', maxLength: 100);
                  },
                  onSaved: (value) {
                    _title = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Perusahaan/Organisasi',
                    hintText: 'Contoh: Universitas Indonesia',
                    helperText: 'Maksimal 100 karakter',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    return _validateText(
                      value,
                      'Perusahaan/Organisasi',
                      maxLength: 100,
                    );
                  },
                  onSaved: (value) {
                    _company = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Periode',
                    hintText: 'Contoh: Agustus 2026 - Sekarang',
                    helperText: 'Maksimal 50 karakter',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return _validateText(value, 'Periode', maxLength: 50);
                  },
                  onSaved: (value) {
                    _dateRange = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Jelaskan tanggung jawab atau kegiatanmu',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 4,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    return _validateText(value, 'Deskripsi');
                  },
                  onSaved: (value) {
                    _description = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Status aktif'),
                  subtitle: const Text(
                    'Aktifkan jika pengalaman ini berstatus aktif.',
                  ),
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isSaving ? null : _submit,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
