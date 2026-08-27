import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import '../pages/collections_page.dart';
import 'editable_image.dart';
import 'editable_text_widget.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      height: size.height * 0.9,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
      child: Stack(
        children: [
          // Background Image (Placeholder)
          Positioned.fill(
            child: FadeIn(
              duration: const Duration(seconds: 2),
              child: Opacity(
                opacity: 0.1,
                child: const EditableImage(
                  imageKey: 'hero_bg',
                  defaultUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1983&auto=format&fit=crop',
                ),
              ),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: EditableTextWidget(
                    textKey: 'hero_title',
                    defaultText: 'The Art of\nElegance',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 50 : 100,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  delay: const Duration(milliseconds: 500),
                  child: EditableTextWidget(
                    textKey: 'hero_subtitle',
                    defaultText: 'HANDCRAFTED COUTURE FOR THE MODERN WOMAN',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 50),
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  delay: const Duration(milliseconds: 800),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CollectionsPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                      side: const BorderSide(color: AppTheme.charcoal, width: 2),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'EXPLORE COLLECTION',
                      style: TextStyle(color: AppTheme.charcoal, letterSpacing: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
