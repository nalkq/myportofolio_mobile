import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

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

  // Validasi bersama untuk input teks.
  String? _validateText(
    String? value,
    String label, {
    int? maxLength,
  }) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return '$label tidak boleh kosong atau hanya berisi spasi.';
    }

    if (maxLength != null && text.runes.length > maxLength) {
      return '$label maksimal $maxLength karakter.';
    }

    return null;
  }

  void _showSummary() {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    // Menjalankan onSaved pada setiap field.
    form.save();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Experience berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul/Posisi: $_title'),
                Text('Perusahaan/Organisasi: $_company'),
                Text('Periode: $_dateRange'),
                Text('Deskripsi: $_description'),
                Text(
                  'Status aktif: ${_isActive ? "Ya" : "Tidak"}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
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
                    return _validateText(
                      value,
                      'Judul/Posisi',
                      maxLength: 100,
                    );
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
                    return _validateText(
                      value,
                      'Periode',
                      maxLength: 50,
                    );
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
                  onPressed: _showSummary,
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