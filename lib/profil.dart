import 'package:flutter/material.dart';
import 'main.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7B4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ICON TOKO
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront,
                  color: Colors.deepPurple,
                  size: 60,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'SinaRi Hijab',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Hijab Modern, Elegan dan Berkualitas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              // TENTANG SINARI HIJAB
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tentang SinaRi Hijab',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      'SinaRi Hijab merupakan usaha yang menyediakan '
                          'berbagai pilihan hijab modern, nyaman, elegan, '
                          'dan berkualitas. Produk kami cocok digunakan '
                          'untuk kegiatan sehari-hari maupun acara khusus.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // JUDUL TIM
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tim SinaRi Hijab',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const TeamCard(
                icon: Icons.workspace_premium,
                title: 'Owner Hijab',
                name: 'Sahriah',
              ),

              const SizedBox(height: 14),

              const TeamCard(
                icon: Icons.computer,
                title: 'IT Developer',
                name: 'Muhammad Rizky Aulia',
              ),

              const SizedBox(height: 14),

              const TeamCard(
                icon: Icons.campaign,
                title: 'Promosi & Marketing',
                name: 'Siti Patimah',
              ),

              const SizedBox(height: 14),

              const TeamCard(
                icon: Icons.trending_up,
                title: 'Promosi & Marketing',
                name: 'M. Zaini',
              ),

              const SizedBox(height: 30),

              // PESAN PENUTUP
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 40,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Terima kasih telah menggunakan aplikasi SinaRi Hijab',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                '© 2026 SinaRi Hijab',
                style: TextStyle(
                  color: Colors.grey,
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

class TeamCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String name;

  const TeamCard({
    super.key,
    required this.icon,
    required this.title,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xffEEE8FF),
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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