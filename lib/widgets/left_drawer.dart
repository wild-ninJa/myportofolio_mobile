import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE), Color(0xFFC8E6C9)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Glossy header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Portfolio',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Color(0x66006080),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore personal projects and experiences!',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DrawerItem(
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.add_circle_outline,
              label: 'Add Project',
              onTap: () async {
                if (!await ensureLoggedIn(context)) return;
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProjectFormPage()),
                );
              },
            ),
            // Add Experience: leave as-is unless your tutorial wants it guarded too.
            if (!isLoggedIn)
              _DrawerItem(
                icon: Icons.login,
                label: 'Login',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
              )
            else
              _DrawerItem(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () async {
                  await context.read<AuthState>().logout();
                  if (!context.mounted) return;
                  Navigator.pop(context); // close drawer
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Logged out')));
                },
              ),
            // _DrawerItem(
            //   icon: Icons.add_circle_outline,
            //   label: 'Add Project',
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ProjectFormPage(),
            //       ),
            //     );
            //   },
            // ),
            // _DrawerItem(
            //   icon: Icons.add_circle_outline,
            //   label: 'Add Experience',
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ExperienceFormPage(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// Glass pill menu item
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white.withAlpha(220), Colors.white.withAlpha(100)],
          ),
          border: Border.all(color: Colors.white.withAlpha(230), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0288D1).withAlpha(40),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            leading: Icon(icon, color: const Color(0xFF0288D1)),
            title: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF01579B),
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
