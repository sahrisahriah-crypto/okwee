import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'checkout.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  String formatHarga(int harga) {
    final String angka = harga.toString();
    final StringBuffer hasil = StringBuffer();

    for (int i = 0; i < angka.length; i++) {
      final int posisiDariBelakang = angka.length - i;

      hasil.write(angka[i]);

      if (posisiDariBelakang > 1 &&
          posisiDariBelakang % 3 == 1) {
        hasil.write('.');
      }
    }

    return 'Rp$hasil';
  }

  void tampilkanPesan(
      BuildContext context,
      String pesan,
      ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void bukaCheckout(BuildContext context) {
    if (CartData.items.isEmpty) {
      tampilkanPesan(
        context,
        'Keranjang masih kosong',
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CheckoutPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ValueListenableBuilder<List<CartProduct>>(
        valueListenable: CartData.cartNotifier,
        builder: (context, products, child) {
          if (products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 65,
                        color: Colors.deepPurple,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Keranjang Masih Kosong',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Silakan kembali ke halaman Home dan tekan tombol Beli pada produk yang Anda inginkan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.shopping_bag,
                      ),
                      label: const Text(
                        'Belanja Sekarang',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final CartProduct product =
                    products[index];

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.06),
                            blurRadius: 10,
                            offset:
                            const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(
                              14,
                            ),
                            child: Image.asset(
                              product.image,
                              width: 90,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return Container(
                                  width: 90,
                                  height: 100,
                                  color: Colors
                                      .deepPurple
                                      .shade100,
                                  child: const Icon(
                                    Icons
                                        .broken_image_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 2,
                                  overflow:
                                  TextOverflow
                                      .ellipsis,
                                  style:
                                  const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Text(
                                  formatHarga(
                                    product.price,
                                  ),
                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.deepPurple,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  'Subtotal: ${formatHarga(product.price * product.quantity)}',
                                  style:
                                  const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    QuantityButton(
                                      icon: Icons.remove,
                                      onTap: () {
                                        CartData
                                            .decreaseQuantity(
                                          index,
                                        );
                                      },
                                    ),

                                    Padding(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                        horizontal: 14,
                                      ),
                                      child: Text(
                                        product.quantity
                                            .toString(),
                                        style:
                                        const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    QuantityButton(
                                      icon: Icons.add,
                                      onTap: () {
                                        CartData
                                            .increaseQuantity(
                                          index,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            tooltip: 'Hapus produk',
                            onPressed: () {
                              CartData.removeProduct(
                                index,
                              );

                              tampilkanPesan(
                                context,
                                'Produk dihapus dari keranjang',
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // =========================================
              // TOTAL DAN CHECKOUT
              // =========================================
              Container(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  16,
                  18,
                  20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'Total (${CartData.totalQuantity} barang)',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            formatHarga(
                              CartData.totalPrice,
                            ),
                            style: const TextStyle(
                              color:
                              Colors.deepPurple,
                              fontSize: 22,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            bukaCheckout(context);
                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                          ),
                          label: const Text(
                            'Checkout Sekarang',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.amber,
                            foregroundColor:
                            Colors.white,
                            padding:
                            const EdgeInsets
                                .symmetric(
                              vertical: 15,
                            ),
                            elevation: 0,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.deepPurple,
          size: 18,
        ),
      ),
    );
  }
}