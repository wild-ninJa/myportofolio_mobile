import 'dart:ui';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506589036";
  final String nama = "Husainah Syamsiah";
  final String kelas = "PBP B";

  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder, const Color(0xFF26C6DA)),
    ItemHomepage("Tambah Proyek", Icons.add_circle, const Color(0xFF29B6F6)),
    ItemHomepage("Lihat Experience", Icons.folder, const Color(0xFF66BB6A)),
    ItemHomepage(
      "Tambah Experience",
      Icons.add_circle,
      const Color(0xFF9CCC65),
    ),
    ItemHomepage("Logout", Icons.logout, const Color(0xFFFFA726)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color(0x66006080),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Sky-to-grass background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE), Color(0xFFC8E6C9)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(top: 120, left: -40, child: Bubble(size: 160)),
            const Positioned(top: 300, right: -30, child: Bubble(size: 120)),
            const Positioned(bottom: 80, left: 60, child: Bubble(size: 90)),
            const Positioned(bottom: -30, right: 120, child: Bubble(size: 140)),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 72, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InfoCard(title: 'NPM', content: npm),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InfoCard(title: 'Name', content: nama),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InfoCard(title: 'Class', content: kelas),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome to MyPortfolio',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01579B),
                        shadows: [Shadow(color: Colors.white, blurRadius: 8)],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.extent(
                      primary: false,
                      shrinkWrap: true,
                      maxCrossAxisExtent: 160,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      padding: const EdgeInsets.all(8),
                      children: items.map((item) => ItemCard(item)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Decorative glossy bubble
class Bubble extends StatelessWidget {
  final double size;
  const Bubble({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.4, -0.5),
          colors: [
            Colors.white.withAlpha(200),
            Colors.white.withAlpha(60),
            Colors.lightBlueAccent.withAlpha(40),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        border: Border.all(color: Colors.white.withAlpha(150), width: 1.5),
      ),
    );
  }
}

// Frosted-glass info card
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white.withAlpha(190), Colors.white.withAlpha(90)],
            ),
            border: Border.all(color: Colors.white.withAlpha(220), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0288D1).withAlpha(50),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF0277BD)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}