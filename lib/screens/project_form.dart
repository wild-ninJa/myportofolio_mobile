import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = "";
  String _description = "";
  String _category = "Web Development";
  String _technologies = "";
  String _projectLink = "";

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  InputDecoration _decoration(String label, {String? hint}) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withAlpha(170),
      labelStyle: const TextStyle(color: Color(0xFF0277BD)),
      border: border(Colors.white, 1.5),
      enabledBorder: border(Colors.white, 1.5),
      focusedBorder: border(const Color(0xFF0288D1), 2),
      errorBorder: border(Colors.redAccent, 1.5),
      focusedErrorBorder: border(Colors.redAccent, 2),
    );
  }

  Widget _field(Widget child) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Add Project Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color(0x66006080),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE), Color(0xFFC8E6C9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 72, 16, 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withAlpha(190),
                    Colors.white.withAlpha(90),
                  ],
                ),
                border: Border.all(color: Colors.white.withAlpha(230), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0288D1).withAlpha(50),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field(
                      TextFormField(
                        decoration: _decoration("Nama Proyek"),
                        onChanged: (v) => setState(() => _projectName = v),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? "Nama proyek tidak boleh kosong!"
                            : null,
                      ),
                    ),
                    _field(
                      TextFormField(
                        maxLines: 5,
                        decoration: _decoration("Deskripsi Proyek"),
                        onChanged: (v) => setState(() => _description = v),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? "Deskripsi proyek tidak boleh kosong!"
                            : null,
                      ),
                    ),
                    _field(
                      DropdownButtonFormField<String>(
                        decoration: _decoration("Kategori Proyek"),
                        initialValue: _category,
                        borderRadius: BorderRadius.circular(16),
                        items: _categories
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) => setState(() => _category = v!),
                      ),
                    ),
                    _field(
                      TextFormField(
                        decoration: _decoration(
                          "Teknologi yang Digunakan",
                          hint: "Contoh: Flutter, Django, Figma",
                        ),
                        onChanged: (v) => setState(() => _technologies = v),
                      ),
                    ),
                    _field(
                      TextFormField(
                        decoration: _decoration(
                          "Tautan Proyek",
                          hint: "URL Proyek (opsional)",
                        ),
                        onChanged: (v) => setState(() => _projectLink = v),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _GlossyButton(label: "Save", onPressed: _save),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE1F5FE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        title: const Text(
          'Proyek berhasil ditambahkan!',
          style: TextStyle(
            color: Color(0xFF01579B),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Proyek: $_projectName'),
              Text('Deskripsi: $_description'),
              Text('Kategori: $_category'),
              Text('Teknologi: $_technologies'),
              Text('Tautan: $_projectLink'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF0288D1)),
            ),
            onPressed: () {
              Navigator.pop(context);
              _formKey.currentState!.reset();
            },
          ),
        ],
      ),
    );
  }
}

// Glossy "Aero" button
class _GlossyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GlossyButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const base = Color(0xFF29B6F6);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(base, Colors.white, 0.25)!,
            base,
            Color.lerp(base, Colors.black, 0.15)!,
          ],
        ),
        border: Border.all(color: Colors.white.withAlpha(220), width: 2),
        boxShadow: [
          BoxShadow(
            color: base.withAlpha(120),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  heightFactor: 0.5,
                  widthFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withAlpha(150),
                          Colors.white.withAlpha(20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}