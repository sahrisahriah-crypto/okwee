import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Purple Shop',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // =========================================
      // BOTTOM NAVIGATION
      // =========================================

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      // =========================================
      // BODY
      // =========================================

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =========================================
              // HEADER
              // =========================================

              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff7B4DFF),
                      Color(0xff6A3DE8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),

                child: Row(
                  children: [

                    // SEARCH BAR

                    Expanded(
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Cari produk...',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 26,
                    ),

                    const SizedBox(width: 14),

                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 26,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =========================================
              // BANNER
              // =========================================

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),

                child: Container(
                  width: double.infinity,
                  height: 180,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),

                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff7B4DFF),
                        Color(0xffFFC107),
                      ],
                    ),
                  ),

                  child: const Padding(
                    padding: EdgeInsets.all(24),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          'SinaRi Hijab',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Diskon hingga 15%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // =========================================
              // MENU GRID
              // =========================================

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),

                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,

                  children: const [

                    MenuItem(
                      icon: Icons.shopping_bag,
                      title: 'Produk',
                    ),

                    MenuItem(
                      icon: Icons.discount,
                      title: 'Promo',
                    ),

                    MenuItem(
                      icon: Icons.favorite,
                      title: 'Favorit',
                    ),




                    MenuItem(
                      icon: Icons.payment,
                      title: 'Bayar',
                    ),

                    MenuItem(
                      icon: Icons.support_agent,
                      title: 'Bantuan',
                    ),

                    MenuItem(
                      icon: Icons.more_horiz,
                      title: 'Lainnya',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),



              const SizedBox(height: 28),

              // =========================================
              // PRODUCT TITLE
              // =========================================

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: const [

                    Text(
                      'Rekomendasi Produk',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =========================================
              // PRODUCT GRID
              // =========================================

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),

                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.58,

                  children: const [

                    ProductCard(
                      title: 'Produk 1',
                      price: 'Rp 120.000',
                    ),

                    ProductCard(
                      title: 'Produk 2',
                      price: 'Rp 95.000',
                    ),

                    ProductCard(
                      title: 'Produk 3',
                      price: 'Rp 150.000',
                    ),

                    ProductCard(
                      title: 'Produk 4',
                      price: 'Rp 200.000',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================
// MENU ITEM
// =========================================

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          height: 56,
          width: 56,

          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(18),
          ),

          child: Icon(
            icon,
            color: Colors.deepPurple,
            size: 28,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// =========================================
// PRODUCT CARD
// =========================================

class ProductCard extends StatelessWidget {
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // IMAGE

          Container(
            height: 170,

            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),

            child: const Center(
              child: Icon(
                Icons.image,
                size: 55,
                color: Colors.white,
              ),
            ),
          ),

          // CONTENT

          Padding(
            padding: const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                    BorderRadius.circular(12),
                  ),

                  child: const Text(
                    'Beli',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
}