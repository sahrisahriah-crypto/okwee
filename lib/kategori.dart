import 'package:flutter/material.dart';
import 'cart_data.dart';
import 'detail_produk.dart';
import 'main.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  final List<Map<String, dynamic>> kategoriList = const [
    {
      'nama': 'Hijab Segi Empat',
      'icon': Icons.checkroom,
      'produk': [
        {
          'title': 'Hijab Segiempat Premium',
          'priceInt': 80000,
          'price': 'Rp80.000',
          'image': 'assets/gambar/hijab_segiempat.jpg',
          'description': 'Hijab segi empat favorit yang mudah dibentuk dan nyaman dipakai.',
        },
        {
          'title': 'Hijab Paris Classic',
          'priceInt': 75000,
          'price': 'Rp75.000',
          'image': 'assets/gambar/hijab_paris.jpg',
          'description': 'Hijab Paris klasik ringan yang adem dan breathable.',
        },
        {
          'title': 'Hijab Voal Square',
          'priceInt': 90000,
          'price': 'Rp90.000',
          'image': 'assets/gambar/hijab_voal.jpg',
          'description': 'Hijab voal halus bertaraf premium, nyaman seharian.',
        },
      ],
    },
    {
      'nama': 'Hijab Pashmina',
      'icon': Icons.style,
      'produk': [
        {
          'title': 'Hijab Pashmina Silk',
          'priceInt': 95000,
          'price': 'Rp95.000',
          'image': 'assets/gambar/hijab_pashmina.jpg',
          'description': 'Pashmina panjang dengan bahan jatuh, adem, dan mudah diatur.',
        },
        {
          'title': 'Hijab Diamond Pashmina',
          'priceInt': 110000,
          'price': 'Rp110.000',
          'image': 'assets/gambar/hijab_diamond.jpg',
          'description': 'Hijab berbahan Diamond Italiano berkualitas tinggi.',
        },
      ],
    },
    {
      'nama': 'Hijab Instan',
      'icon': Icons.woman,
      'produk': [
        {
          'title': 'Hijab Instan Casual',
          'priceInt': 100000,
          'price': 'Rp100.000',
          'image': 'assets/gambar/hijab_instan.jpg',
          'description': 'Hijab praktis tanpa butuh jarum pentul, langsung pakai.',
        },
        {
          'title': 'Hijab Jersey Sporty',
          'priceInt': 85000,
          'price': 'Rp85.000',
          'image': 'assets/gambar/hijab_jersey.jpg',
          'description': 'Terbuat dari bahan jersey premium yang fleksibel dan adem.',
        },
      ],
    },
    {
      'nama': 'Bergo',
      'icon': Icons.face_3,
      'produk': [
        {
          'title': 'Hijab Bergo Maryam',
          'priceInt': 200000,
          'price': 'Rp200.000',
          'image': 'assets/gambar/hijab_bergo.jpg',
          'description': 'Hijab Bergo instan berbahan lembut, adem, dan menyerap keringat.',
        },
        {
          'title': 'Hijab Sport Active',
          'priceInt': 65000,
          'price': 'Rp65.000',
          'image': 'assets/gambar/hijab_sport.jpg',
          'description': 'Hijab khusus olahraga yang sangat adem dan ringan.',
        },
      ],
    },
    {
      'nama': 'Ciput',
      'icon': Icons.circle,
      'produk': [
        {
          'title': 'Ciput Rajut Anti Pusing',
          'priceInt': 25000,
          'price': 'Rp25.000',
          'image': 'assets/gambar/hijab_premium.jpg',
          'description': 'Ciput rajut elastis yang nyaman digunakan sepanjang hari.',
        },
      ],
    },
    {
      'nama': 'Aksesoris',
      'icon': Icons.auto_awesome,
      'produk': [
        {
          'title': 'Bros Hijab Elegan',
          'priceInt': 35000,
          'price': 'Rp35.000',
          'image': 'assets/gambar/hijab_premium.jpg',
          'description': 'Aksesoris bros cantik untuk menyempurnakan penampilan hijabmu.',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            }
          },
        ),
        title: const Text(
          'Kategori Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff7B4DFF), Color(0xff6A3DE8)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Kategori',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Temukan hijab favorit sesuai kebutuhanmu',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      'Cari kategori...',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: kategoriList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) {
                  final kategori = kategoriList[index];
                  final List produkList = kategori['produk'] ?? [];

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriDetailPage(
                            namaKategori: kategori['nama'] as String,
                            daftarProduk: List<Map<String, dynamic>>.from(
                              produkList,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                kategori['icon'] as IconData,
                                color: Colors.deepPurple,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              kategori['nama'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN DETAIL KATEGORI TETAP SAMA
class KategoriDetailPage extends StatelessWidget {
  final String namaKategori;
  final List<Map<String, dynamic>> daftarProduk;

  const KategoriDetailPage({
    super.key,
    required this.namaKategori,
    required this.daftarProduk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: Text(
          namaKategori,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: daftarProduk.isEmpty
          ? const Center(
        child: Text(
          'Belum ada produk pada kategori ini',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarProduk.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final produk = daftarProduk[index];
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
                              nama: produk['title'],
                              harga: produk['price'],
                              gambar: produk['image'],
                              deskripsi: produk['description'],
                              onBuy: () {
                                CartData.addProduct(
                                  name: produk['title'],
                                  price: produk['priceInt'],
                                  image: produk['image'],
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${produk['title']} masuk ke keranjang'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            produk['image'],
                            width: double.infinity,
                            height: 125,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 125,
                                color: Colors.deepPurple.shade100,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produk['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  produk['price'],
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
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          CartData.addProduct(
                            name: produk['title'],
                            price: produk['priceInt'],
                            image: produk['image'],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${produk['title']} masuk ke keranjang'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
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
        },
      ),
    );
  }
}