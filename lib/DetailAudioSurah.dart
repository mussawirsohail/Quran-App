import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class Detailaudiosurah extends StatefulWidget {
  final int indexSurahNumber;
  Detailaudiosurah(this.indexSurahNumber, {super.key});

  @override
  State<Detailaudiosurah> createState() => _DetailaudiosurahState();
}

class _DetailaudiosurahState extends State<Detailaudiosurah> {
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playpausebtn = Icons.play_arrow_rounded;
  bool isplaying = true;

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Future<void> meratoggleBtn() async {
    try {
      final audiourl = await quran.getAudioURLBySurah(widget.indexSurahNumber);
      await audioPlayer.setUrl(audiourl);

      if (isplaying) {
        audioPlayer.play();
        setState(() {
          isplaying = false;
          playpausebtn = Icons.pause_circle_rounded;
        });
      } else {
        audioPlayer.pause();
        setState(() {
          isplaying = true;
          playpausebtn = Icons.play_arrow_rounded;
        });
      }
    } catch (e) {
      print("There is an issue $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final surahName = quran.getSurahNameArabic(widget.indexSurahNumber);
    final surahEnglish = quran.getSurahNameEnglish(widget.indexSurahNumber);
    final revelation = quran.getPlaceOfRevelation(widget.indexSurahNumber);
    final verseCount = quran.getVerseCount(widget.indexSurahNumber);

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          surahName,
          style:
              GoogleFonts.amiriQuran(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        backgroundColor: Colors.teal[900],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Surah Info Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          surahName,
                          style: GoogleFonts.amiriQuran(
                            fontSize: 38,
                            color: Colors.teal[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          surahEnglish,
                          style: GoogleFonts.amiriQuran(
                            fontSize: 20,
                            color: Colors.teal[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            revelation == "Makkah"
                                ? Image.asset("assets/images/kaaba.jpg",
                                    width: 28, height: 28)
                                : Image.asset("assets/images/madina.jpg",
                                    width: 28, height: 28),
                            SizedBox(width: 8),
                            Text(
                              revelation == "Makkah"
                                  ? "Makki Surah"
                                  : "Madani Surah",
                              style: TextStyle(
                                color: Colors.teal[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.format_list_numbered,
                                color: Colors.teal[700], size: 20),
                            SizedBox(width: 4),
                            Text(
                              "$verseCount verses",
                              style: TextStyle(
                                color: Colors.teal[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // Reciter Image & Audio Controls
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.teal[200]!, Colors.teal[900]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.18),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 100,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/alaffasy.png",
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      child: Material(
                        color: Colors.teal[900],
                        shape: CircleBorder(),
                        elevation: 6,
                        child: IconButton(
                          icon:
                              Icon(playpausebtn, color: Colors.white, size: 48),
                          onPressed: meratoggleBtn,
                          splashRadius: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Text(
                  "Recitation by Sheikh Mishary Rashid Alafasy",
                  style: GoogleFonts.amiriQuran(
                    fontSize: 18,
                    color: Colors.teal[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
