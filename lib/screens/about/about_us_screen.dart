import 'package:flutter/material.dart';
import 'package:optimus_power_tools_trading/screens/contact/contact_us_screen.dart';
import 'package:optimus_power_tools_trading/screens/products/product_screen.dart';

class AboutUsScreen extends StatelessWidget {
   AboutUsScreen({super.key});

  // New color scheme
  final Color primaryRed = const Color(0xFFD32F2F); // Material Red 700
  final Color darkRed = const Color(0xFFB71C1C); // Material Red 900
  final Color lightRed = const Color(0xFFFFCDD2); // Material Red 100
  final Color primaryGreen = const Color(0xFF2E7D32); // Material Green 800
  final Color lightGreen = const Color(0xFFC8E6C9); // Material Green 100
  final Color black = const Color(0xFF212121); // Almost black
  final Color white = Colors.white;
  final Color grey = Colors.grey.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: primaryRed, // Changed to red
        foregroundColor: white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
        color: white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section
              _buildHeroSection(),
              
              // Company Story
              _buildCompanyStory(),
              
              // Mission & Vision
              _buildMissionVision(),
              
              // Stats Counter
              _buildStatsSection(),
              
              // Values
              _buildValuesSection(),
              
              // Certifications
              _buildCertifications(),
              
              // Partners/Clients
              _buildPartnersSection(),
              
              // Why Choose Us (Detailed)
              _buildWhyChooseUs(),
              
              // Call to Action
              _buildCallToAction(context),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryRed, // Changed to red
            image: const DecorationImage(
              image: NetworkImage(
                '',
              ),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
        ),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                black.withOpacity(0.5), // Changed to black
                primaryRed.withOpacity(0.8), // Changed to red
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.build_circle,
                      size: 60,
                      color: white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Optimus Power Tools Trading',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your Trusted Partner in UAE Since 2009',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyStory() {
    return Container(
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightRed, // Changed to light red
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.history,
                  color: primaryRed, // Changed to red
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Our Story',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryRed, // Changed to red
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Founded in Dubai in 2009, Optimus Power Tools Trading has grown from a small workshop supplier to one of the UAE\'s leading power tool distributors. Our journey began with a simple mission: to provide construction companies and contractors with reliable, high-quality power tools at competitive bulk prices.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Over the past 15 years, we have built strong relationships with world-class manufacturers and developed a deep understanding of the UAE construction industry\'s needs. Today, we supply power tools to major construction companies, government projects, and retailers across all seven emirates.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStoryIcon(Icons.people, '500+', 'Clients'),
              _buildStoryIcon(Icons.inventory, '1000+', 'Products'),
              _buildStoryIcon(Icons.location_city, '7', 'Emirates'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryIcon(IconData icon, String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: primaryRed, size: 28), // Changed to red
          const SizedBox(height: 4),
          Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionVision() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryRed, // Changed to red
                    darkRed, // Dark red
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To empower UAE businesses with reliable power tools through exceptional service, genuine products, and competitive bulk pricing.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: primaryRed.withOpacity(0.3), // Changed to red
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lightRed, // Changed to light red
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove_red_eye,
                      color: primaryRed, // Changed to red
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryRed, // Changed to red
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To be the most trusted power tool trading company in the UAE, known for quality, reliability, and exceptional B2B service.',
                    style: TextStyle(
                      fontSize: 14,
                      color: grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('15+', 'Years Experience', Icons.timeline),
          _buildStatItem('500+', 'Happy Clients', Icons.emoji_emotions),
          _buildStatItem('50+', 'Brands', Icons.branding_watermark),
          _buildStatItem('24/7', 'Support', Icons.support_agent),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightRed, // Changed to light red
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryRed, size: 24), // Changed to red
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: grey,
          ),
        ),
      ],
    );
  }

  Widget _buildValuesSection() {
    final values = [
      {
        'icon': Icons.verified,
        'title': 'Integrity',
        'description': 'We conduct business with honesty and transparency',
      },
      {
        'icon': Icons.check_circle,
        'title': 'Quality',
        'description': 'We never compromise on product quality',
      },
      {
        'icon': Icons.handshake,
        'title': 'Partnership',
        'description': 'We build long-term relationships with clients',
      },
      {
        'icon': Icons.new_releases,
        'title': 'Innovation',
        'description': 'We stay updated with latest tool technology',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: white, // Changed to light red
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Core Values',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryRed, // Changed to red
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: values.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      values[index]['icon'] as IconData,
                      color: primaryRed, // Changed to red
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      values[index]['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      values[index]['description'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCertifications() {
    final certifications = [
      {'name': 'ISO 9001:2015', 'icon': Icons.verified, 'desc': 'Quality Management'},
      {'name': 'Dubai Chamber', 'icon': Icons.business, 'desc': 'Certified Member'},
      {'name': 'Made in UAE', 'icon': Icons.flag, 'desc': 'Local Partner'},
      {'name': 'Authorized', 'icon': Icons.security, 'desc': 'Brand Distributor'},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryRed, // Changed to red
            darkRed, // Dark red
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Certifications & Accreditations',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: certifications.map((cert) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      cert['icon'] as IconData,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cert['name'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    cert['desc'] as String,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnersSection() {
    final partners = [
      'Bosch', 'Makita', 'DeWalt', 'Hilti', 'Milwaukee', 'Stanley'
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Our Trusted Partners',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryRed, // Changed to red
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: partners.map((partner) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: darkRed, // Changed to light red
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  partner,
                  style: TextStyle(
                    color: white, // Changed to red
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    final reasons = [
      {
        'icon': Icons.inventory,
        'title': 'Massive Inventory',
        'desc': 'Over 1000+ products in stock ready for bulk orders',
      },
      {
        'icon': Icons.local_shipping,
        'title': 'UAE-Wide Delivery',
        'desc': 'Free delivery to all 7 emirates for bulk orders',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Expert Support',
        'desc': 'Technical team to help with product selection',
      },
      {
        'icon': Icons.verified,
        'title': 'Genuine Products',
        'desc': '100% authentic with manufacturer warranty',
      },
      {
        'icon': Icons.attach_money,
        'title': 'Bulk Pricing',
        'desc': 'Competitive wholesale rates for volume purchases',
      },
      {
        'icon': Icons.speed,
        'title': 'Quick Response',
        'desc': 'Quotes within 24 hours for bulk inquiries',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Businesses Choose Us',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryRed, // Changed to red
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.7,
            ),
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      reasons[index]['icon'] as IconData,
                      color: primaryRed, // Changed to red
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reasons[index]['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reasons[index]['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryRed, // Changed to red
            darkRed, // Dark red
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Partner with Us?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Join hundreds of satisfied businesses across UAE',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUsScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  foregroundColor: primaryRed, // Changed to red
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Contact Us'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductScreen()));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('View Products'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}