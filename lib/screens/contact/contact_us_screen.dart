import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});

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
        title: const Text('Contact Us'),
        backgroundColor: primaryRed, // Changed to red
        foregroundColor: white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
         color: white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(),
                
                const SizedBox(height: 32),
                
                // Contact Info Cards
                _buildContactInfoCards(context),
                
                const SizedBox(height: 40),
                
                // Contact Form
                _buildContactForm(context),
                
                const SizedBox(height: 40),
                
                // Map/Location Section
                _buildLocationSection(context),
                
                const SizedBox(height: 40),
                
                // Business Hours
                _buildBusinessHours(),
                
                const SizedBox(height: 40),
                
                // Social Media Links
                _buildSocialMedia(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryRed, // Changed to red
            darkRed, // Dark red
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryRed.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Have questions about bulk orders? Need a customized quote? '
            'Our team is here to help you with all your power tool requirements.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildHeaderStat('24/7', 'Support'),
              Container(
                height: 30,
                width: 1,
                color: Colors.white.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildHeaderStat('15+', 'Years'),
              Container(
                height: 30,
                width: 1,
                color: Colors.white.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildHeaderStat('1000+', 'Clients'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCards(BuildContext context) {
    final List<Map<String, dynamic>> contactInfo = [
      {
        'icon': Icons.phone,
        'title': 'Phone',
        'details': '+971 50 123 4567',
        'secondary': '+971 4 123 4567',
        'action': 'Call Now',
        'color': primaryGreen, // Changed to green
        'url': 'tel:+971501234567',
      },
      {
        'icon': Icons.email,
        'title': 'Email',
        'details': 'info@optimustools.ae',
        'secondary': 'sales@optimustools.ae',
        'action': 'Send Email',
        'color': primaryRed, // Changed to red
        'url': 'mailto:info@optimustools.ae',
      },
      {
        'icon': Icons.chat,
        'title': 'WhatsApp',
        'details': '+971 50 123 4567',
        'secondary': '24/7 Quick Response',
        'action': 'Chat Now',
        'color': primaryGreen, // Changed to green
        'url': 'https://wa.me/971501234567',
      },
    ];

    return Row(
      children: contactInfo.map((info) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (info['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    info['icon'] as IconData,
                    color: info['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  info['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  info['details'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (info['secondary'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    info['secondary'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _launchContact(info['url'] as String),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: info['color'] as Color,
                    foregroundColor: white,
                    minimumSize: const Size(100, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(info['action'] as String),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(32),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lightRed, // Changed to light red
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.message,
                  color: primaryRed, // Changed to red
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send us a Message',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryRed, // Changed to red
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'We\'ll get back to you within 24 hours',
                    style: TextStyle(
                      fontSize: 14,
                      color: grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person, color: primaryRed),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.email, color: primaryRed),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!value.contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.phone, color: primaryRed),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(
                          labelText: 'Subject *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.subject, color: primaryRed),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Inquiry Type *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.category, color: primaryRed),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryRed),
                    ),
                  ),
                  items: const [
                    'Bulk Order Quote',
                    'Product Information',
                    'Technical Support',
                    'Partnership Inquiry',
                    'General Inquiry',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select inquiry type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Your Message *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Icon(Icons.message, color: primaryRed),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryRed),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _showSuccessDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed, // Changed to red
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildLocationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lightRed, // Changed to light red
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_on,
                  color: primaryRed, // Changed to red
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Our Location',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryRed, // Changed to red
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Head Office',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildLocationDetail(
                      Icons.location_on,
                      'Shop #45, Al Quoz Industrial Area 3,\nDubai, UAE',
                    ),
                    const SizedBox(height: 8),
                    _buildLocationDetail(
                      Icons.directions_car,
                      'Easy parking available',
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Branch Offices',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildLocationDetail(
                      Icons.location_on,
                      'Mussafah Industrial Area - Abu Dhabi',
                    ),
                    const SizedBox(height: 4),
                    _buildLocationDetail(
                      Icons.location_on,
                      'Industrial Area 5 - Sharjah',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () => _launchMaps(),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: lightRed, width: 2), // Added border
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://via.placeholder.com/600x400/FFA500/FFFFFF?text=Map+Location',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.map,
                          size: 40,
                          color: primaryRed, // Changed to red
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _launchMaps(),
            icon: const Icon(Icons.directions),
            label: const Text('Get Directions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryRed, // Changed to red
              side: BorderSide(color: primaryRed), // Changed to red
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryRed, // Changed to red
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHours() {
    final List<Map<String, String>> weekdays = [
      {'day': 'Saturday - Thursday', 'hours': '8:00 AM - 8:00 PM'},
      {'day': 'Friday', 'hours': 'Closed'},
      {'day': 'Public Holidays', 'hours': '10:00 AM - 6:00 PM'},
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            lightRed, // Changed to light red
            white,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryRed.withOpacity(0.3), // Changed to red
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: lightRed, // Changed to light red
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time,
              size: 40,
              color: primaryRed, // Changed to red
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Hours',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryRed, // Changed to red
                  ),
                ),
                const SizedBox(height: 16),
                ...weekdays.map((schedule) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          schedule['day']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          schedule['hours']!,
                          style: TextStyle(
                            color: schedule['hours'] == 'Closed'
                                ? primaryRed // Changed to red for closed
                                : primaryGreen, // Changed to green for open
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia(BuildContext context) {
    final List<Map<String, dynamic>> socialMedia = [
      {
        'icon': Icons.facebook,
        'name': 'Facebook',
        'color': Colors.blue.shade800,
        'url': 'https://facebook.com/optimustools',
      },
      {
        'icon': Icons.camera_alt,
        'name': 'Instagram',
        'color': Colors.purple,
        'url': 'https://instagram.com/optimustools',
      },
      {
        'icon': Icons.business,
        'name': 'LinkedIn',
        'color': Colors.blue.shade600,
        'url': 'https://linkedin.com/company/optimustools',
      },
      {
        'icon': Icons.play_circle,
        'name': 'YouTube',
        'color': primaryRed, // Changed to red
        'url': 'https://youtube.com/optimustools',
      },
    ];

    return Container(
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
      child: Column(
        children: [
          Text(
            'Follow Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryRed, // Changed to red
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialMedia.map((platform) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () => _launchSocialMedia(platform['url'] as String),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (platform['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      platform['icon'] as IconData,
                      color: platform['color'] as Color,
                      size: 24,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.check_circle, color: primaryGreen, size: 50), // Changed to green
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Message Sent!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Thank you for contacting us. Our team will respond to your inquiry within 24 hours.'
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: primaryRed)), // Changed to red
          ),
        ],
      ),
    );
  }

  void _launchContact(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchMaps() async {
    final Uri mapUri = Uri.parse('https://maps.google.com/?q=Al+Quoz+Dubai');
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    }
  }

  void _launchSocialMedia(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}