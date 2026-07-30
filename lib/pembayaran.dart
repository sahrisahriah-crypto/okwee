import 'package:flutter/material.dart';

import 'pembayaran_berhasil.dart';

class PembayaranPage extends StatefulWidget {
  final String namaPembeli;
  final String nomorWhatsapp;
  final String alamat;
  final String catatan;
  final int totalPembayaran;

  const PembayaranPage({
    super.key,
    required this.namaPembeli,
    required this.nomorWhatsapp,
    required this.alamat,
    required this.catatan,
    required this.totalPembayaran,
  });

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String metodePembayaran = 'COD';

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

  void prosesPembayaran() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranBerhasilPage(
          namaPembeli: widget.namaPembeli,
          nomorWhatsapp: widget.nomorWhatsapp,
          alamat: widget.alamat,
          catatan: widget.catatan,
          metodePembayaran: metodePembayaran,
          totalPembayaran: widget.totalPembayaran,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              icon: Icons.person_outline,
              title: 'Data Pembeli',
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
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
                  DataRowItem(
                    icon: Icons.person,
                    title: 'Nama',
                    value: widget.namaPembeli,
                  ),
                  const Divider(height: 24),
                  DataRowItem(
                    icon: Icons.phone,
                    title: 'WhatsApp',
                    value: widget.nomorWhatsapp,
                  ),
                  const Divider(height: 24),
                  DataRowItem(
                    icon: Icons.location_on,
                    title: 'Alamat',
                    value: widget.alamat,
                  ),
                  if (widget.catatan.isNotEmpty) ...[
                    const Divider(height: 24),
                    DataRowItem(
                      icon: Icons.note,
                      title: 'Catatan',
                      value: widget.catatan,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            const SectionTitle(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Metode Pembayaran',
            ),

            const SizedBox(height: 12),

            PaymentOption(
              title: 'COD',
              subtitle: 'Bayar saat pesanan diterima',
              icon: Icons.local_shipping_outlined,
              value: 'COD',
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value!;
                });
              },
            ),

            const SizedBox(height: 12),

            PaymentOption(
              title: 'Transfer Bank',
              subtitle: 'Transfer melalui rekening bank',
              icon: Icons.account_balance_outlined,
              value: 'Transfer Bank',
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value!;
                });
              },
            ),

            const SizedBox(height: 12),

            PaymentOption(
              title: 'QRIS',
              subtitle: 'Bayar menggunakan aplikasi e-wallet',
              icon: Icons.qr_code_2,
              value: 'QRIS',
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            const SectionTitle(
              icon: Icons.receipt_long_outlined,
              title: 'Ringkasan Pembayaran',
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
                  const RingkasanPembayaranRow(
                    title: 'Subtotal Produk',
                    value: '-',
                  ),

                  const SizedBox(height: 12),

                  const RingkasanPembayaranRow(
                    title: 'Ongkos Kirim',
                    value: 'Gratis',
                    valueColor: Colors.green,
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  const SizedBox(height: 8),

                  RingkasanPembayaranRow(
                    title: 'Total Pembayaran',
                    value: formatHarga(
                      widget.totalPembayaran,
                    ),
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: prosesPembayaran,
                icon: const Icon(
                  Icons.lock_outline,
                ),
                label: Text(
                  metodePembayaran == 'COD'
                      ? 'Buat Pesanan'
                      : 'Bayar Sekarang',
                  style: const TextStyle(
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
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.green,
                  size: 18,
                ),
                SizedBox(width: 6),
                Text(
                  'Pembayaran aman dan terlindungi',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({
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

class DataRowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DataRowItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.deepPurple,
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? Colors.deepPurple
                : Colors.grey.shade200,
            width: selected ? 1.8 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected
                    ? Colors.deepPurple.shade50
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: selected
                    ? Colors.deepPurple
                    : Colors.grey.shade600,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? Colors.deepPurple
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: groupValue,
              activeColor: Colors.deepPurple,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class RingkasanPembayaranRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;
  final Color? valueColor;

  const RingkasanPembayaranRow({
    super.key,
    required this.title,
    required this.value,
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
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
            color: isTotal
                ? Colors.black
                : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 21 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.w600,
            color: valueColor ??
                (isTotal
                    ? Colors.deepPurple
                    : Colors.black87),
          ),
        ),
      ],
    );
  }
}