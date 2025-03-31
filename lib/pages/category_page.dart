import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search......',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          // Category Pills
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryPill('ເຂົ້າກ້ອງສຳລັບ', true),
                  _buildCategoryPill('ເຂົ້າຫອມ', false),
                  _buildCategoryPill('ເຂົ້າດໍາ', false),
                  _buildCategoryPill('ອື່ນໆ', false),
                  _buildCategoryPill('ເຂົ້າຫອມມະລິ', false),
                  _buildCategoryPill('ເຂົ້າໜຽວ', false),
                  _buildCategoryPill('ເຂົ້າປອດສານພິດ', false),
                  _buildCategoryPill('ເຂົ້າກ່ຳ', false),
                  _buildCategoryPill('ເຂົ້າຂາວ', false),
                  _buildCategoryPill('ເຂົ້າສານ', false),
                ],
              ),
            ),
          ),

          // Product Grid
          Expanded(
            child: Container(
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(6, (index) => _buildProductCard()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated category pill widget with tap handling
  Widget _buildCategoryPill(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // In a stateful widget, you would update the state here
        print('Selected category: $title');
        // setState(() {
        //   selectedCategory = title;
        // });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Chip(
          backgroundColor: isSelected ? const Color(0xFFFFD051) : Colors.white,
          label: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: isSelected ? 2 : 0,
          shadowColor: isSelected ? Colors.black38 : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              'assets/images/rice.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ເຂົ້າດໍາ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '25,000 ກີບ/kg',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF03BE6D),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Increased border radius
                          ),
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Increased border radius
                          ),
                        ),
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
