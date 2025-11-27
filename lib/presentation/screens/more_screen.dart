import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Features'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Text(
                '💾'), // Using emoji instead of icon to avoid rendering issues
            title: const Text('Backup & Restore'),
            trailing: const Text(
                '>'), // Using text instead of icon to avoid rendering issues
            onTap: () {
              // Handle backup & restore
            },
          ),
          const Divider(),
          ListTile(
            leading: const Text(
                '📤'), // Using emoji instead of icon to avoid rendering issues
            title: const Text('Share App'),
            trailing: const Text(
                '>'), // Using text instead of icon to avoid rendering issues
            onTap: () {
              // Handle share app
            },
          ),
          const Divider(),
          ListTile(
            leading: const Text(
                '❓'), // Using emoji instead of icon to avoid rendering issues
            title: const Text('Help & Support'),
            trailing: const Text(
                '>'), // Using text instead of icon to avoid rendering issues
            onTap: () {
              // Handle help & support
            },
          ),
          const Divider(),
          ListTile(
            leading: const Text(
                'ℹ️'), // Using emoji instead of icon to avoid rendering issues
            title: const Text('About'),
            trailing: const Text(
                '>'), // Using text instead of icon to avoid rendering issues
            onTap: () {
              // Handle about
            },
          ),
        ],
      ),
    );
  }
}
