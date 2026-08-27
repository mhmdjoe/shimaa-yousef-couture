import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../pages/collections_page.dart';
import '../pages/contact_page.dart';
import '../services/admin_service.dart';

class Navbar extends StatelessWidget {
  final bool isScrolled;
  const Navbar({super.key, this.isScrolled = false});

  void _showAdminLogin(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Admin Access'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter Password',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              if (AdminService().login(controller.text)) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Admin Mode Active')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incorrect Password')),
                );
              }
            },
            child: const Text('LOGIN'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: 40, 
        vertical: isScrolled ? 15 : 25,
      ),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.white : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? Colors.black.withOpacity(0.05) : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGold, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.jpeg',
                      height: isScrolled ? 40 : 50,
                      width: isScrolled ? 40 : 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SHIMAA YOUSEF',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: AppTheme.charcoal,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'COUTURE',
                      style: TextStyle(
                        fontSize: 8,
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 600)
            Row(
              children: [
                _navItem(context, 'COLLECTIONS', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CollectionsPage()),
                  );
                }),
                const SizedBox(width: 30),
                _navItem(context, 'STORY', () {}),
                const SizedBox(width: 30),
                _navItem(context, 'CONTACT', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                }),
              ],
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded, color: AppTheme.charcoal),
            onSelected: (value) {
              switch (value) {
                case 'collections':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CollectionsPage()));
                  break;
                case 'contact':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                  break;
                case 'admin':
                  _showAdminLogin(context);
                  break;
                case 'logout':
                  AdminService().logout();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged Out')));
                  break;
              }
            },
            itemBuilder: (context) {
              final isMobile = MediaQuery.of(context).size.width <= 600;
              return [
                if (isMobile)
                  const PopupMenuItem(
                    value: 'collections',
                    child: Text('COLLECTIONS'),
                  ),
                if (isMobile)
                  const PopupMenuItem(
                    value: 'contact',
                    child: Text('CONTACT'),
                  ),
                if (isMobile) const PopupMenuDivider(),
                PopupMenuItem(
                  value: AdminService().isAdmin.value ? 'logout' : 'admin',
                  child: Row(
                    children: [
                      Icon(
                        AdminService().isAdmin.value ? Icons.logout : Icons.admin_panel_settings,
                        size: 18,
                        color: AppTheme.charcoal,
                      ),
                      const SizedBox(width: 10),
                      Text(AdminService().isAdmin.value ? 'Logout Admin' : 'Admin Login'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: AppTheme.charcoal,
        ),
      ),
    );
  }
}
