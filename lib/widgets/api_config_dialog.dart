// lib/widgets/api_config_dialog.dart

import 'package:flutter/material.dart';
import '../services/supabase_config.dart';
import '../services/supabase_service.dart';
import '../services/gemini_service.dart';
import '../utils/input_validators.dart';

class ApiConfigDialog extends StatefulWidget {
  const ApiConfigDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ApiConfigDialog(),
    );
  }

  @override
  State<ApiConfigDialog> createState() => _ApiConfigDialogState();
}

class _ApiConfigDialogState extends State<ApiConfigDialog> {
  late final TextEditingController _supabaseUrlController;
  late final TextEditingController _supabaseKeyController;
  late final TextEditingController _geminiKeyController;

  bool _isTestingSupabase = false;
  bool _isTestingGemini = false;
  String? _supabaseStatus;
  bool? _supabaseOk;
  String? _geminiStatus;
  bool? _geminiOk;
  bool _isSaving = false;

  String? _supabaseUrlError;
  String? _supabaseKeyError;
  String? _geminiKeyError;

  @override
  void initState() {
    super.initState();
    _supabaseUrlController = TextEditingController(
      text: SupabaseConfig.url.contains('demo-placeholder') ? '' : SupabaseConfig.url,
    );
    _supabaseKeyController = TextEditingController(
      text: SupabaseConfig.anonKey.contains('placeholder') ? '' : SupabaseConfig.anonKey,
    );
    _geminiKeyController = TextEditingController(
      text: SupabaseConfig.geminiApiKey,
    );

    _supabaseOk = SupabaseService().isLive;
    _supabaseStatus = _supabaseOk == true ? 'Connected to Database' : 'Not Connected (Local Mode)';
    _geminiOk = SupabaseConfig.isGeminiConfigured();
    _geminiStatus = _geminiOk == true ? 'API Key configured' : 'API Key missing';
  }

  @override
  void dispose() {
    _supabaseUrlController.dispose();
    _supabaseKeyController.dispose();
    _geminiKeyController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final url = _supabaseUrlController.text.trim();
    final key = _supabaseKeyController.text.trim();
    final gemini = _geminiKeyController.text.trim();

    String? urlErr;
    if (url.isNotEmpty) {
      urlErr = InputValidators.validateUrl(url, required: false);
    }

    String? keyErr;
    if (key.isNotEmpty && key.length < 15) {
      keyErr = '❌ Invalid Anon Key (minimum 15 characters required)';
    }

    String? geminiErr;
    if (gemini.isNotEmpty && gemini.length < 8) {
      geminiErr = '❌ Invalid Gemini API key (minimum 8 characters required)';
    }

    setState(() {
      _supabaseUrlError = urlErr;
      _supabaseKeyError = keyErr;
      _geminiKeyError = geminiErr;
    });

    return urlErr == null && keyErr == null && geminiErr == null;
  }

  Future<void> _testSupabase() async {
    final url = _supabaseUrlController.text.trim();
    if (url.isNotEmpty) {
      final urlErr = InputValidators.validateUrl(url, required: true);
      if (urlErr != null) {
        setState(() => _supabaseUrlError = urlErr);
        return;
      }
    }

    setState(() {
      _isTestingSupabase = true;
      _supabaseStatus = 'Testing Supabase connection...';
    });

    final res = await SupabaseService().testConnection();
    setState(() {
      _isTestingSupabase = false;
      _supabaseOk = res['success'] == true;
      _supabaseStatus = res['message']?.toString() ?? '';
    });
  }

  Future<void> _testGemini() async {
    final gemini = _geminiKeyController.text.trim();
    if (gemini.isNotEmpty && gemini.length < 8) {
      setState(() => _geminiKeyError = '❌ Invalid Gemini API key (too short)');
      return;
    }

    setState(() {
      _isTestingGemini = true;
      _geminiStatus = 'Testing Gemini AI generation...';
    });

    final res = await GeminiService().testConnection();
    setState(() {
      _isTestingGemini = false;
      _geminiOk = res['success'] == true;
      _geminiStatus = res['message']?.toString() ?? '';
    });
  }

  Future<void> _saveAndApply() async {
    if (!_validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please fix invalid field values before saving / कृपया सही मान दर्ज करें'),
          backgroundColor: Color(0xFFC62828),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final url = _supabaseUrlController.text.trim();
    final key = _supabaseKeyController.text.trim();
    final gemini = _geminiKeyController.text.trim();

    await SupabaseConfig.saveCredentials(
      url: url,
      anonKey: key,
      geminiApiKey: gemini,
    );

    await SupabaseService().init();

    if (mounted) {
      setState(() {
        _isSaving = false;
        _supabaseOk = SupabaseService().isLive;
        _geminiOk = SupabaseConfig.isGeminiConfigured();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Credentials saved & applied successfully!'),
          backgroundColor: Color(0xFF2E7D32),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(top: 40, bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA84318).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cloud_sync_rounded, color: Color(0xFFA84318), size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cloud & AI Settings',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F1612)),
                      ),
                      Text(
                        'Supabase Database & Gemini AI Setup',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5F0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        _supabaseOk == true ? Icons.check_circle : Icons.warning_amber_rounded,
                        color: _supabaseOk == true ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Supabase: ${_supabaseStatus ?? "Checking..."}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _supabaseOk == true ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _geminiOk == true ? Icons.check_circle : Icons.warning_amber_rounded,
                        color: _geminiOk == true ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Gemini AI: ${_geminiStatus ?? "Checking..."}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _geminiOk == true ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Supabase URL
            const Text(
              'Supabase Project URL',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F1612)),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _supabaseUrlController,
              keyboardType: TextInputType.url,
              onChanged: (val) {
                if (_supabaseUrlError != null) {
                  setState(() => _supabaseUrlError = val.isNotEmpty ? InputValidators.validateUrl(val, required: false) : null);
                }
              },
              decoration: InputDecoration(
                hintText: 'https://xyzcompany.supabase.co',
                filled: true,
                fillColor: _supabaseUrlError != null ? const Color(0xFFFFF5F5) : const Color(0xFFFBF9F7),
                prefixIcon: Icon(Icons.link, size: 20, color: _supabaseUrlError != null ? const Color(0xFFC62828) : Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: _supabaseUrlError != null ? const Color(0xFFC62828) : Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            if (_supabaseUrlError != null) ...[
              const SizedBox(height: 4),
              Text(_supabaseUrlError!, style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 14),

            // Supabase Anon Key
            const Text(
              'Supabase Anon Key',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F1612)),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _supabaseKeyController,
              onChanged: (val) {
                if (_supabaseKeyError != null) {
                  setState(() => _supabaseKeyError = null);
                }
              },
              decoration: InputDecoration(
                hintText: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
                filled: true,
                fillColor: _supabaseKeyError != null ? const Color(0xFFFFF5F5) : const Color(0xFFFBF9F7),
                prefixIcon: Icon(Icons.key, size: 20, color: _supabaseKeyError != null ? const Color(0xFFC62828) : Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: _supabaseKeyError != null ? const Color(0xFFC62828) : Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            if (_supabaseKeyError != null) ...[
              const SizedBox(height: 4),
              Text(_supabaseKeyError!, style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _isTestingSupabase ? null : _testSupabase,
                icon: _isTestingSupabase
                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.refresh, size: 16),
                label: const Text('Test Database Connection', style: TextStyle(fontSize: 12)),
              ),
            ),

            const Divider(height: 24),

            // Gemini API Key
            const Text(
              'Gemini AI API Key',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F1612)),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _geminiKeyController,
              obscureText: true,
              onChanged: (val) {
                if (_geminiKeyError != null) {
                  setState(() => _geminiKeyError = null);
                }
              },
              decoration: InputDecoration(
                hintText: 'AIzaSy...',
                filled: true,
                fillColor: _geminiKeyError != null ? const Color(0xFFFFF5F5) : const Color(0xFFFBF9F7),
                prefixIcon: Icon(Icons.auto_awesome, size: 20, color: _geminiKeyError != null ? const Color(0xFFC62828) : const Color(0xFFA84318)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: _geminiKeyError != null ? const Color(0xFFC62828) : Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            if (_geminiKeyError != null) ...[
              const SizedBox(height: 4),
              Text(_geminiKeyError!, style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _isTestingGemini ? null : _testGemini,
                icon: _isTestingGemini
                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.psychology, size: 16),
                label: const Text('Test Gemini AI Key', style: TextStyle(fontSize: 12)),
              ),
            ),

            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveAndApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA84318),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _isSaving
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                          SizedBox(width: 10),
                          Text('Saving & Initializing...'),
                        ],
                      )
                    : const Text(
                        'Save & Connect Now',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
