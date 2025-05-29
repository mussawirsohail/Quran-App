import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lecture02mushaf/AudioIndexSurah.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashSCR(),
    );
  }
}

class SplashSCR extends StatefulWidget {
  const SplashSCR({super.key});

  @override
  State<SplashSCR> createState() => _SplashSCRState();
}

class _SplashSCRState extends State<SplashSCR> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ButtonScreen(),
            ));
      },
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/quran.png")),
    );
  }
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo with shadow
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.2),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "assets/images/quran.png",
                    width: 80,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Quran Mushaf",
                style: GoogleFonts.amiriQuran(
                  fontSize: 36,
                  color: Colors.teal[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Listen & Read the Holy Quran",
                style: GoogleFonts.amiriQuran(
                  fontSize: 18,
                  color: Colors.teal[700],
                ),
              ),
              SizedBox(height: 40),
              // Custom Buttons
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                ),
                icon: Icon(Icons.headphones_rounded, size: 28),
                label: Text(
                  "Recitation | Mushaf",
                  style: GoogleFonts.amiriQuran(fontSize: 22),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Audioindexsurah(),
                    ),
                  );
                },
              ),
              SizedBox(height: 18),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 2,
                ),
                icon: Icon(Icons.menu_book_rounded, size: 28),
                label: Text(
                  "Read | Mushaf",
                  style: GoogleFonts.amiriQuran(fontSize: 22),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahIndexSCR(),
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              // Decorative Divider
              Row(
                children: [
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.teal[200])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.star, color: Colors.teal[300]),
                  ),
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.teal[200])),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Developed by Mussawir Sohail",
                style: TextStyle(
                  color: Colors.teal[300],
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SurahIndexSCR extends StatefulWidget {
  const SurahIndexSCR({super.key});

  @override
  State<SurahIndexSCR> createState() => _SurahIndexSCRState();
}

class _SurahIndexSCRState extends State<SurahIndexSCR> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Read Mushaf',
          style:
              GoogleFonts.amiriQuran(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        backgroundColor: Colors.teal[900],
        foregroundColor: Colors.white,
        elevation: 2,
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
                        builder: (context) => DetailSurah(index + 1),
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
                      Icon(Icons.menu_book_rounded,
                          size: 16, color: Colors.teal[700]),
                      SizedBox(width: 4),
                      Text(
                        quran.getSurahNameEnglish(index + 1),
                        style: GoogleFonts.amiriQuran(
                          fontSize: 16,
                          color: Colors.teal[700],
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    height: 44,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        quran.getPlaceOfRevelation(index + 1) == "Makkah"
                            ? Tooltip(
                                message: "Makki Surah",
                                child: Image.asset(
                                  "assets/images/kaaba.jpg",
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Tooltip(
                                message: "Madani Surah",
                                child: Image.asset(
                                  "assets/images/madina.jpg",
                                  width: 22,
                                  height: 22,
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
                              fontSize: 10,
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

class DetailSurah extends StatefulWidget {
  var surahNumber;
  DetailSurah(this.surahNumber, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahName(widget.surahNumber)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(widget.surahNumber),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  quran.getVerse(widget.surahNumber, index + 1,
                      verseEndSymbol: true),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.amiriQuran(),
                ),
                subtitle: Text(
                  quran.getVerseTranslation(
                    widget.surahNumber,
                    translation: quran.Translation.urdu,
                    index + 1,
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: "jameel"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
