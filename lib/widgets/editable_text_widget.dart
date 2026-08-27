import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../theme/app_theme.dart';

class EditableTextWidget extends StatefulWidget {
  final String textKey;
  final String defaultText;
  final TextStyle? style;
  final TextAlign? textAlign;

  const EditableTextWidget({
    super.key,
    required this.textKey,
    required this.defaultText,
    this.style,
    this.textAlign,
  });

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late String currentText;
  final AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
    currentText = _adminService.getText(widget.textKey, widget.defaultText);
  }

  void _editText() {
    final TextEditingController controller = TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Text'),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Enter text here...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _adminService.setText(widget.textKey, controller.text);
              setState(() {
                currentText = controller.text;
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
        return InkWell(
          onTap: isAdmin ? _editText : null,
          child: Container(
            decoration: isAdmin
                ? BoxDecoration(
                    border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3), width: 0.5),
                  )
                : null,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  currentText,
                  style: widget.style,
                  textAlign: widget.textAlign,
                ),
                if (isAdmin)
                  Positioned(
                    top: -12,
                    right: -12,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
