import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/editable_image.dart';
import '../widgets/editable_text_widget.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      FadeInDown(
                        child: Text(
                          'OUR COLLECTIONS',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        child: Text(
                          'EXPLORE THE ESSENCE OF SHIMAA YOUSEF COUTURE',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 80),
                      _buildCollectionGrid(context),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
                const AppFooter(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(isScrolled: true), // Always white on this page for legibility
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionGrid(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Column(
      children: [
        _CollectionCard(
          title: 'BRIDAL SERIES',
          subtitle: 'Eternal Elegance',
          imageUrl: 'https://images.unsplash.com/photo-1594465919760-441fe5908ab0?q=80&w=1964&auto=format&fit=crop',
          isLarge: !isMobile,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _CollectionCard(
                title: 'EVENING WEAR',
                subtitle: 'Night in Paris',
                imageUrl: 'https://images.unsplash.com/photo-1566174053879-31528523f8ae?q=80&w=1908&auto=format&fit=crop',
              ),
            ),
            if (!isMobile) const SizedBox(width: 40),
            if (!isMobile)
              Expanded(
                child: _CollectionCard(
                  title: 'READY-TO-WEAR',
                  subtitle: 'Modern Minimal',
                  imageUrl: 'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?q=80&w=1974&auto=format&fit=crop',
                ),
              ),
          ],
        ),
        if (isMobile) const SizedBox(height: 40),
        if (isMobile)
          _CollectionCard(
            title: 'READY-TO-WEAR',
            subtitle: 'Modern Minimal',
            imageUrl: 'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?q=80&w=1974&auto=format&fit=crop',
          ),
      ],
    );
  }
}

class _CollectionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isLarge;

  const _CollectionCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isLarge = false,
  });

  @override
  State<_CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<_CollectionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {}, // Future: Link to specific collection items
        child: FadeInUp(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            height: widget.isLarge ? 600 : 450,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  EditableImage(
                    imageKey: 'collection_${widget.title.replaceAll(' ', '_')}',
                    defaultUrl: widget.imageUrl,
                  ),
                  Container(
                    color: Colors.black.withOpacity(isHovered ? 0.2 : 0.4),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditableTextWidget(
                          textKey: 'collection_title_${widget.title.replaceAll(' ', '_')}',
                          defaultText: widget.title,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: widget.isLarge ? 40 : 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        EditableTextWidget(
                          textKey: 'collection_subtitle_${widget.title.replaceAll(' ', '_')}',
                          defaultText: widget.subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isHovered ? 1.0 : 0.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: const Text(
                            'VIEW COLLECTION',
                            style: TextStyle(color: Colors.white, fontSize: 10, letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
