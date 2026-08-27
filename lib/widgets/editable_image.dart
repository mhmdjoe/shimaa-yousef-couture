import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import '../services/admin_service.dart';
import '../theme/app_theme.dart';

class EditableImage extends StatefulWidget {
  final String imageKey;
  final String defaultUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Widget? placeholder;

  const EditableImage({
    super.key,
    required this.imageKey,
    required this.defaultUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder,
  });

  @override
  State<EditableImage> createState() => _EditableImageState();
}

class _EditableImageState extends State<EditableImage> {
  late String currentUrl;
  final AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
    currentUrl = _adminService.getImageUrl(widget.imageKey, widget.defaultUrl);
  }

  void _editImage() {
    final TextEditingController controller = TextEditingController(text: currentUrl.startsWith('data:image') ? 'Local Upload' : currentUrl);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter image URL',
                labelText: 'Image URL',
              ),
            ),
            const SizedBox(height: 20),
            const Text('OR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  withData: true,
                );

                if (result != null && result.files.first.bytes != null) {
                  String base64String = 'data:image/jpeg;base64,' + base64Encode(result.files.first.bytes!);
                  await _adminService.setImageUrl(widget.imageKey, base64String);
                  setState(() {
                    currentUrl = base64String;
                  });
                  if (mounted) Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('UPLOAD FROM LAPTOP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGold,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text != 'Local Upload') {
                await _adminService.setImageUrl(widget.imageKey, controller.text);
                setState(() {
                  currentUrl = controller.text;
                });
              }
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
        Widget imageWidget;
        if (currentUrl.startsWith('data:image')) {
          try {
            final bytes = base64Decode(currentUrl.split(',').last);
            imageWidget = Image.memory(
              bytes,
              fit: widget.fit,
              height: widget.height,
              width: widget.width,
            );
          } catch (e) {
            imageWidget = const Center(child: Icon(Icons.broken_image));
          }
        } else {
          imageWidget = Image.network(
            currentUrl,
            fit: widget.fit,
            height: widget.height,
            width: widget.width,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return widget.placeholder ?? const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Center(child: Icon(Icons.error_outline)),
            ),
          );
        }

        return Stack(
          fit: StackFit.passthrough,
          children: [
            imageWidget,
            if (isAdmin)
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: FloatingActionButton.small(
                    elevation: 4,
                    backgroundColor: AppTheme.primaryGold,
                    onPressed: _editImage,
                    child: const Icon(Icons.edit, size: 20, color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
