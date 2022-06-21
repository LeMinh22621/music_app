import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/view/widgets/audio_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/view/widgets/app_colors.dart' as AppColors;
import 'package:music_app/view/widgets/audio_bar.dart';

class DetailAudioPage extends StatefulWidget {
  const DetailAudioPage({Key? key}) : super(key: key);

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer advancePlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: AppColors.starColor,
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    advancePlayer.stop();
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {},
                  )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  const Text(
                    "The Song",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Avenir'),
                  ),
                  const Text(
                    'data',
                    style: TextStyle(fontSize: 20),
                  ),
                  AudioFile(advancedPlayer: advancePlayer),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 150) / 2,
            height: screenHeight * 0.16,
            right: (screenWidth - 150) / 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                color: AppColors.audioGreyBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: const DecorationImage(
                        image: AssetImage('images/mtp.jpg'), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
