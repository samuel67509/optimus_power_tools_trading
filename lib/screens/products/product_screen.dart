import 'package:flutter/material.dart';
import 'package:optimus_power_tools_trading/utils/responsive.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  // New color scheme
  final Color primaryRed = const Color(0xFFD32F2F);
  final Color darkRed = const Color(0xFFB71C1C);
  final Color lightRed = const Color(0xFFFFCDD2);
  final Color primaryGreen = const Color(0xFF2E7D32);
  final Color lightGreen = const Color(0xFFC8E6C9);
  final Color black = const Color(0xFF212121);
  final Color white = Colors.white;
  final Color grey = Colors.grey.shade700;
  
  final List<String> _categories = [
    'All',
    'Grinders',
    'Drills',
    'Screw Fasteners',
    'Saws',
    'Hammers',
    'Compressors',
    'Generators',
  ];

  // Map of product images
  final Map<String, String> _productImages = {
    // Grinders
    'Heavy Duty Angle Grinder': 'images/bosch_grinder.jpeg',
    'Professional Angle Grinder': 'images/makita_grinder.jpeg',
    'Die Grinder': 'images/dewalt_grinder.jpeg',
    'Battery Angle Grinder': 'images/makita_grinder.jpeg',
    
    // Drills
    'SDS-Plus Rotary Hammer': 'images/makita_drill.jpeg',
    'Impact Drill': 'images/bosch_grinder.jpeg',
    'Magnetic Drill': 'images/makita_drill.jpeg',
    'Cordless Hammer Drill': 'images/makita_drill.jpeg',
    
    // Screw Fasteners
    'Cordless Impact Driver': 'images/makita_thiter.jpeg',
    'Drywall Screwgun': 'images/bosch_thiter.jpeg',
    'Industrial Screwdriver': 'images/stanley_thiter.jpeg',
    'Right Angle Drill': 'images/makita_thiter.jpeg',
    
    // Saws
    'Circular Saw': 'images/dewalt_disc.jpeg',
    'Jigsaw': 'images/bosch_disc.jpeg',
    'Mitre Saw': 'images/stanley_disc.jpeg',
    'Reciprocating Saw': 'images/dewalt_disc.jpeg',
    
    // Hammers
    'Demolition Hammer': 'images/bosch_grinder.jpeg',
    'Combi Hammer': 'images/makita_drill.jpeg',
    'Breaker Hammer': 'images/dewalt_grinder.jpeg',
    
    // Compressors
    'Oil-Free Air Compressor': 'images/bosch_grinder.jpeg',
    'Industrial Compressor': 'images/dewalt_grinder.jpeg',
    
    // Generators
    'Diesel Generator': 'images/makita_grinder.jpeg',
    'Petrol Generator': 'images/bosch_grinder.jpeg',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedCategory = _categories[_tabController.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Products',
          style: TextStyle(fontSize: context.headingFontSize),
        ),
        backgroundColor: primaryRed,
        foregroundColor: white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.map((category) => Tab(text: category)).toList(),
          indicatorColor: white,
          labelColor: white,
          unselectedLabelColor: white.withOpacity(0.7),
          labelStyle: TextStyle(fontSize: context.isMobile ? 12 : 14),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            
            // Category Stats
            _buildCategoryStats(),
            
            // Products Grid
            Expanded(
              child: _buildProductsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(context.horizontalPadding),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: context.isMobile 
                    ? 'Search products...' 
                    : 'Search products by name or category...',
                hintStyle: TextStyle(fontSize: context.bodyFontSize),
                prefixIcon: Icon(Icons.search, color: primaryRed, size: context.isMobile ? 20 : 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.isMobile ? 12 : 16,
                  horizontal: 16,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryRed),
                ),
              ),
            ),
          ),
          SizedBox(width: context.spacingSmall),
          Container(
            decoration: BoxDecoration(
              color: lightRed,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.filter_list, 
                color: primaryRed,
                size: context.isMobile ? 20 : 24,
              ),
              onPressed: () => _showFilterDialog(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStats() {
    final productCounts = _getProductCounts();
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.horizontalPadding, 
        vertical: context.spacingSmall,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: productCounts.entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = entry.key;
                  int index = _categories.indexOf(entry.key);
                  if (index >= 0) {
                    _tabController.animateTo(index);
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: context.spacingSmall),
                padding: EdgeInsets.symmetric(
                  horizontal: context.isMobile ? 12 : 16, 
                  vertical: context.isMobile ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  color: entry.key == _selectedCategory 
                      ? primaryRed
                      : white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: entry.key == _selectedCategory 
                        ? primaryRed
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  '${entry.key} (${entry.value})',
                  style: TextStyle(
                    color: entry.key == _selectedCategory 
                        ? white 
                        : grey,
                    fontWeight: FontWeight.w500,
                    fontSize: context.smallFontSize,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<String, int> _getProductCounts() {
    return {
      'All': 24,
      'Grinders': 4,
      'Drills': 4,
      'Screw Fasteners': 4,
      'Saws': 4,
      'Hammers': 3,
      'Compressors': 2,
      'Generators': 2,
    };
  }

  Widget _buildProductsGrid() {
    final products = _getFilteredProducts();
    
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: context.isMobile ? 60 : 80,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: context.spacingMedium),
              Text(
                'No products found',
                style: TextStyle(
                  fontSize: context.subheadingFontSize,
                  color: grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: context.spacingSmall),
              Text(
                'Try adjusting your search or filter',
                style: TextStyle(
                  fontSize: context.bodyFontSize,
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.spacingLarge),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _selectedCategory = 'All';
                    _searchController.clear();
                    _tabController.animateTo(0);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: white,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 20 : 24,
                    vertical: context.isMobile ? 10 : 12,
                  ),
                ),
                child: Text(
                  'Clear Filters',
                  style: TextStyle(fontSize: context.bodyFontSize),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(context.horizontalPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.isMobile ? 1 : (context.isTablet ? 2 : 4),
        childAspectRatio: context.isMobile ? 1.2 : 1,
        crossAxisSpacing: context.spacingMedium,
        mainAxisSpacing: context.spacingMedium,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    String imagePath = _productImages[product['name']] ?? 'images/placeholder.jpg';
    
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
          // Product Image Section
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: context.productImageHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to icon if image fails to load
                      return Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Icon(
                            product['icon'] as IconData,
                            size: context.isMobile ? 40 : 60,
                            color: primaryRed.withOpacity(0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (product['isNew'] == true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.isMobile ? 6 : 8,
                        vertical: context.isMobile ? 2 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.isMobile ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (product['isPopular'] == true)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(context.isMobile ? 3 : 4),
                      decoration: BoxDecoration(
                        color: primaryRed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: context.isMobile ? 10 : 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Product Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(context.isMobile ? 8 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] as String,
                    style: TextStyle(
                      fontSize: context.isMobile ? 13 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.spacingSmall / 2),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 4 : 6, 
                      vertical: context.isMobile ? 1 : 2,
                    ),
                    decoration: BoxDecoration(
                      color: lightRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product['category'] as String,
                      style: TextStyle(
                        fontSize: context.isMobile ? 9 : 10,
                        color: primaryRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: context.spacingSmall),
                  _buildSpecRow(Icons.speed, product['power'] as String),
                  SizedBox(height: context.spacingSmall / 2),
                  _buildSpecRow(Icons.build, product['variants'] as String),
                  SizedBox(height: context.spacingSmall / 2),
                  _buildSpecRow(Icons.description, product['specs'] as String, maxLines: 1),
                  
                  const Spacer(),
                  
                  // Quote Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showQuoteDialog(product),
                      icon: Icon(
                        Icons.request_quote, 
                        size: context.isMobile ? 12 : 14,
                      ),
                      label: Text(
                        context.isMobile ? 'Quote' : 'Request Bulk Quote',
                        style: TextStyle(
                          fontSize: context.isMobile ? 10 : 11,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: white,
                        minimumSize: Size(double.infinity, context.isMobile ? 28 : 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.isMobile ? 2 : 4,
                          vertical: context.isMobile ? 2 : 4,
                        ),
                      ),
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

  Widget _buildSpecRow(IconData icon, String text, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: context.isMobile ? 10 : 12,
          color: grey,
        ),
        SizedBox(width: context.spacingSmall / 2),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: context.isMobile ? 9 : 10,
              color: grey,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    final List<Map<String, dynamic>> allProducts = [
      // Grinders
      {
        'name': 'Heavy Duty Angle Grinder',
        'category': 'Grinders',
        'icon': Icons.build_circle,
        'power': '2400W | 8500 RPM',
        'variants': '7" & 9" discs',
        'isPopular': true,
        'isNew': false,
        'specs': 'Variable speed, Anti-vibration, Safety guard',
        'applications': 'Metal cutting, Grinding, Polishing',
        'warranty': '1 year',
      },
      {
        'name': 'Professional Angle Grinder',
        'category': 'Grinders',
        'icon': Icons.build_circle,
        'power': '1800W | 11000 RPM',
        'variants': '4.5" & 5" discs',
        'isPopular': false,
        'isNew': true,
        'specs': 'Safety clutch, Soft start, Anti-restart',
        'applications': 'Fabrication, Construction',
        'warranty': '2 years',
      },
      {
        'name': 'Die Grinder',
        'category': 'Grinders',
        'icon': Icons.build_circle,
        'power': '650W | 25000 RPM',
        'variants': '1/4" & 6mm collets',
        'isPopular': false,
        'isNew': false,
        'specs': 'Compact design, Variable speed',
        'applications': 'Precision grinding, Deburring',
        'warranty': '1 year',
      },
      {
        'name': 'Battery Angle Grinder',
        'category': 'Grinders',
        'icon': Icons.build_circle,
        'power': '18V | Brushless',
        'variants': '4.5" disc',
        'isPopular': true,
        'isNew': true,
        'specs': 'Cordless, Quick brake, 2 batteries included',
        'applications': 'Remote sites, Quick jobs',
        'warranty': '2 years',
      },
      
      // Drills
      {
        'name': 'SDS-Plus Rotary Hammer',
        'category': 'Drills',
        'icon': Icons.settings_input_component,
        'power': '1500W | 4.5J',
        'variants': 'SDS-Plus chuck',
        'isPopular': true,
        'isNew': false,
        'specs': '3-mode: Hammer only, Rotation, Hammer+Rotation',
        'applications': 'Concrete drilling, Chiseling',
        'warranty': '2 years',
      },
      {
        'name': 'Impact Drill',
        'category': 'Drills',
        'icon': Icons.settings_input_component,
        'power': '1000W | 0-3000 RPM',
        'variants': '13mm keyless chuck',
        'isPopular': false,
        'isNew': false,
        'specs': 'Variable speed, Forward/reverse',
        'applications': 'Wood, Metal, Masonry',
        'warranty': '1 year',
      },
      {
        'name': 'Magnetic Drill',
        'category': 'Drills',
        'icon': Icons.settings_input_component,
        'power': '1200W | 450 RPM',
        'variants': 'Up to 50mm diameter',
        'isPopular': false,
        'isNew': true,
        'specs': '12000N magnet force, Coolant system',
        'applications': 'Structural steel, Heavy fabrication',
        'warranty': '2 years',
      },
      {
        'name': 'Cordless Hammer Drill',
        'category': 'Drills',
        'icon': Icons.settings_input_component,
        'power': '18V | Brushless',
        'variants': '13mm chuck',
        'isPopular': true,
        'isNew': true,
        'specs': '2-speed gearbox, LED light',
        'applications': 'General construction',
        'warranty': '2 years',
      },
      
      // Screw Fasteners
      {
        'name': 'Cordless Impact Driver',
        'category': 'Screw Fasteners',
        'icon': Icons.settings,
        'power': '18V | 180Nm',
        'variants': '1/4" hex quick-release',
        'isPopular': true,
        'isNew': false,
        'specs': 'Brushless motor, Variable speed',
        'applications': 'Screwing, Nut running',
        'warranty': '2 years',
      },
      {
        'name': 'Drywall Screwgun',
        'category': 'Screw Fasteners',
        'icon': Icons.settings,
        'power': '800W | 4000 RPM',
        'variants': 'Auto-feed magazine',
        'isPopular': false,
        'isNew': false,
        'specs': 'Depth adjustment, Quick release',
        'applications': 'Drywall installation',
        'warranty': '1 year',
      },
      {
        'name': 'Industrial Screwdriver',
        'category': 'Screw Fasteners',
        'icon': Icons.settings,
        'power': '1000W | 2000 RPM',
        'variants': '1/4" hex',
        'isPopular': false,
        'isNew': true,
        'specs': 'Torque control, Ergonomic grip',
        'applications': 'Assembly lines',
        'warranty': '2 years',
      },
      {
        'name': 'Right Angle Drill',
        'category': 'Screw Fasteners',
        'icon': Icons.settings,
        'power': '500W | 1200 RPM',
        'variants': '10mm chuck',
        'isPopular': false,
        'isNew': false,
        'specs': 'Compact head, Variable speed',
        'applications': 'Tight spaces, Cabinet work',
        'warranty': '1 year',
      },
      
      // Saws
      {
        'name': 'Circular Saw',
        'category': 'Saws',
        'icon': Icons.content_cut,
        'power': '1800W | 5500 RPM',
        'variants': '7-1/4" blade',
        'isPopular': true,
        'isNew': false,
        'specs': 'Laser guide, 0-50° bevel',
        'applications': 'Wood cutting, Framing',
        'warranty': '1 year',
      },
      {
        'name': 'Jigsaw',
        'category': 'Saws',
        'icon': Icons.construction,
        'power': '720W | 3000 SPM',
        'variants': '4-stage orbital',
        'isPopular': false,
        'isNew': true,
        'specs': 'Tool-less blade change, Dust blower',
        'applications': 'Curved cuts, Patterns',
        'warranty': '2 years',
      },
      {
        'name': 'Mitre Saw',
        'category': 'Saws',
        'icon': Icons.content_cut,
        'power': '1500W | 4500 RPM',
        'variants': '10" blade',
        'isPopular': true,
        'isNew': false,
        'specs': 'Dual bevel, Laser guide',
        'applications': 'Trim work, Framing',
        'warranty': '2 years',
      },
      {
        'name': 'Reciprocating Saw',
        'category': 'Saws',
        'icon': Icons.construction,
        'power': '1200W | 3000 SPM',
        'variants': '1" stroke',
        'isPopular': false,
        'isNew': false,
        'specs': 'Variable speed, Tool-less blade change',
        'applications': 'Demolition, Plumbing',
        'warranty': '1 year',
      },
      
      // Hammers
      {
        'name': 'Demolition Hammer',
        'category': 'Hammers',
        'icon': Icons.build,
        'power': '1700W | 45J',
        'variants': '11kg class',
        'isPopular': true,
        'isNew': false,
        'specs': 'Hex shank, Anti-vibration',
        'applications': 'Heavy demolition, Concrete breaking',
        'warranty': '2 years',
      },
      {
        'name': 'Combi Hammer',
        'category': 'Hammers',
        'icon': Icons.build,
        'power': '950W | 3.2J',
        'variants': 'SDS-Plus',
        'isPopular': false,
        'isNew': false,
        'specs': '3 functions, Safety clutch',
        'applications': 'Drilling, Light chiseling',
        'warranty': '1 year',
      },
      {
        'name': 'Breaker Hammer',
        'category': 'Hammers',
        'icon': Icons.build,
        'power': '2200W | 65J',
        'variants': '30kg class',
        'isPopular': false,
        'isNew': true,
        'specs': 'Hex shank, Low vibration',
        'applications': 'Heavy construction',
        'warranty': '2 years',
      },
      
      // Compressors
      {
        'name': 'Oil-Free Air Compressor',
        'category': 'Compressors',
        'icon': Icons.air,
        'power': '3HP | 240L/min',
        'variants': '50L tank',
        'isPopular': true,
        'isNew': false,
        'specs': 'Oil-free, Portable, 8 bar',
        'applications': 'Nail guns, Painting, Inflation',
        'warranty': '1 year',
      },
      {
        'name': 'Industrial Compressor',
        'category': 'Compressors',
        'icon': Icons.air,
        'power': '7.5HP | 1000L/min',
        'variants': '200L tank',
        'isPopular': false,
        'isNew': true,
        'specs': 'Belt drive, 12 bar, 3-phase',
        'applications': 'Workshop, Industrial use',
        'warranty': '2 years',
      },
      
      // Generators
      {
        'name': 'Diesel Generator',
        'category': 'Generators',
        'icon': Icons.electrical_services,
        'power': '10kVA | 220V',
        'variants': 'Single phase',
        'isPopular': false,
        'isNew': true,
        'specs': 'Silent type, AVR, Electric start',
        'applications': 'Backup power, Construction sites',
        'warranty': '2 years',
      },
      {
        'name': 'Petrol Generator',
        'category': 'Generators',
        'icon': Icons.electrical_services,
        'power': '5kVA | 220V',
        'variants': 'Portable',
        'isPopular': true,
        'isNew': false,
        'specs': 'Quiet operation, Low oil shutdown',
        'applications': 'Outdoor events, Emergency',
        'warranty': '1 year',
      },
    ];

    // Apply filters
    return allProducts.where((product) {
      if (_selectedCategory != 'All' && product['category'] != _selectedCategory) {
        return false;
      }
      
      if (_searchQuery.isNotEmpty) {
        final name = (product['name'] as String).toLowerCase();
        final category = (product['category'] as String).toLowerCase();
        final specs = (product['specs'] as String).toLowerCase();
        final applications = (product['applications'] as String).toLowerCase();
        
        return name.contains(_searchQuery) ||
               category.contains(_searchQuery) ||
               specs.contains(_searchQuery) ||
               applications.contains(_searchQuery);
      }
      
      return true;
    }).toList();
  }

  void _showFilterDialog() {
    String? selectedWarranty;
    String? selectedPower;
    String? selectedApplication;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Filter Products', 
            style: TextStyle(
              color: primaryRed,
              fontSize: context.subheadingFontSize,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Power Range',
                    labelStyle: TextStyle(fontSize: context.bodyFontSize),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryRed),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.spacingSmall,
                      vertical: context.spacingSmall,
                    ),
                  ),
                  items: [
                    'All Powers',
                    'Under 1000W',
                    '1000W - 1500W',
                    '1500W - 2000W',
                    '2000W+',
                  ].map((power) {
                    return DropdownMenuItem(
                      value: power,
                      child: Text(
                        power,
                        style: TextStyle(fontSize: context.bodyFontSize),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => selectedPower = value,
                ),
                SizedBox(height: context.spacingMedium),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Warranty',
                    labelStyle: TextStyle(fontSize: context.bodyFontSize),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryRed),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.spacingSmall,
                      vertical: context.spacingSmall,
                    ),
                  ),
                  items: [
                    'Any Warranty',
                    '1 Year',
                    '2 Years',
                    '3 Years+',
                  ].map((warranty) {
                    return DropdownMenuItem(
                      value: warranty,
                      child: Text(
                        warranty,
                        style: TextStyle(fontSize: context.bodyFontSize),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => selectedWarranty = value,
                ),
                SizedBox(height: context.spacingMedium),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Application',
                    labelStyle: TextStyle(fontSize: context.bodyFontSize),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryRed),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.spacingSmall,
                      vertical: context.spacingSmall,
                    ),
                  ),
                  items: [
                    'All Applications',
                    'Construction',
                    'Woodworking',
                    'Metalworking',
                    'Demolition',
                    'General Purpose',
                  ].map((app) {
                    return DropdownMenuItem(
                      value: app,
                      child: Text(
                        app,
                        style: TextStyle(fontSize: context.bodyFontSize),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => selectedApplication = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel', 
                style: TextStyle(
                  color: primaryRed,
                  fontSize: context.bodyFontSize,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Filters applied',
                      style: TextStyle(fontSize: context.bodyFontSize),
                    ),
                    backgroundColor: primaryGreen,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: white,
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: context.bodyFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showQuoteDialog(Map<String, dynamic> product) {
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    String? selectedUnit = 'Pieces';
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(context.spacingLarge),
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.spacingSmall),
                      decoration: BoxDecoration(
                        color: lightRed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product['icon'] as IconData,
                        color: primaryRed,
                        size: context.isMobile ? 20 : 24,
                      ),
                    ),
                    SizedBox(width: context.spacingSmall),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] as String,
                            style: TextStyle(
                              fontSize: context.isMobile ? 14 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product['category'] as String,
                            style: TextStyle(
                              fontSize: context.smallFontSize,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: context.spacingLarge),
                
                Text(
                  'Request Bulk Quote',
                  style: TextStyle(
                    fontSize: context.isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.spacingMedium),
                
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(fontSize: context.bodyFontSize),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(
                            Icons.numbers, 
                            size: context.isMobile ? 16 : 18, 
                            color: primaryRed,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.spacingSmall,
                            vertical: context.spacingSmall,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacingSmall),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedUnit,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          labelStyle: TextStyle(fontSize: context.bodyFontSize),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.spacingSmall,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryRed),
                          ),
                        ),
                        items: ['Pieces', 'Boxes', 'Sets', 'Pallets']
                            .map((unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(
                                    unit,
                                    style: TextStyle(fontSize: context.bodyFontSize),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) => selectedUnit = value,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacingMedium),
                
                TextFormField(
                  controller: messageController,
                  maxLines: context.isMobile ? 2 : 3,
                  decoration: InputDecoration(
                    labelText: 'Additional Requirements',
                    labelStyle: TextStyle(fontSize: context.bodyFontSize),
                    hintText: 'Tell us your specific needs...',
                    hintStyle: TextStyle(fontSize: context.bodyFontSize),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryRed),
                    ),
                    contentPadding: EdgeInsets.all(context.spacingSmall),
                  ),
                ),
                
                SizedBox(height: context.spacingMedium),
                
                Container(
                  padding: EdgeInsets.all(context.spacingSmall),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: lightRed),
                  ),
                  child: Column(
                    children: [
                      _buildSpecSummary('Power', product['power'] as String),
                      _buildSpecSummary('Variants', product['variants'] as String),
                      _buildSpecSummary('Warranty', product['warranty'] as String),
                    ],
                  ),
                ),
                
                SizedBox(height: context.spacingLarge),
                
                SizedBox(
                  width: double.infinity,
                  height: context.isMobile ? 44 : 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showRequestSubmitted(context, product['name'] as String);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Submit Quote Request',
                      style: TextStyle(
                        fontSize: context.isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpecSummary(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacingSmall / 2),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: context.smallFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: context.smallFontSize,
                color: grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestSubmitted(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(
          Icons.check_circle, 
          color: primaryGreen, 
          size: context.isMobile ? 40 : 50,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quote Request Submitted!',
              style: TextStyle(
                fontSize: context.subheadingFontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.spacingSmall),
            Text(
              'Your request for $productName has been received. Our sales team will contact you within 24 hours with a customized bulk quote.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFontSize,
                color: grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK', 
              style: TextStyle(
                color: primaryRed,
                fontSize: context.bodyFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}