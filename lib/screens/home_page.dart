import 'package:flutter/material.dart';
import 'package:optimus_power_tools_trading/screens/about/about_us_screen.dart';
import 'package:optimus_power_tools_trading/screens/contact/contact_us_screen.dart';
import 'package:optimus_power_tools_trading/screens/products/product_screen.dart';
import 'package:optimus_power_tools_trading/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  // New color scheme
  final Color primaryRed = const Color(0xFFD32F2F);
  final Color darkRed = const Color(0xFFB71C1C);
  final Color lightRed = const Color(0xFFFFCDD2);
  final Color primaryGreen = const Color(0xFF2E7D32);
  final Color lightGreen = const Color(0xFFC8E6C9);
  final Color black = const Color(0xFF212121);
  final Color white = Colors.white;
  final Color grey = Colors.grey.shade700;
  
  // WhatsApp color
  final Color whatsappGreen = const Color(0xFF25D366);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
      });
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // WhatsApp launch function
  Future<void> _launchWhatsApp() async {
    final phoneNumber = '+971501234567'; // Your WhatsApp business number
    final message = 'Hello, I am interested in your power tools. Can you provide me with more information about bulk orders?';
    
    // Remove any non-digit characters from phone number
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // URL encoding for the message
    final encodedMessage = Uri.encodeComponent(message);
    
    // Try WhatsApp URL schemes
    final whatsappUrl = 'whatsapp://send?phone=$cleanNumber&text=$encodedMessage';
    final whatsappWebUrl = 'https://wa.me/$cleanNumber?text=$encodedMessage';
    
    try {
      // Try to open WhatsApp app
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } 
      // Fallback to web version if app is not installed
      else if (await canLaunchUrl(Uri.parse(whatsappWebUrl))) {
        await launchUrl(Uri.parse(whatsappWebUrl));
      } 
      // If both fail, show error
      else {
        _showWhatsAppError();
      }
    } catch (e) {
      _showWhatsAppError();
    }
  }

  void _showWhatsAppError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Could not open WhatsApp. Please check if WhatsApp is installed.'),
        backgroundColor: primaryRed,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: white),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: context.isMobile ? 100 : 120,
              floating: false,
              pinned: true,
              backgroundColor: _isScrolled ? primaryRed : Colors.transparent,
              elevation: _isScrolled ? 4 : 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: [
                    Icon(
                      Icons.power,
                      color: _isScrolled ? white : primaryRed,
                      size: context.isMobile ? 20 : 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.isMobile ? 'Optimus' : 'Optimus Power Tools',
                      style: TextStyle(
                        color: _isScrolled ? white : primaryRed,
                        fontSize: context.isMobile ? 16 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [lightRed, white],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: _isScrolled ? white : primaryRed,
                    size: context.isMobile ? 20 : 24,
                  ),
                  onPressed: _launchPhone,
                ),
                IconButton(
                  icon: Icon(
                    Icons.email,
                    color: _isScrolled ? white : primaryRed,
                    size: context.isMobile ? 20 : 24,
                  ),
                  onPressed: _launchEmail,
                ),
                SizedBox(width: context.isMobile ? 8 : 16),
              ],
            ),

            // Main Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(context.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section
                    _buildHeroSection(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Company Introduction
                    _buildCompanyIntro(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Products Title
                    Text(
                      'Our Power Tools Collection',
                      style: TextStyle(
                        fontSize: context.headingFontSize,
                        fontWeight: FontWeight.bold,
                        color: primaryRed,
                      ),
                    ),
                    SizedBox(height: context.spacingSmall),
                    Text(
                      'Premium quality tools for bulk orders in UAE',
                      style: TextStyle(
                        fontSize: context.bodyFontSize,
                        color: grey,
                      ),
                    ),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Products Grid
                    _buildProductsGrid(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Why Choose Us
                    _buildWhyChooseUs(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Bulk Order CTA
                    _buildBulkOrderCTA(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Contact Form
                    _buildContactForm(),
                    
                    SizedBox(height: context.spacingLarge),
                    
                    // Footer
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
     floatingActionButton: FloatingActionButton(
    onPressed: _launchWhatsApp,
    backgroundColor: white,
    child: CircleAvatar(
      backgroundImage: AssetImage('images/whatsapp.png'),
    )
  ),
      
      // Position FAB to avoid overlapping with content
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Alternative: If you prefer a simple circular FAB without text
  /*
  floatingActionButton: FloatingActionButton(
    onPressed: _launchWhatsApp,
    backgroundColor: whatsappGreen,
    child: const Icon(
      Icons.chat,
      color: Colors.white,
    ),
  ),
  */

  Widget _buildHeroSection() {
    return Container(
      height: context.heroHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('images/makita_drill.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.spacingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.isMobile
                      ? 'OPTIMUS POWER\nTOOLS TRADING'
                      : 'OPTIMUS POWER TOOLS TRADING',
                  style: TextStyle(
                    fontSize: context.isMobile ? 24 : 36,
                    fontWeight: FontWeight.bold,
                    color: white,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.spacingMedium),
                Text(
                  'Your Trusted Partner for Bulk Power Tool Supply in UAE',
                  style: TextStyle(
                    fontSize: context.isMobile ? 14 : 18,
                    color: white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.spacingLarge),
                ElevatedButton(
                  onPressed: _scrollToContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    foregroundColor: white,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 30 : 40,
                      vertical: context.isMobile ? 12 : 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Request Bulk Quote',
                    style: TextStyle(
                      fontSize: context.isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ... (rest of your existing methods remain the same)
  
  Widget _buildCompanyIntro() {
    return Container(
      padding: EdgeInsets.all(context.spacingLarge),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryRed.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: context.isMobile
          ? Column(
              children: [
                _buildCompanyIntroText(),
                SizedBox(height: context.spacingLarge),
                _buildCompanyIntroImage(),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 2, child: _buildCompanyIntroText()),
                SizedBox(width: context.spacingLarge),
                Expanded(child: _buildCompanyIntroImage()),
              ],
            ),
    );
  }

  Widget _buildCompanyIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Optimus Power Tools',
          style: TextStyle(
            fontSize: context.isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
            color: primaryRed,
          ),
        ),
        SizedBox(height: context.spacingMedium),
        Text(
          'With over 15 years of experience in the UAE power tool market, '
          'we specialize in bulk supply of premium power tools to contractors, '
          'construction companies, and retailers across all Emirates.',
          style: TextStyle(
            fontSize: context.bodyFontSize,
            color: grey,
            height: 1.6,
          ),
        ),
        SizedBox(height: context.spacingMedium),
        Text(
          '• Direct manufacturer partnerships\n'
          '• Competitive bulk pricing\n'
          '• Fast delivery across UAE\n'
          '• Genuine products with warranty',
          style: TextStyle(
            fontSize: context.isMobile ? 14 : 15,
            color: grey,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyIntroImage() {
    return Container(
      height: context.isMobile ? 150 : 200,
      decoration: BoxDecoration(
        color: lightRed,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('images/warehouse.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Angle Grinders - Bosch',
        'icon': Icons.build_circle,
        'description': 'Heavy-duty angle grinders for cutting and grinding',
        'variants': '4" to 9" available | 850W - 2400W',
        'image': 'images/bosch_grinder.jpeg',
      },
      {
        'name': 'Electric Drill Machines - Makita',
        'icon': Icons.settings_input_component,
        'description': 'Professional grade drilling solutions',
        'variants': 'Hammer drills, impact drills, magnetic drills',
        'image': 'images/makita_drill.jpeg',
      },
      {
        'name': 'Cordless Screw Fasteners - Makita',
        'icon': Icons.settings,
        'description': 'High-torque cordless screwdrivers and impact wrenches',
        'variants': '12V to 36V | Various chuck sizes',
        'image': 'images/makita_thiter.jpeg'
      },
      {
        'name': 'Cutting Discs - Stanley',
        'icon': Icons.content_cut,
        'description': 'Precision cutting tools for wood and metal',
        'variants': '7-1/4" to 16" blade sizes',
        'image': 'images/stanley_disc.jpeg'
      },
      {
        'name': 'Cutting Discs - DeWalt',
        'icon': Icons.content_cut,
        'description': 'Precision cutting tools for wood and metal',
        'variants': '7-1/4" to 16" blade sizes',
        'image': 'images/dewalt_disc.jpeg'
      },
      {
        'name': 'Cutting Discs - Bosch',
        'icon': Icons.content_cut,
        'description': 'Precision cutting tools for wood and metal',
        'variants': '7-1/4" to 16" blade sizes',
        'image': 'images/bosch_disc.jpeg'
      },
      {
        'name': 'Angle Grinders - DeWalt',
        'icon': Icons.build_circle,
        'description': 'Heavy-duty angle grinders for cutting and grinding',
        'variants': '4" to 9" available | 850W - 2400W',
        'image': 'images/dewalt_grinder.jpeg',
      },
      {
        'name': 'Cordless Screw Fasteners - Bosch',
        'icon': Icons.settings,
        'description': 'High-torque cordless screwdrivers and impact wrenches',
        'variants': '12V to 36V | Various chuck sizes',
        'image': 'images/bosch_thiter.jpeg'
      },
      {
        'name': 'Angle Grinders - Makita',
        'icon': Icons.build_circle,
        'description': 'Heavy-duty angle grinders for cutting and grinding',
        'variants': '4" to 9" available | 850W - 2400W',
        'image': 'images/makita_grinder.jpeg',
      },
      {
        'name': 'Cordless Screw Fasteners - Stanley',
        'icon': Icons.settings,
        'description': 'High-torque cordless screwdrivers and impact wrenches',
        'variants': '12V to 36V | Various chuck sizes',
        'image': 'images/stanley_thiter.jpeg'
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.gridColumnCount,
        crossAxisSpacing: context.isMobile ? 12 : 16,
        mainAxisSpacing: context.isMobile ? 12 : 16,
        childAspectRatio: context.isMobile ? 1.0 : 1.09,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(
          product['name'] as String,
          product['icon'] as IconData,
          product['description'] as String,
          product['variants'] as String,
          product['image'] as String,
        );
      },
    );
  }

  Widget _buildProductCard(String name, IconData icon, String description, 
      String variants, String imagePath) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: context.productImageHeight,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: context.productImageHeight,
                  color: lightRed,
                  child: Center(
                    child: Icon(icon, size: 40, color: primaryRed),
                  ),
                );
              },
            ),
          ),
          
          // Product Details
          Padding(
            padding: EdgeInsets.all(context.isMobile ? 8.0 : 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: context.isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.spacingSmall),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: context.smallFontSize,
                    color: grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.spacingSmall),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    variants,
                    style: TextStyle(
                      fontSize: context.isMobile ? 8 : 10,
                      color: primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: context.spacingSmall),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _showQuoteDialog(name),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: white,
                      minimumSize: Size(context.isMobile ? 100 : 120, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Get Quote',
                      style: TextStyle(fontSize: context.smallFontSize),
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

  Widget _buildWhyChooseUs() {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.verified,
        'title': 'Genuine Products',
        'description': '100% authentic tools with manufacturer warranty',
      },
      {
        'icon': Icons.local_shipping,
        'title': 'Fast Delivery',
        'description': 'Free delivery across all 7 Emirates',
      },
      {
        'icon': Icons.attach_money,
        'title': 'Best Bulk Prices',
        'description': 'Competitive wholesale pricing for volume orders',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Expert Support',
        'description': 'Technical support and after-sales service',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why Choose Optimus Power Tools?',
          style: TextStyle(
            fontSize: context.headingFontSize,
            fontWeight: FontWeight.bold,
            color: primaryRed,
          ),
        ),
        SizedBox(height: context.spacingLarge),
        Wrap(
          spacing: context.spacingMedium,
          runSpacing: context.spacingMedium,
          children: features.map((feature) {
            return Container(
              width: context.isMobile 
                  ? double.infinity 
                  : (context.width - (context.spacingMedium * 5)) / 4,
              padding: EdgeInsets.all(context.spacingMedium),
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
                  Icon(
                    feature['icon'] as IconData,
                    size: context.isMobile ? 40 : 48,
                    color: primaryRed,
                  ),
                  SizedBox(height: context.spacingSmall),
                  Text(
                    feature['title'] as String,
                    style: TextStyle(
                      fontSize: context.isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.spacingSmall),
                  Text(
                    feature['description'] as String,
                    style: TextStyle(
                      fontSize: context.smallFontSize,
                      color: grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBulkOrderCTA() {
    return Container(
      padding: EdgeInsets.all(context.spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryRed, darkRed],
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
      child: context.isMobile
          ? Column(
              children: [
                _buildCTAText(),
                SizedBox(height: context.spacingLarge),
                _buildCTAButton(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildCTAText()),
                SizedBox(width: context.spacingLarge),
                _buildCTAButton(),
              ],
            ),
    );
  }

  Widget _buildCTAText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Need Tools in Bulk?',
          style: TextStyle(
            fontSize: context.isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        SizedBox(height: context.spacingSmall),
        Text(
          'Get competitive quotes for large orders. '
          'We supply to construction companies, contractors, '
          'and retailers across UAE.',
          style: TextStyle(
            fontSize: context.bodyFontSize,
            color: white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildCTAButton() {
    return ElevatedButton(
      onPressed: _scrollToContact,
      style: ElevatedButton.styleFrom(
        backgroundColor: white,
        foregroundColor: primaryRed,
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 30 : 40,
          vertical: context.isMobile ? 16 : 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'Request Bulk Quote',
        style: TextStyle(
          fontSize: context.isMobile ? 16 : 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController companyController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(context.spacingLarge),
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
          Text(
            'Request a Bulk Quote',
            style: TextStyle(
              fontSize: context.headingFontSize,
              fontWeight: FontWeight.bold,
              color: primaryRed,
            ),
          ),
          SizedBox(height: context.spacingSmall),
          Text(
            'Fill in your details and our team will get back to you within 24 hours',
            style: TextStyle(
              fontSize: context.bodyFontSize,
              color: grey,
            ),
          ),
          SizedBox(height: context.spacingLarge),
          Form(
            key: formKey,
            child: Column(
              children: [
                // Name and Company row
                context.isMobile
                    ? Column(
                        children: [
                          _buildNameField(nameController),
                          SizedBox(height: context.spacingMedium),
                          _buildCompanyField(companyController),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildNameField(nameController)),
                          SizedBox(width: context.spacingMedium),
                          Expanded(child: _buildCompanyField(companyController)),
                        ],
                      ),
                
                SizedBox(height: context.spacingMedium),
                
                // Email and Phone row
                context.isMobile
                    ? Column(
                        children: [
                          _buildEmailField(emailController),
                          SizedBox(height: context.spacingMedium),
                          _buildPhoneField(phoneController),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildEmailField(emailController)),
                          SizedBox(width: context.spacingMedium),
                          Expanded(child: _buildPhoneField(phoneController)),
                        ],
                      ),
                
                SizedBox(height: context.spacingMedium),
                
                // Product dropdown
                _buildProductDropdown(),
                
                SizedBox(height: context.spacingMedium),
                
                // Message field
                _buildMessageField(messageController),
                
                SizedBox(height: context.spacingLarge),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: context.isMobile ? 48 : 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _showQuoteSuccessDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Submit Quote Request',
                      style: TextStyle(
                        fontSize: context.isMobile ? 16 : 18,
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

  Widget _buildNameField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Full Name *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.person, color: primaryRed, size: context.isMobile ? 20 : 24),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your name';
        return null;
      },
    );
  }

  Widget _buildCompanyField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Company Name *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.business, color: primaryRed, size: context.isMobile ? 20 : 24),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter company name';
        return null;
      },
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Email Address *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.email, color: primaryRed, size: context.isMobile ? 20 : 24),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter email';
        if (!value.contains('@')) return 'Invalid email';
        return null;
      },
    );
  }

  Widget _buildPhoneField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Phone Number *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.phone, color: primaryRed, size: context.isMobile ? 20 : 24),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter phone';
        return null;
      },
    );
  }

  Widget _buildProductDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Interested Products *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.category, color: primaryRed, size: context.isMobile ? 20 : 24),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      items: const [
        'Angle Grinders - Bosch',
        'Angle Grinders - DeWalt',
        'Angle Grinders - Makita',
        'Electric Drill Machines - Makita',
        'Cordless Screw Fasteners - Makita',
        'Cordless Screw Fasteners - Bosch',
        'Cordless Screw Fasteners - Stanley',
        'Cutting Discs - Stanley',
        'Cutting Discs - DeWalt',
        'Cutting Discs - Bosch',
        'Multiple Products',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: context.bodyFontSize)),
        );
      }).toList(),
      onChanged: (String? value) {},
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please select product';
        return null;
      },
    );
  }

  Widget _buildMessageField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: context.isMobile ? 3 : 4,
      decoration: InputDecoration(
        labelText: 'Quantity & Requirements *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: context.isMobile ? 40 : 60),
          child: Icon(Icons.message, color: primaryRed, size: context.isMobile ? 20 : 24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryRed),
        ),
        labelStyle: TextStyle(fontSize: context.bodyFontSize),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your requirements';
        return null;
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(context.spacingLarge),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          context.isMobile
              ? Column(
                  children: [
                    _buildFooterBrand(),
                    SizedBox(height: context.spacingLarge),
                    _buildFooterLinks(),
                    SizedBox(height: context.spacingLarge),
                    _buildFooterContact(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildFooterBrand()),
                    Expanded(child: _buildFooterLinks()),
                    Expanded(child: _buildFooterContact()),
                  ],
                ),
          SizedBox(height: context.spacingLarge),
          Divider(color: Colors.grey.shade800),
          SizedBox(height: context.spacingMedium),
          Text(
            '© 2024 Optimus Power Tools Trading. All rights reserved.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: context.smallFontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.power, color: primaryRed, size: context.isMobile ? 24 : 28),
            const SizedBox(width: 8),
            Text(
              'Optimus Power Tools',
              style: TextStyle(
                fontSize: context.isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: primaryRed,
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacingMedium),
        Text(
          'Your trusted partner for bulk power tool supply in UAE. '
          'We provide premium quality tools at competitive wholesale prices.',
          style: TextStyle(
            fontSize: context.smallFontSize,
            color: Colors.grey.shade400,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontSize: context.isMobile ? 14 : 16,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        SizedBox(height: context.spacingSmall),
        _buildFooterLink('Home', _scrollToTop),
        _buildFooterLink('Products', () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const ProductScreen()));
        }),
        _buildFooterLink('About Us', () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) =>  AboutUsScreen()));
        }),
        _buildFooterLink('Contact', () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) =>  ContactUsScreen()));
        }),
      ],
    );
  }

  Widget _buildFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: TextStyle(
            fontSize: context.isMobile ? 14 : 16,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        SizedBox(height: context.spacingSmall),
        _buildContactInfo(Icons.location_on, 'Dubai, UAE'),
        _buildContactInfo(Icons.phone, '+971 50 123 4567'),
        _buildContactInfo(Icons.email, 'info@optimustools.ae'),
        _buildContactInfo(Icons.access_time, 'Sat-Thu: 8AM - 8PM'),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacingSmall / 2),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: context.smallFontSize,
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacingSmall / 2),
      child: Row(
        children: [
          Icon(icon, size: context.isMobile ? 14 : 16, color: primaryRed),
          SizedBox(width: context.spacingSmall / 2),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: context.smallFontSize,
            ),
          ),
        ],
      ),
    );
  }

  void _showQuoteDialog(String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Request Quote for $productName'),
        content: const Text(
          'Please fill out the contact form below or contact us directly for a bulk quote.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: primaryRed)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _scrollToContact();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: white,
            ),
            child: const Text('Request Quote'),
          ),
        ],
      ),
    );
  }

  void _showQuoteSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Quote Request Submitted'),
        content: const Text(
          'Thank you for your interest. Our team will contact you within 24 hours with a customized quote for your bulk order.'
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _scrollToContact() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+971501234567');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@optimustools.ae',
      query: 'subject=Bulk Quote Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}