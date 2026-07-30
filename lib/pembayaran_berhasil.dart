import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'main.dart';

class PembayaranBerhasilPage extends StatelessWidget {
  final String namaPembeli;
  final String nomorWhatsapp;
  final String alamat;
  final String catatan;
  final String metodePembayaran;
  final int totalPembayaran;

  const PembayaranBerhasilPage({
    super.key,
    required this.namaPembeli,
    required this.nomorWhatsapp,
    required this.alamat,
    required this.catatan,
    required this.metodePembayaran,
    required this.totalPembayaran,
  });

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

  String buatNomorPesanan() {
    final DateTime sekarang = DateTime.now();

    final String tahun = sekarang.year.toString();
    final String bulan =
    sekarang.month.toString().padLeft(2, '0');
    final String tanggal =
    sekarang.day.toString().padLeft(2, '0');
    final String jam =
    sekarang.hour.toString().padLeft(2, '0');
    final String menit =
    sekarang.minute.toString().padLeft(2, '0');
    final String detik =
    sekarang.second.toString().padLeft(2, '0');

    return 'SNR-$tahun$bulan$tanggal-$jam$menit$detik';
  }

  void kembaliKeHome(BuildContext context) {
    CartData.clearCart();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String nomorPesanan = buatNomorPesanan();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Pembayaran Berhasil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff7B4DFF),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 18),

              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 82,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Pesanan Berhasil Dibuat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                metodePembayaran == 'COD'
                    ? 'Pesanan Anda berhasil dibuat. Pembayaran dilakukan saat barang diterima.'
                    : 'Pembayaran Anda berhasil diproses. Pesanan akan segera disiapkan.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 26),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    DetailTransaksiRow(
                      title: 'Nomor Pesanan',
                      value: nomorPesanan,
                    ),

                    const Divider(height: 26),

                    DetailTransaksiRow(
                      title: 'Nama Pembeli',
                      value: namaPembeli,
                    ),

                    const Divider(height: 26),

                    DetailTransaksiRow(
                      title: 'Nomor WhatsApp',
                      value: nomorWhatsapp,
                    ),

                    const Divider(height: 26),

                    DetailTransaksiRow(
                      title: 'Metode Pembayaran',
                      value: metodePembayaran,
                    ),

                    const Divider(height: 26),

                    DetailTransaksiRow(
                      title: 'Total Pembayaran',
                      value: formatHarga(totalPembayaran),
                      valueColor: Colors.deepPurple,
                      isBold: true,
                    ),

                    const Divider(height: 26),

                    DetailTransaksiRow(
                      title: 'Status',
                      value: metodePembayaran == 'COD'
                          ? 'Menunggu Pembayaran'
                          : 'Pembayaran Berhasil',
                      valueColor: metodePembayaran == 'COD'
                          ? Colors.orange
                          : Colors.green,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Alamat Pengiriman',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      alamat,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),

                    if (catatan.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Text(
                        'Catatan Pesanan',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        catatan,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.deepPurple.shade100,
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Simpan nomor pesanan ini sebagai bukti transaksi. Tim SinaRi Hijab akan menghubungi Anda melalui WhatsApp.',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    kembaliKeHome(context);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text(
                    'Kembali ke Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Bukti transaksi berhasil disimpan',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: const Text(
                    'Simpan Bukti Transaksi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailTransaksiRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const DetailTransaksiRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor ?? Colors.black87,
              fontSize: 14,
              fontWeight:
              isBold ? FontWeight.bold : FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}