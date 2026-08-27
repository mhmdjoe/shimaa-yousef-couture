import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/admin_service.dart';
import '../theme/app_theme.dart';

class EditableSocialIcon extends StatefulWidget {
  final String iconKey;
  final IconData icon;
  final String label;

  const EditableSocialIcon({
    super.key,
    required this.iconKey,
    required this.icon,
    required this.label,
  });

  @override
  State<EditableSocialIcon> createState() => _EditableSocialIconState();
}

class _EditableSocialIconState extends State<EditableSocialIcon> {
  late String currentUrl;
  final AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
    currentUrl = _adminService.getSocialUrl(widget.iconKey);
  }

  Future<void> _handlePress() async {
    if (_adminService.isAdmin.value) {
      _editUrl();
    } else {
      final Uri uri = Uri.parse(currentUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open link')),
          );
        }
      }
    }
  }

  void _editUrl() {
    final TextEditingController controller = TextEditingController(text: currentUrl);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${widget.label} Link'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter full URL (e.g., https://instagram.com/yourprofile)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _adminService.setSocialUrl(widget.iconKey, controller.text);
              setState(() {
                currentUrl = controller.text;
              });
              if (mounted) Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.charcoal,
              foregroundColor: Colors.white,
            ),
            child: const Text('SAVE CHANGES'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _adminService.isAdmin,
      builder: (context, isAdmin, _) {
        return IconButton(
          onPressed: _handlePress,
          icon: Icon(
            widget.icon,
            color: isAdmin ? AppTheme.primaryGold : Colors.white70,
            size: 28,
          ),
          tooltip: isAdmin ? 'Edit ${widget.label} Link' : widget.label,
        );
      },
    );
  }
}
