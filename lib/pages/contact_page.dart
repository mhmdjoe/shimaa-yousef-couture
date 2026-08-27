import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/editable_text_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
                          'CONTACT US',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        child: const Text(
                          'RESERVE YOUR PRIVATE CONSULTATION',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                      
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 800) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildOwnerInfo(context)),
                                const SizedBox(width: 80),
                                Expanded(child: _buildReservationDetails(context)),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                _buildOwnerInfo(context),
                                const SizedBox(height: 60),
                                _buildReservationDetails(context),
                              ],
                            );
                          }
                        },
                      ),
                      
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
            child: Navbar(isScrolled: true),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerInfo(BuildContext context) {
    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'THE MAISON',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 20),
          EditableTextWidget(
            textKey: 'owner_name',
            defaultText: 'Shimaa Yousef Mazroa',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.charcoal,
            ),
          ),
          const SizedBox(height: 20),
          const EditableTextWidget(
            textKey: 'owner_role',
            defaultText: 'Founder & Creative Director',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          const EditableTextWidget(
            textKey: 'owner_bio',
            defaultText: 'Located in the heart of couture, our atelier is dedicated to creating timeless pieces that tell a story. Shimaa Yousef Mazroa personally oversees each creation to ensure the highest standards of craftsmanship.',
            style: TextStyle(height: 1.8, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationDetails(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'RESERVATION DETAILS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            _infoItem('Phone', '+1 234 567 890', 'contact_phone'),
            _infoItem('Email', 'reservations@shimaayousef.com', 'contact_email'),
            _infoItem('Atelier Hours', 'Mon - Fri: 10:00 AM - 6:00 PM\nSat: 11:00 AM - 4:00 PM', 'contact_hours'),
            const SizedBox(height: 30),
            const Text(
              'Please note that consultations are by appointment only to provide you with the most personalized experience.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.primaryGold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          EditableTextWidget(
            textKey: key,
            defaultText: value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
