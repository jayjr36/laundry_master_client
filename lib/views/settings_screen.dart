import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Settings")),
      body: SwitchListTile(
        title: const Text("Dark Mode"),
        value: isDarkMode,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
            // Update app-wide theme
            ThemeData theme = Theme.of(context);
            setState(() {
              theme = theme.copyWith(
                brightness: isDarkMode ? Brightness.dark : Brightness.light,
              );
            });
          });
        },
      ),
    );
  }
}
