import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add this import

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of banner images for carousel
    final List<String> bannerImages = [
      'assets/images/rice.jpg',
      'assets/images/rice_list/rice-featured-image.jpg',
      'assets/images/rice_list/1685758244536.jpg',
      'assets/images/rice_list/1920px_x_1080px_46.webp',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006633),
        title: const Text(
          'KHAO LAO',
          style: TextStyle(
            color: Color(0xFFFFC65C),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Color(0xFFFFC65C), size: 30),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFFC65C), size: 35),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Carousel slider for product images - replacing the static image
              CarouselSlider.builder(
                itemCount: bannerImages.length,
                options: CarouselOptions(
                  height: 180,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                ),
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      bannerImages[index],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback if image loading fails
                        return Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text("Rice Type ${index + 1}"),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Hot section title with "See All" button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hot',
                    style: TextStyle(
                      color: Color(0xFF006633),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all hot products
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF006633),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 16),
              SizedBox(
                height: 220, // You might need to adjust this height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າໜຽວຫອມມະລິ', '19,000 ກີບ/kg',
                          'assets/images/rice_list/rice-featured-image.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າກ່ໍາ', '25,000 ກີບ/kg',
                          'assets/images/rice_list/yellow_rice.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າຈ້າວ', '22,000 ກີບ/kg',
                          'assets/images/rice_list/1685758244536.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າກວດ', '30,000 ກີບ/kg',
                          'assets/images/rice_list/IMG_bl22_rice_bag_2_1_3BBGUG9N.webp'),
                    ),
                  ],
                ),
              ),

              // Recently viewed section
              const Text(
                'ຜະລິດຕະພັນມາໃໝ່',
                style: TextStyle(
                  color: Color(0xFF006633),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 16),
              SizedBox(
                height: 220, // You might need to adjust this height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າໜຽວຫອມມະລິ', '19,000 ກີບ/kg',
                          'assets/images/rice_list/rice-featured-image.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າກ່ໍາ', '25,000 ກີບ/kg',
                          'assets/images/rice_list/yellow_rice.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າຈ້າວ', '22,000 ກີບ/kg',
                          'assets/images/rice_list/1685758244536.jpg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160,
                      child: _buildRiceItem('ເຂົ້າກວດ', '30,000 ກີບ/kg',
                          'assets/images/rice_list/IMG_bl22_rice_bag_2_1_3BBGUG9N.webp'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiceItem(String name, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
