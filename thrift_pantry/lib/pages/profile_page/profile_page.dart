// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';
import '../welcome/introduction_animation_screen.dart';
import 'account_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _signOut(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser; // Check current user
    if (user != null) {
      try {
        // print('Attempting to sign out...'); // Debug statement
        await FirebaseAuth.instance.signOut(); // Sign out from Firebase
        // print('Sign out successful'); // Debug statement
        // Navigate back to the introduction page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const IntroductionAnimationScreen()),
          (route) => false, // Remove all previous routes
        );
      } catch (e) {
        // print('Sign out error: $e'); // Handle sign-out error
      }
    } else {
      // print('No user is currently signed in.'); // Debug statement
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emily Ashley',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            'EmilyAshley@gmail.com',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/50'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Milestone Achieved',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Loyalty Points: 100',
                            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                          ),
                          Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 0.36,
                                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                              ),
                              Text(
                                '36%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.inversePrimary
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Use a Container with a defined height for the GridView
                SizedBox(
                  height: 150, // Set a fixed height to prevent overflow
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: const [
                      Flexible(child: StatCard(
                        icon: Icons.co2,
                        title: 'CO2 Reduced',
                        value: '0',
                        unit: '',
                        color: Colors.red,
                      )),
                      Flexible(child: StatCard(
                        icon: Icons.money,
                        title: 'Money Saved',
                        value: '₹0',
                        unit: '',
                        color: Colors.orange,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme(); // Toggle the theme
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                _buildSection('Additional', [
                  _buildListTile('Account details', Icons.person_outline),
                  _buildListTile('Payment cards', Icons.credit_card),
                  _buildListTile('Vouchers', Icons.card_giftcard),
                  _buildListTile('Notifications', Icons.notifications_none),
                ]),
                _buildSection('Community', [
                  _buildListTile('Recommend a store', Icons.store),
                  _buildListTile('Sign up your store', Icons.add_business),
                ]),
                _buildSection('Support', [
                  _buildListTile('Help with an order', Icons.help_outline),
                  _buildListTile(
                      'How Thrift Pantry works', Icons.info_outline),
                  _buildListTile('Join Thrift Pantry', Icons.group_add),
                ]),
                _buildSection('Other', [
                  _buildListTile('Hidden stores', Icons.visibility_off),
                  _buildListTile('Blog', Icons.article_outlined),
                  _buildListTile('Legal', Icons.gavel),
                ]),
                _buildSection('Account', [
                  GestureDetector(
                    onTap: () => _signOut(context), // Directly call sign-out function
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.red, // Change color for the sign-out button
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Theme.of(context).colorScheme.inversePrimary),
                          const SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.inversePrimary), // Color for the icon
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).colorScheme.inversePrimary),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        if (title == 'Account details') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccountDetailsPage(),
            ),
          );
        }
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8), // Adjusted padding
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 40), // Adjusted size
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16, // Adjusted font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
