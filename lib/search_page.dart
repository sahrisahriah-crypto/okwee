import 'package:flutter/material.dart';
import 'detail_produk.dart';
import 'cart_data.dart';

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
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ),
      body: _hasilPencarian.isEmpty
          ? const Center(
        child: Text(
          'Produk tidak ditemukan',
          style: TextStyle(color: Colors.grey, fontSize: 16),
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
                        icon: const Icon(Icons.add_shopping_cart_rounded, size: 15),
                        label: const Text(
                          'Beli',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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