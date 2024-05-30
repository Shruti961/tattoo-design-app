import 'package:flutter/material.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Plans'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Basic'),
            subtitle: const Text('\$9.99/month'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selected Basic membership'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Premium'),
            subtitle: const Text('\$39.99/month'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selected Premium membership'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Pro'),
            subtitle: const Text('\$69.99/month'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selected Pro membership'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
