import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  bool _obscure = false;
  bool _notificationsEnabled = false;

  int _versionTapCount = 0;
  bool _showVersionGif = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notifications'),
            value: _obscure,
            onChanged: (value) {
              setState(() {
                _obscure = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),
          SwitchListTile(
            title: const Text('Dark theme'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),
          ListTile(
            title: Text('Application version'),
            subtitle: Text('1.0.0'),
            onTap: () {
              setState(() {
                _versionTapCount++;
                if (_versionTapCount >= 7) {
                  _showVersionGif = true;

                  Future.delayed(const Duration(seconds: 8), () {
                    if (mounted) {
                      setState(() {
                        _showVersionGif = false;
                        _versionTapCount = 0;
                      });
                    }
                  });
                }
              });
            },
          ),
          if (_showVersionGif)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/gifs/5361672752388403138.gif',
                        height: 500,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ListTile(
            title: const Text('Privacy policy'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Use'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
