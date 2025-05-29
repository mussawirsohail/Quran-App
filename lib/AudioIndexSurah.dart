import 'package:flutter/material.dart';
import 'package:lecture02mushaf/DetailAudioSurah.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class Audioindexsurah extends StatefulWidget {
  const Audioindexsurah({super.key});

  @override
  State<Audioindexsurah> createState() => _AudioindexsurahState();
}

class _AudioindexsurahState extends State<Audioindexsurah> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Audio Surah Index',
          style:
              GoogleFonts.amiriQuran(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        backgroundColor: Colors.teal[900],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // You can implement search functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
            childAspectRatio: 2.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: quran.totalSurahCount,
          itemBuilder: (context, index) {
            final isHovered = hoveredIndex == index;
            return MouseRegion(
              onEnter: (_) => setState(() => hoveredIndex = index),
              onExit: (_) => setState(() => hoveredIndex = null),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isHovered ? Colors.teal[100] : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    if (isHovered)
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                  ],
                  border: Border.all(
                    color: isHovered ? Colors.teal : Colors.grey.shade300,
                    width: isHovered ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailaudiosurah(index + 1),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor:
                        isHovered ? Colors.teal[900] : Colors.teal[200],
                    child: Text(
                      "${index + 1}",
                      style: GoogleFonts.amiriQuran(
                        color: isHovered ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    quran.getSurahNameArabic(index + 1),
                    style: GoogleFonts.amiriQuran(
                      fontSize: 22,
                      color: isHovered ? Colors.teal[900] : Colors.black,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.teal[700]),
                      SizedBox(width: 4),
                      Text(
                        "شیخ مشاری راشد العفاسی",
                        style: GoogleFonts.amiriQuran(
                          fontSize: 16,
                          color: Colors.teal[700],
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    height: 36, // Further reduced height to prevent overflow
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isHovered)
                          quran.getPlaceOfRevelation(index + 1) == "Makkah"
                              ? Tooltip(
                                  message: "Makki Surah",
                                  child: Image.asset(
                                    "assets/images/kaaba.jpg",
                                    width: 16, // Further reduced width
                                    height: 16, // Further reduced height
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Tooltip(
                                  message: "Madani Surah",
                                  child: Image.asset(
                                    "assets/images/madina.jpg",
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        SizedBox(height: 2),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Verses: ${quran.getVerseCount(index + 1)}",
                            style: TextStyle(
                              fontSize: 10, // Smaller font
                              color: Colors.teal[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  tileColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
