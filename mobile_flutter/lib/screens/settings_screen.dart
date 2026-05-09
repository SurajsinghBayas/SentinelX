/// Settings Screen — User profile, monitoring controls, Gmail integration, connection status
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../services/sms_service.dart';
import '../config/api_config.dart';
import '../config/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _backendOnline = false;
  bool _checkingHealth = true;
  List<Map<String, dynamic>> _gmailAccounts = [];
  bool _loadingGmail = false;

  @override
  void initState() {
    super.initState();
    _checkBackend();
    _fetchGmailAccounts();
  }

  Future<void> _checkBackend() async {
    setState(() => _checkingHealth = true);
    final auth = context.read<AuthService>();
    if (auth.token != null) {
      final api = ApiService(auth.token!);
      final online = await api.checkHealth();
      if (mounted) setState(() {
        _backendOnline = online;
        _checkingHealth = false;
      });
    } else {
      if (mounted) setState(() => _checkingHealth = false);
    }
  }

  Future<void> _fetchGmailAccounts() async {
    final auth = context.read<AuthService>();
    if (auth.token == null) return;
    setState(() => _loadingGmail = true);
    try {
      final resp = await http.get(
        Uri.parse(ApiConfig.gmailAccounts),
        headers: auth.authHeaders,
      );
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        if (mounted) setState(() => _gmailAccounts = List<Map<String, dynamic>>.from(data));
      }
    } catch (e) {
      debugPrint('Failed to fetch Gmail accounts: $e');
    } finally {
      if (mounted) setState(() => _loadingGmail = false);
    }
  }

  Future<void> _connectGmail() async {
    final auth = context.read<AuthService>();
    if (auth.token == null) return;

    // Open the Gmail connect URL in the browser
    // The backend handles OAuth and redirects back
    final url = '${ApiConfig.gmailConnect}?token=${auth.token}';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      // Poll for new accounts after user returns
      Future.delayed(const Duration(seconds: 5), _fetchGmailAccounts);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open browser: $e'), backgroundColor: AppTheme.danger),
        );
      }
    }
  }

  Future<void> _disconnectGmail(String accountId) async {
    final auth = context.read<AuthService>();
    if (auth.token == null) return;

    try {
      final resp = await http.delete(
        Uri.parse('${ApiConfig.gmailAccounts}/$accountId'),
        headers: auth.authHeaders,
      );
      if (resp.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gmail account disconnected'), backgroundColor: AppTheme.success),
          );
        }
        _fetchGmailAccounts();
      }
    } catch (e) {
      debugPrint('Failed to disconnect Gmail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final sms = context.watch<SmsMonitorService>();

    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ─── User Profile ────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.accent,
                  child: Text(
                    (auth.userName.isNotEmpty ? auth.userName[0] : 'U').toUpperCase(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(auth.userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(auth.userEmail, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          auth.userRole.toUpperCase(),
                          style: const TextStyle(color: AppTheme.accent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ─── Connection Status ───────────────────────────────────
          _sectionTitle('Connection'),
          _settingTile(
            icon: Icons.cloud,
            title: 'Backend Server',
            subtitle: ApiConfig.baseUrl,
            trailing: _checkingHealth
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(
                    _backendOnline ? Icons.check_circle : Icons.cancel,
                    color: _backendOnline ? AppTheme.success : AppTheme.danger,
                  ),
            onTap: _checkBackend,
          ),
          const SizedBox(height: 20),

          // ─── Monitoring ──────────────────────────────────────────
          _sectionTitle('Monitoring'),
          _settingTile(
            icon: Icons.sms,
            title: 'SMS Monitoring',
            subtitle: sms.isMonitoring
                ? '${sms.interceptedMessages.length} messages scanned'
                : 'Tap to enable',
            trailing: Switch(
              value: sms.isMonitoring,
              activeColor: AppTheme.success,
              onChanged: (val) async {
                if (val) {
                  if (auth.token != null) {
                    sms.setApiService(ApiService(auth.token!));
                  }
                  await sms.startMonitoring();
                } else {
                  sms.stopMonitoring();
                }
              },
            ),
          ),
          _settingTile(
            icon: Icons.notifications_active,
            title: 'Threat Notifications',
            subtitle: 'Local alerts on threat detection',
            trailing: const Icon(Icons.check_circle, color: AppTheme.success),
          ),
          const SizedBox(height: 20),

          // ─── Gmail Integration ────────────────────────────────────
          _sectionTitle('Email Integration'),
          if (_loadingGmail)
            const Center(child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(strokeWidth: 2),
            ))
          else if (_gmailAccounts.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.accent.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.email, size: 36, color: AppTheme.accent),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Connect Gmail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'SentinelX will automatically scan incoming emails for phishing and scam threats.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _connectGmail,
                      icon: const Icon(Icons.link, size: 18),
                      label: const Text('Connect Gmail Account'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ..._gmailAccounts.map((account) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.email, color: AppTheme.success, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account['email_address'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          account['last_synced_at'] != null
                              ? 'Last synced: ${_formatDate(account['last_synced_at'])}'
                              : 'Auto-scanning enabled',
                          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.link_off, color: AppTheme.danger, size: 20),
                    onPressed: () => _showDisconnectDialog(account['id'], account['email_address'] ?? ''),
                  ),
                ],
              ),
            )),
          if (_gmailAccounts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TextButton.icon(
                onPressed: _connectGmail,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Another Gmail Account', style: TextStyle(fontSize: 12)),
              ),
            ),
          const SizedBox(height: 20),

          // ─── Info ────────────────────────────────────────────────
          _sectionTitle('About'),
          _settingTile(
            icon: Icons.info_outline,
            title: 'SentinelX',
            subtitle: 'v1.0.0 — AI-Powered Threat Detection',
          ),
          const SizedBox(height: 32),

          // ─── Logout ──────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                sms.stopMonitoring();
                await auth.logout();
              },
              icon: const Icon(Icons.logout, color: AppTheme.danger),
              label: const Text('Sign Out', style: TextStyle(color: AppTheme.danger)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppTheme.danger.withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDisconnectDialog(String id, String email) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Disconnect Gmail?'),
        content: Text('Stop monitoring $email for threats?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _disconnectGmail(id);
            },
            child: const Text('Disconnect', style: TextStyle(color: AppTheme.danger)),
          ),
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (_) {
      return iso;
    }
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1)),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)) : null,
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

