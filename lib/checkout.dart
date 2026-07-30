import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'pembayaran.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController namaController =
  TextEditingController();

  final TextEditingController whatsappController =
  TextEditingController();

  final TextEditingController alamatController =
  TextEditingController();

  final TextEditingController catatanController =
  TextEditingController();

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

  void lanjutPembayaran() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranPage(
          namaPembeli: namaController.text.trim(),
          nomorWhatsapp: whatsappController.text.trim(),
          alamat: alamatController.text.trim(),
          catatan: catatanController.text.trim(),
          totalPembayaran: CartData.totalPrice,
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    whatsappController.dispose();
    alamatController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CheckoutSectionTitle(
                icon: Icons.location_on_outlined,
                title: 'Data Penerima',
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CheckoutTextField(
                      controller: namaController,
                      label: 'Nama Pembeli',
                      hint: 'Masukkan nama lengkap',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Nama pembeli wajib diisi';
                        }

                        if (value.trim().length < 3) {
                          return 'Nama minimal 3 karakter';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    CheckoutTextField(
                      controller: whatsappController,
                      label: 'Nomor WhatsApp',
                      hint: 'Contoh: 08957083198',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Nomor WhatsApp wajib diisi';
                        }

                        final String nomor =
                        value.replaceAll(RegExp(r'\D'), '');

                        if (nomor.length < 10) {
                          return 'Nomor WhatsApp tidak valid';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    CheckoutTextField(
                      controller: alamatController,
                      label: 'Alamat Lengkap',
                      hint:
                      'Masukkan alamat pengiriman lengkap',
                      icon: Icons.home_outlined,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Alamat wajib diisi';
                        }

                        if (value.trim().length < 10) {
                          return 'Alamat terlalu singkat';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    CheckoutTextField(
                      controller: catatanController,
                      label: 'Catatan Pesanan',
                      hint:
                      'Contoh: Warna hitam, kirim sore hari',
                      icon: Icons.note_alt_outlined,
                      maxLines: 3,
                      validator: null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const CheckoutSectionTitle(
                icon: Icons.shopping_bag_outlined,
                title: 'Ringkasan Pesanan',
              ),

              const SizedBox(height: 12),

              ValueListenableBuilder<List<CartProduct>>(
                valueListenable: CartData.cartNotifier,
                builder: (context, products, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ...products.map(
                              (product) => Padding(
                            padding:
                            const EdgeInsets.only(
                              bottom: 14,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                    12,
                                  ),
                                  child: Image.asset(
                                    product.image,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                        ) {
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        color: Colors
                                            .deepPurple
                                            .shade100,
                                        child: const Icon(
                                          Icons
                                              .broken_image_outlined,
                                          color:
                                          Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${product.quantity} × ${formatHarga(product.price)}',
                                        style:
                                        const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Text(
                                  formatHarga(
                                    product.price *
                                        product.quantity,
                                  ),
                                  style: const TextStyle(
                                    color:
                                    Colors.deepPurple,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(),

                        const SizedBox(height: 8),

                        RingkasanBaris(
                          judul: 'Jumlah Barang',
                          nilai:
                          '${CartData.totalQuantity} barang',
                        ),

                        const SizedBox(height: 10),

                        RingkasanBaris(
                          judul: 'Ongkos Kirim',
                          nilai: 'Gratis',
                          valueColor: Colors.green,
                        ),

                        const SizedBox(height: 12),

                        const Divider(),

                        const SizedBox(height: 10),

                        RingkasanBaris(
                          judul: 'Total Pembayaran',
                          nilai: formatHarga(
                            CartData.totalPrice,
                          ),
                          isTotal: true,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: lanjutPembayaran,
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                  label: const Text(
                    'Lanjut ke Pembayaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),
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

class CheckoutSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const CheckoutSectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CheckoutTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CheckoutTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            bottom: maxLines > 1 ? 65 : 0,
          ),
          child: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        filled: true,
        fillColor: const Color(0xffFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.deepPurple,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class RingkasanBaris extends StatelessWidget {
  final String judul;
  final String nilai;
  final bool isTotal;
  final Color? valueColor;

  const RingkasanBaris({
    super.key,
    required this.judul,
    required this.nilai,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: TextStyle(
            color: isTotal
                ? Colors.black
                : Colors.grey.shade700,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        Text(
          nilai,
          style: TextStyle(
            color: valueColor ??
                (isTotal
                    ? Colors.deepPurple
                    : Colors.black87),
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}