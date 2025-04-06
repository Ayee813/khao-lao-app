import 'package:flutter/material.dart';
import 'package:khao_lao/pages/bottom_navigation_page.dart';
import 'package:provider/provider.dart';
import 'product_model.dart';
import 'cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample related products - in a real app, you would filter based on category or other attributes
    final List<Product> relatedProducts = [
      Product(
        id: '2',
        name: 'ເຂົ້າຈ້າວ',
        weight: '5kg',
        price: 22500,
        image: 'assets/images/rice_list/1685758244536.jpg',
      ),
      Product(
        id: '3',
        name: 'ເຂົ້າໜຽວ',
        weight: '1kg',
        price: 28000,
        image: 'assets/images/rice_list/rice-featured-image.jpg',
      ),
      Product(
        id: '5',
        name: 'ເຂົ້າຫອມ',
        weight: '5kg',
        price: 26500,
        image: 'assets/images/rice_list/1685758244536.jpg',
      ),
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
       leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC65C)),
  onPressed: () {
    // Navigate back to BottomNavigationPage and set index to 1 (Category)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationPage(initialIndex: 1),
      ),
    );
  },
),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFFFFC65C), size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart,
                color: Color(0xFFFFC65C), size: 24),
            onPressed: () {
              // Navigate to cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Hero animation
            Hero(
              tag: 'product-${product.id}',
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, error, _) => Center(
                    child: Icon(Icons.image_not_supported,
                        size: 60, color: Colors.grey[400]),
                  ),
                ),
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.weight}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${product.price.toStringAsFixed(0)} ກີບ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'ລາຍລະອຽດສິນຄ້າ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ເຂົ້າຄຸນນະພາບດີ ຈາກແຂວງ ສະຫວັນນະເຂດ, ປູກໂດຍຊາວກະສິກອນທ້ອງຖິ່ນ. ບໍ່ມີສານເຄມີ, ປອດສານພິດ, ມີລົດຊາດດີ ແລະ ມີຄຸນຄ່າທາງໂພຊະນາການສູງ.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Buy and Add to Cart Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Buy now functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF03BE6D),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'ຊື້ຕອນນີ້',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);
                            cartProvider.addItem(product);

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('ເພີ່ມໃສ່ກະຕ່າ'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: const Color(0xFF006633),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: const Color(0xFF03BE6D)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'ເພີ່ມໃສ່ກະຕ່າ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF03BE6D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Similar Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ສິນຄ້າໃກ້ຄຽງ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedProducts.length,
                      itemBuilder: (context, index) {
                        return _buildRelatedProductCard(
                            context, relatedProducts[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedProductCard(BuildContext context, Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
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
                  product.image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, _) => Center(
                    child: Icon(Icons.image_not_supported,
                        size: 40, color: Colors.grey[400]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.price.toStringAsFixed(0)} ກີບ',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          cartProvider.addItem(product);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('ເພີ່ມໃສ່ກະຕ່າ'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: const Color(0xFF006633),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          minimumSize: const Size(0, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'ເພີ່ມໃສ່ກະຕ່າ',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ),
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
}
