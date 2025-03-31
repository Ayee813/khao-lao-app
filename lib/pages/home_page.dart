import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add this import

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of banner images for carousel
    final List<String> bannerImages = [
      'assets/images/rice.jpg',
      'assets/images/rice_basmati.jpg',
      'assets/images/rice_jasmine.jpg',
      'assets/images/rice_brown.jpg',
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
                  height: 150,
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

// Horizontal scrollable list of hot rice items
              SizedBox(
                height: 220, // Adjust based on your item height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າໜຽວຫອມມະລິ', '19,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າກ່ໍາ', '25,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າຈ້າວ', '22,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າກວດ', '30,000 ກີບ/kg'),
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
              
// Horizontal scrollable list of hot rice items
              SizedBox(
                height: 220, // Adjust based on your item height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າໜຽວຫອມມະລິ', '19,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າກ່ໍາ', '25,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າຈ້າວ', '22,000 ກີບ/kg'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 160, // Adjust width as needed
                      child: _buildRiceItem('ເຂົ້າກວດ', '30,000 ກີບ/kg'),
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

  Widget _buildRiceItem(String name, String price) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              name.contains('ກ່ໍາ')
                  ? 'assets/images/rice.png'
                  : 'assets/images/rice.png',
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if image loading fails
                return Container(
                  width: double.infinity,
                  height: 120,
                  color: name.contains('ກ່ໍາ')
                      ? Colors.brown[300]
                      : Colors.amber[100],
                  child: Center(
                    child: Text(name),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF006633),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
