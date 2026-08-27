import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'editable_image.dart';
import 'editable_text_widget.dart';

class PortfolioGrid extends StatelessWidget {
  PortfolioGrid({super.key});

  final List<String> dressImages = [
    'https://images.unsplash.com/photo-1518932945647-7a1c969f8be2?q=80&w=1943&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?q=80&w=1974&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1566174053879-31528523f8ae?q=80&w=1908&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1983&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1585487000160-6ebcfceb0d03?q=80&w=1934&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?q=80&w=1946&auto=format&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount = size.width < 600 ? 1 : (size.width < 1200 ? 2 : 3);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LATEST WORK',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 20),
          Text(
            'Summer 2026 Collection',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 60),
          MasonryGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            itemCount: dressImages.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInUp(
                duration: const Duration(milliseconds: 1000),
                delay: Duration(milliseconds: index * 100),
                child: _PortfolioItem(imageUrl: dressImages[index], index: index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PortfolioItem extends StatefulWidget {
  final String imageUrl;
  final int index;

  const _PortfolioItem({required this.imageUrl, required this.index});

  @override
  State<_PortfolioItem> createState() => _PortfolioItemState();
}

class _PortfolioItemState extends State<_PortfolioItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        transform: isHovered 
            ? (Matrix4.identity()..scale(1.02, 1.02, 1.0)) 
            : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: widget.index % 2 == 0 ? 0.7 : 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: EditableImage(
                  imageKey: 'portfolio_${widget.index}',
                  defaultUrl: widget.imageUrl,
                ),
              ),
            ),
            const SizedBox(height: 15),
            EditableTextWidget(
              textKey: 'portfolio_title_${widget.index}',
              defaultText: 'DRESS MODEL NO. 0${widget.index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
                color: AppTheme.charcoal,
              ),
            ),
            const SizedBox(height: 5),
            EditableTextWidget(
              textKey: 'portfolio_desc_${widget.index}',
              defaultText: 'Silk & Chantilly Lace',
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
