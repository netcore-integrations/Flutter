import 'package:flutter/material.dart';

class Website extends StatefulWidget {


  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints
    const double mobileBreakpoint = 600.0;
    const double tabletBreakpoint = 1024.0;

    bool isMobile = screenWidth < mobileBreakpoint;
    bool isTablet = screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;
    // bool isDesktop = screenWidth >= tabletBreakpoint; // Not explicitly used for AppBar logic here, but good for body

    return Scaffold(
      key: _scaffoldKey,
      // Responsive AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        toolbarHeight: isMobile ? 60 : 80,
        title: Text(
          'Red Beryl', // Placeholder for Logo/Brand Name
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 20 : 24,
          ),
        ),
        centerTitle: isMobile, // Center title on mobile
        leading: isMobile || isTablet
            ? IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open drawer
          },
        )
            : Padding( // Add some padding for the desktop logo if no leading icon
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'MTC',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        leadingWidth: isMobile || isTablet ? 56 : (isTablet ? 150 : 200), // Adjust leading width
        actions: isMobile || isTablet
            ? null // No actions here, they are in the drawer
            : _buildDesktopNavActions(context),
      ),
      // Drawer for mobile and tablet navigation
      drawer: (isMobile || isTablet) ? _buildAppDrawer(context) : null,
      // Body content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HeroSection(isMobile: isMobile, isTablet: isTablet),
            _ServicesSection(isMobile: isMobile, isTablet: isTablet),
            _FeaturedWorkSection(isMobile: isMobile, isTablet: isTablet),
            _CallToActionSection(isMobile: isMobile),
            _FooterSection(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  // Desktop navigation actions
  List<Widget> _buildDesktopNavActions(BuildContext context) {
    return [
      _navLink(context, 'Home', () {}),
      _navLink(context, 'Services', () {}),
      _navLink(context, 'Work', () {}),
      _navLink(context, 'About', () {}),
      _navLink(context, 'Contact', () {}),
      const SizedBox(width: 20),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text('Get a Quote', style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    ];
  }

  // Helper for navigation links
  Widget _navLink(BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // App Drawer for mobile/tablet
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
            ),
            child: const Text(
              'YourBrand',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _drawerLink(context, Icons.home, 'Home', () => Navigator.pop(context)),
          _drawerLink(context, Icons.miscellaneous_services, 'Services', () => Navigator.pop(context)),
          _drawerLink(context, Icons.work, 'Work', () => Navigator.pop(context)),
          _drawerLink(context, Icons.info_outline, 'About', () => Navigator.pop(context)),
          _drawerLink(context, Icons.contact_mail, 'Contact', () => Navigator.pop(context)),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close drawer before action
                // Handle Get a Quote
              },
              child: Text('Get a Quote', style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerLink(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[600]),
      title: Text(title, style: TextStyle(color: Colors.blueGrey[800], fontSize: 16)),
      onTap: onTap,
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _HeroSection({required this.isMobile, required this.isTablet});



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    double horizontalPadding = isMobile ? 20.0 : (isTablet ? 40.0 : 80.0);
    double verticalPadding = isMobile ? 40.0 : (isTablet ? 60.0 : 100.0);
    double heroHeight = isMobile ? 400 : (isTablet ? 500 : 600);

    return Container(
      height: heroHeight,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        // Placeholder for a background image or gradient
        color: Colors.blueGrey[50],
        image: DecorationImage(
          // Replace with your actual image URL or local asset
          image: AssetImage("assets/images/img_image14_215x428.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Creative Digital Solutions', // Main headline
            style: textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
              color: Colors.white,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 20),
          Text(
            'We craft beautiful and effective web & mobile experiences that drive results for your business.', // Sub-headline
            style: textTheme.headlineMedium?.copyWith(
              fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Handle CTA
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 12 : 16,
              ),
            ),
            child: Text('Explore Our Work', style: textTheme.labelLarge?.copyWith(fontSize: isMobile ? 14 : 16)),
          ),
        ],
      ),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  const _ServicesSection({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double horizontalPadding = isMobile ? 20.0 : (isTablet ? 40.0 : 80.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Our Services',
            style: textTheme.headlineMedium?.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'We offer a wide range of services to help your business succeed online.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildServiceGrid(context),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    // Example services data
    final services = [
      {'icon': Icons.web_asset, 'title': 'Web Development', 'description': 'Modern, responsive websites tailored to your needs.'},
      {'icon': Icons.phone_android, 'title': 'Mobile Apps', 'description': 'Native & cross-platform apps for iOS and Android.'},
      {'icon': Icons.design_services, 'title': 'UI/UX Design', 'description': 'Intuitive and engaging user experiences.'},
      {'icon': Icons.cloud_queue, 'title': 'Digital Strategy', 'description': 'Data-driven strategies for online growth.'},
    ];

    if (isMobile) {
      // Single column for mobile
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _ServiceCard(
            icon: services[index]['icon'] as IconData,
            title: services[index]['title'] as String,
            description: services[index]['description'] as String,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      );
    } else {
      // Grid for tablet and desktop
      int crossAxisCount = isTablet ? 2 : 3; // 2 columns for tablet, 3 for desktop
      double childAspectRatio = isTablet ? 1.8 : 1.5; // Adjust aspect ratio for cards

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _ServiceCard(
            icon: services[index]['icon'] as IconData,
            title: services[index]['title'] as String,
            description: services[index]['description'] as String,
          );
        },
      );
    }
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40.0, color: Colors.deepPurpleAccent),
            const SizedBox(height: 15),
            Text(title, style: textTheme.titleLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: textTheme.bodyLarge?.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}


class _FeaturedWorkSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  const _FeaturedWorkSection({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double horizontalPadding = isMobile ? 20.0 : (isTablet ? 40.0 : 80.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50.0),
      color: Colors.blueGrey[50], // Slightly different background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Featured Work',
            style: textTheme.headlineMedium?.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            'Take a look at some of our recent projects.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // Placeholder for project items
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: List.generate(isMobile ? 2 : (isTablet ? 3 : 4), (index) {
              return _ProjectThumbnail(index: index, isMobile: isMobile);
            }),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: BorderSide(color: Colors.deepPurpleAccent),
            ),
            child: const Text('View All Projects', style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class _ProjectThumbnail extends StatelessWidget {
  final int index;
  final bool isMobile;
  const _ProjectThumbnail({required this.index, required this.isMobile});

  @override
  Widget build(BuildContext context) {

    List bannerImages = [
      "assets/images/img_image14_215x428.png",
      "assets/images/img_dks3bvbvsaaus9p.png",
      "assets/images/img_image3.png",
      "assets/images/img_image4.png",
    ];
    final double cardWidth = isMobile ? MediaQuery.of(context).size.width * 0.8 : 300;
    final double cardHeight = cardWidth * 0.75; // Maintain aspect ratio

    return Card(
      elevation: 3.0,
      clipBehavior: Clip.antiAlias, // Ensures the image respects the border radius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for project image
            Image.asset(
              bannerImages[index],
              height: cardHeight * 0.7,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: cardHeight * 0.7,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Title ${index + 1}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Brief description or category',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _CallToActionSection extends StatelessWidget {
  final bool isMobile;
  const _CallToActionSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 50),
      color: Colors.deepPurpleAccent,
      child: Column(
        children: [
          Text(
            "Ready to Start Your Next Project?",
            style: textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: isMobile ? 22 : 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            "Let's discuss how we can help you achieve your goals.",
            style: textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(0.9), fontSize: isMobile ? 14 : 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: isMobile ? 12 : 16),
            ),
            child: Text("Get In Touch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 16)),
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  final bool isMobile;
  const _FooterSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: isMobile ? 20 : 40),
      color: Colors.blueGrey[800],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _socialIcon(Icons.facebook, () {}), // Placeholder icons
              const SizedBox(width: 15),
              _socialIcon(Icons.g_mobiledata_outlined, () {}), // Placeholder for X/Twitter
              const SizedBox(width: 15),
              _socialIcon(Icons.linked_camera_outlined, () {}), // Placeholder for LinkedIn
              const SizedBox(width: 15),
              _socialIcon(Icons.insert_chart_outlined_rounded, () {}), // Placeholder for Instagram
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} YourBrand. All Rights Reserved.',
            style: textTheme.bodyLarge?.copyWith(color: Colors.blueGrey[200], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: [
              _footerLink(context, "Privacy Policy", () {}),
              Text("•", style: TextStyle(color: Colors.blueGrey[300])),
              _footerLink(context, "Terms of Service", () {}),
            ],
          )
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.blueGrey[200]),
      onPressed: onPressed,
      iconSize: 24.0,
    );
  }

  Widget _footerLink(BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.blueGrey[200], fontSize: 12, decoration: TextDecoration.underline),
      ),
    );
  }
}
