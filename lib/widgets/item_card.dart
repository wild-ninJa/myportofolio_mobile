import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// Glossy "Aero button" card
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(item.color, Colors.white, 0.25)!,
            item.color,
            Color.lerp(item.color, Colors.black, 0.15)!,
          ],
        ),
        border: Border.all(color: Colors.white.withAlpha(220), width: 2),
        boxShadow: [
          BoxShadow(
            color: item.color.withAlpha(120),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Glass shine on the top half
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withAlpha(150),
                        Colors.white.withAlpha(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          "Kamu telah menekan tombol ${item.name}!",
                        ),
                      ),
                    );

                  // Navigate ke halaman yang sesuai
                  if (item.name == "Tambah Proyek") {
                    // TODO: Gunakan Navigator.push() untuk melakukan navigasi ke MaterialPageRoute yang mencakup ProjectFormPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProjectFormPage(),
                      ),
                    );
                  } else if (item.name == "Tambah Experience") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExperienceFormPage(),
                      ),
                    );
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.white,
                          size: 34,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
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
