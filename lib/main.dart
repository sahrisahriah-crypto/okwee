import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'detail_produk.dart';
import 'favorit.dart';
import 'favorite_data.dart';
import 'kategori.dart';
import 'keranjang.dart';
import 'notif.dart';
import 'profil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SinaRi Hijab',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xffF8F9FD), // Background sedikit lebih lembut & modern
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff7B4DFF),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeContent(
        onNavigateToTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      const KategoriPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex >= pages.length ? 0 : _currentIndex],
      bottomNavigationBar: ValueListenableBuilder<List<CartProduct>>(
        valueListenable: CartData.cartNotifier,
        builder: (context, products, child) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                selectedItemColor: const Color(0xff7B4DFF),
                unselectedItemColor: Colors.grey.shade400,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 10,
                onTap: (index) {
                  if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KeranjangPage(),
                      ),
                    );
                  } else if (index == 3) {
                    setState(() {
                      _currentIndex = 2;
                    });
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded, size: 26),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_rounded, size: 24),
                    label: 'Kategori',
                  ),
                  BottomNavigationBarItem(
                    icon: CartIconBadge(
                      total: CartData.totalQuantity,
                    ),
                    label: 'Keranjang',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded, size: 24),
                    label: 'Profil',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// HALAMAN PENCARIAN PRODUK
class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> semuaProduk;

  const SearchPage({super.key, required this.semuaProduk});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Map<String, dynamic>> _hasilPencarian;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hasilPencarian = widget.semuaProduk;
  }

  void _filterProduk(String query) {
    setState(() {
      if (query.isEmpty) {
        _hasilPencarian = widget.semuaProduk;
      } else {
        _hasilPencarian = widget.semuaProduk.where((produk) {
          final title = produk['title'].toString().toLowerCase();
          final deskripsi = produk['description'].toString().toLowerCase();
          final input = query.toLowerCase();
          return title.contains(input) || deskripsi.contains(input);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _filterProduk,
            decoration: const InputDecoration(
              hintText: 'Cari produk hijab...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
      ),
      body: _hasilPencarian.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'Produk tidak ditemukan',
              style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _hasilPencarian.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final produk = _hasilPencarian[index];
          return ProductCard(
            title: produk['title'],
            priceInt: produk['priceInt'],
            price: produk['price'],
            image: produk['image'],
            description: produk['description'],
            onBuy: () {
              CartData.addProduct(
                name: produk['title'],
                price: produk['priceInt'],
                image: produk['image'],
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${produk['title']} masuk ke keranjang'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// KONTEN HALAMAN UTAMA (HOME)
class HomeContent extends StatelessWidget {
  final Function(int) onNavigateToTab;

  HomeContent({super.key, required this.onNavigateToTab});

  final List<Map<String, dynamic>> daftarSemuaProduk = [
    {
      'title': 'Hijab Bergo',
      'priceInt': 200000,
      'price': 'Rp200.000',
      'image': 'assets/gambar/hijab_bergo.jpg',
      'description': 'Hijab Bergo instan berbahan lembut, adem, dan menyerap keringat.',
    },
    {
      'title': 'Hijab Diamond',
      'priceInt': 110000,
      'price': 'Rp110.000',
      'image': 'assets/gambar/hijab_diamond.jpg',
      'description': 'Hijab berbahan Diamond Italiano berkualitas tinggi.',
    },
    {
      'title': 'Hijab Instan',
      'priceInt': 100000,
      'price': 'Rp100.000',
      'image': 'assets/gambar/hijab_instan.jpg',
      'description': 'Hijab praktis tanpa butuh jarum pentul.',
    },
    {
      'title': 'Hijab Jersey',
      'priceInt': 85000,
      'price': 'Rp85.000',
      'image': 'assets/gambar/hijab_jersey.jpg',
      'description': 'Terbuat dari bahan jersey premium yang fleksibel dan adem.',
    },
    {
      'title': 'Hijab Paris',
      'priceInt': 75000,
      'price': 'Rp75.000',
      'image': 'assets/gambar/hijab_paris.jpg',
      'description': 'Hijab Paris klasik ringan yang adem dan breathable.',
    },
    {
      'title': 'Hijab Pashmina',
      'priceInt': 95000,
      'price': 'Rp95.000',
      'image': 'assets/gambar/hijab_pashmina.jpg',
      'description': 'Pashmina panjang dengan bahan jatuh dan tidak licin.',
    },
    {
      'title': 'Hijab Premium',
      'priceInt': 150000,
      'price': 'Rp150.000',
      'image': 'assets/gambar/hijab_premium.jpg',
      'description': 'Hijab eksklusif dengan sentuhan bahan kelas atas.',
    },
    {
      'title': 'Hijab Segiempat',
      'priceInt': 80000,
      'price': 'Rp80.000',
      'image': 'assets/gambar/hijab_segiempat.jpg',
      'description': 'Hijab segi empat favorit yang mudah dibentuk.',
    },
    {
      'title': 'Hijab Sport',
      'priceInt': 65000,
      'price': 'Rp65.000',
      'image': 'assets/gambar/hijab_sport.jpg',
      'description': 'Hijab khusus olahraga yang sangat adem dan ringan.',
    },
    {
      'title': 'Hijab Voal',
      'priceInt': 90000,
      'price': 'Rp90.000',
      'image': 'assets/gambar/hijab_voal.jpg',
      'description': 'Hijab voal halus bertaraf premium, nyaman seharian.',
    },
  ];

  void tampilkanPesan(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void tambahKeKeranjang({
    required BuildContext context,
    required String nama,
    required int harga,
    required String gambar,
  }) {
    CartData.addProduct(name: nama, price: harga, image: gambar);
    tampilkanPesan(context, '$nama masuk ke keranjang');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER DENGAN JARUM/STATUS BAR AMAN & MELENGKUNG ELEGAN
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 26), // Padding atas ditambah agar tidak mepet status bar
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff7B4DFF), Color(0xff6A3DE8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(semuaProduk: daftarSemuaProduk),
                          ),
                        );
                      },
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey, size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Cari produk hijab...',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotifPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // BANNER PROMO DENGAN ORNAMEN LATAR BELAKANG
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff7B4DFF), Color(0xffFFB300)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7B4DFF).withOpacity(0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'SPECIAL PROMO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'SinaRi Hijab',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Diskon hingga 15% untuk semua koleksi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // MENU GRID DENGAN KARTU PUTIH BERSIH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.82,
                  children: [
                    MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Produk',
                      onTap: () => onNavigateToTab(1),
                    ),
                    MenuItem(
                      icon: Icons.local_offer_outlined,
                      title: 'Promo',
                      onTap: () => tampilkanPesan(context, 'Menu Promo dipilih'),
                    ),
                    MenuItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'Favorit',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritPage(),
                          ),
                        );
                      },
                    ),
                    MenuItem(
                      icon: Icons.headset_mic_outlined,
                      title: 'Bantuan',
                      onTap: () => tampilkanPesan(context, 'Menu Bantuan dipilih'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // PRODUCT TITLE SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  const Text(
                    'Rekomendasi Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2D3142),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      onNavigateToTab(1);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      child: Text(
                        'Lihat Semua',
                        style: TextStyle(
                          color: Color(0xff7B4DFF),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // PRODUCT GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: daftarSemuaProduk.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final produk = daftarSemuaProduk[index];
                  return ProductCard(
                    title: produk['title'],
                    priceInt: produk['priceInt'],
                    price: produk['price'],
                    image: produk['image'],
                    description: produk['description'],
                    onBuy: () {
                      tambahKeKeranjang(
                        context: context,
                        nama: produk['title'],
                        harga: produk['priceInt'],
                        gambar: produk['image'],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class CartIconBadge extends StatelessWidget {
  final int total;
  final Color? iconColor;

  const CartIconBadge({super.key, required this.total, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(Icons.shopping_cart_outlined, color: iconColor, size: 24),
        if (total > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(
                child: Text(
                  total > 99 ? '99+' : total.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xff7B4DFF).withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xff7B4DFF),
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff4A4E69),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final int priceInt;
  final String price;
  final String image;
  final String description;
  final VoidCallback onBuy;

  const ProductCard({
    super.key,
    required this.title,
    required this.priceInt,
    required this.price,
    required this.image,
    required this.description,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailProdukPage(
                        nama: title,
                        harga: price,
                        gambar: image,
                        deskripsi: description,
                        onBuy: onBuy,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          image,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.deepPurple.shade100,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: ValueListenableBuilder<List<FavoriteProduct>>(
                            valueListenable: FavoriteData.favoriteNotifier,
                            builder: (context, favorites, child) {
                              bool isFav = FavoriteData.isFavorite(title);
                              return GestureDetector(
                                onTap: () {
                                  bool added = FavoriteData.toggleFavorite(
                                    name: title,
                                    price: priceInt,
                                    image: image,
                                    description: description,
                                  );

                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        added
                                            ? '$title ditambahkan ke Favorit'
                                            : '$title dihapus dari Favorit',
                                      ),
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: isFav ? Colors.red : Colors.grey,
                                    size: 18,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onBuy,
                  icon: const Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 15,
                  ),
                  label: const Text(
                    'Beli',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}