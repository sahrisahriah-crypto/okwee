import 'package:flutter/material.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
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
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifikasi Terbaru',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lihat informasi promo dan pesananmu',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: const [
                NotificationItem(
                  icon: Icons.local_offer,
                  title: 'Promo Spesial',
                  message:
                  'Dapatkan diskon hingga 15% untuk pembelian hijab pilihan.',
                  time: '5 menit lalu',
                  isNew: true,
                ),

                SizedBox(height: 14),

                NotificationItem(
                  icon: Icons.shopping_bag,
                  title: 'Pesanan Diproses',
                  message:
                  'Pesanan Hijab Pashmina Premium sedang diproses oleh penjual.',
                  time: '30 menit lalu',
                  isNew: true,
                ),

                SizedBox(height: 14),

                NotificationItem(
                  icon: Icons.local_shipping,
                  title: 'Pesanan Dikirim',
                  message:
                  'Pesananmu telah dikirim dan sedang menuju alamat tujuan.',
                  time: '2 jam lalu',
                  isNew: false,
                ),

                SizedBox(height: 14),

                NotificationItem(
                  icon: Icons.payment,
                  title: 'Pembayaran Berhasil',
                  message:
                  'Pembayaran sebesar Rp300.000 telah berhasil diterima.',
                  time: 'Kemarin',
                  isNew: false,
                ),

                SizedBox(height: 14),

                NotificationItem(
                  icon: Icons.star,
                  title: 'Beri Penilaian',
                  message:
                  'Jangan lupa memberikan penilaian untuk produk yang sudah diterima.',
                  time: '2 hari lalu',
                  isNew: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool isNew;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew
            ? Colors.deepPurple.shade50
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isNew
              ? Colors.deepPurple.shade100
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (isNew)
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
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