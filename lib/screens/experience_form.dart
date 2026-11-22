import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/glossy_button.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  String _title = "";
  String _description = "";
  String _category = "full-time"; // Django value
  String _institution = "";
  String _thumbnail = "";
  DateTime? _startedAt;
  DateTime? _endedAt;

  // key = value stored in Django, value = label shown
  final Map<String, String> _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-time',
    'full-time': 'Full-time',
    'freelance': 'Freelance',
    'other': 'Other',
  };

  @override
  void dispose() {
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint, Widget? suffix}) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffix,
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

  String _fmt(DateTime d) => d.toIso8601String().substring(0, 10);

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startedAt : _endedAt) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startedAt = picked;
        _startCtrl.text = _fmt(picked);
      } else {
        _endedAt = picked;
        _endCtrl.text = _fmt(picked);
      }
    });
  }

  // Keys match the Django serializer
  Map<String, dynamic> _toJson() => {
        'title': _title,
        'description': _description,
        'category': _category,
        'institution': _institution,
        'thumbnail': _thumbnail.isEmpty ? null : _thumbnail,
        'started_at': _startedAt?.toIso8601String(),
        'ended_at': _endedAt?.toIso8601String(),
      };

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
          'Add Experience Form',
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
                        decoration: _decoration("Experience Title"),
                        onChanged: (v) => setState(() => _title = v),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? "Judul tidak boleh kosong!"
                            : null,
                      ),
                    ),
                    _field(
                      TextFormField(
                        maxLines: 5,
                        decoration: _decoration("Experience Description"),
                        onChanged: (v) => setState(() => _description = v),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? "Description cannot be empty!"
                            : null,
                      ),
                    ),
                    _field(
                      DropdownButtonFormField<String>(
                        decoration: _decoration("Experience Category"),
                        initialValue: _category,
                        borderRadius: BorderRadius.circular(16),
                        items: _categories.entries
                            .map((e) => DropdownMenuItem(
                                value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (v) => setState(() => _category = v!),
                      ),
                    ),
                    _field(
                      TextFormField(
                        decoration: _decoration(
                          "Institution",
                          hint: "Company / Organization name (optional)",
                        ),
                        onChanged: (v) => setState(() => _institution = v),
                      ),
                    ),
                    _field(
                      TextFormField(
                        decoration: _decoration(
                          "Thumbnail link",
                          hint: "image URL (opsional)",
                        ),
                        onChanged: (v) => setState(() => _thumbnail = v),
                      ),
                    ),
                    _field(
                      TextFormField(
                        controller: _startCtrl,
                        readOnly: true,
                        decoration: _decoration(
                          "Start date",
                          suffix: const Icon(Icons.calendar_today),
                        ),
                        onTap: () => _pickDate(isStart: true),
                        validator: (v) => (v == null || v.isEmpty)
                            ? "Start date cannot be empty!"
                            : null,
                      ),
                    ),
                    _field(
                      TextFormField(
                        controller: _endCtrl,
                        readOnly: true,
                        decoration: _decoration(
                          "End date",
                          hint: "Leave empty if ongoing",
                          suffix: _endedAt == null
                              ? const Icon(Icons.calendar_today)
                              : IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => setState(() {
                                    _endedAt = null;
                                    _endCtrl.clear();
                                  }),
                                ),
                        ),
                        onTap: () => _pickDate(isStart: false),
                        validator: (_) {
                          if (_endedAt != null &&
                              _startedAt != null &&
                              _endedAt!.isBefore(_startedAt!)) {
                            return "End date cannot precede start date!";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    GlossyButton(label: "Save", onPressed: _save),
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
          'Pengalaman berhasil ditambahkan!',
          style: TextStyle(
            color: Color(0xFF01579B),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Judul: $_title'),
              Text('Deskripsi: $_description'),
              Text('Kategori: ${_categories[_category]}'),
              Text('Institusi: $_institution'),
              Text('Thumbnail: $_thumbnail'),
              Text('Mulai: ${_startedAt == null ? '-' : _fmt(_startedAt!)}'),
              Text('Selesai: ${_endedAt == null ? 'Masih berlangsung' : _fmt(_endedAt!)}'),
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
              setState(() {
                _startedAt = null;
                _endedAt = null;
                _startCtrl.clear();
                _endCtrl.clear();
              });
            },
          ),
        ],
      ),
    );
  }
}