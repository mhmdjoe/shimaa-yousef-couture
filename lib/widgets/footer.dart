import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'editable_text_widget.dart';
import 'editable_social_icon.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppTheme.charcoal,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryGold, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo.jpeg',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 25),
          EditableTextWidget(
            textKey: 'footer_brand_name',
            defaultText: 'SHIMAA YOUSEF COUTURE',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 40),
          const EditableTextWidget(
            textKey: 'footer_inquiry_text',
            defaultText: 'FOR INQUIRIES & RESERVATIONS',
            style: TextStyle(color: Colors.white70, letterSpacing: 1, fontSize: 12),
          ),
          const SizedBox(height: 20),
          const EditableTextWidget(
            textKey: 'footer_contact_info',
            defaultText: 'contact@shimaayousef.com\n+1 234 567 890',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.primaryGold, fontSize: 16),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EditableSocialIcon(
                iconKey: 'instagram',
                icon: Icons.camera_alt_outlined,
                label: 'Instagram',
              ),
              const SizedBox(width: 20),
              const EditableSocialIcon(
                iconKey: 'facebook',
                icon: Icons.facebook_outlined,
                label: 'Facebook',
              ),
              const SizedBox(width: 20),
              const EditableSocialIcon(
                iconKey: 'pinterest',
                icon: Icons.push_pin_outlined,
                label: 'Pinterest',
              ),
            ],
          ),
          const SizedBox(height: 60),
          const EditableTextWidget(
            textKey: 'footer_copyright',
            defaultText: '© 2026 SHIMAA YOUSEF COUTURE. ALL RIGHTS RESERVED.',
            style: TextStyle(color: Colors.white24, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
