import 'package:flutter/material.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Account details'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Personal info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
            _buildInfoSection([
              _buildInfoTile('Name', 'Surjith Khannan Rajasekar 23BCE...'),
              _buildInfoTile('Email', 'surjith.khannan2023@vitstudent....'),
              _buildInfoTile('Phone number', ''),
              _buildInfoTile('Country', 'United Kingdom'),
              _buildInfoTile('Birthday', ''),
              _buildInfoTile('Gender', ''),
              _buildInfoTile('Dietary preferences', ''),
            ]),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'My locations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70
                ),
              ),
            ),
            _buildInfoSection([
              _buildInfoTile('Home', ''),
              _buildInfoTile('Work', ''),
              _buildInfoTile('Other', ''),
            ]),
            const SizedBox(height: 16),
            _buildDeleteAccount(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(
          top: BorderSide(color: Colors.grey[800]!),
          bottom: BorderSide(color: Colors.grey[800]!),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildDeleteAccount() {
    return ListTile(
      leading: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
      title: const Text(
        'Delete account',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}