
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget{
  final AudioPlayer advancedPlayer;
  const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AudioFileState createState()=> _AudioFileState();
}

class _AudioFileState extends State<AudioFile>{
  Duration _duration = new Duration();
  int da = 1000;
  Duration _position = new Duration();
  final String path = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
    Icons.fast_forward,
    Icons.slow_motion_video,
    Icons.repeat,
    Icons.shuffle,
  ];

  @override
  void initState(){
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((Duration d) { //get the duration of audio
           da = d.inSeconds; 
           setState(() {
           });
       });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {
      _position=p;
    }); });
    this.widget.advancedPlayer.setUrl(path);
    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }
        else{
        isPlaying = false;
        isRepeat = false;
        }
      });
    });
  }
  Widget btnStart(){
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon : isPlaying==false?Icon(_icons[0],size: 50,):Icon(_icons[1],size: 50,),
      onPressed: (){
        if(isPlaying==false){
        this.widget.advancedPlayer.resume();
        setState(() {
          isPlaying = true;
        });
        }
        else if(isPlaying==true){
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
      },
    );
  }

  Widget btnFastt(){
    return 
    IconButton(
      
        padding: const EdgeInsets.only(bottom: 10),
        icon : Icon(_icons[2],size: 25,),
        color: Colors.black,
      
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

    Widget btnSlow(){
    return IconButton(
      icon : ImageIcon(
        AssetImage('./images/next.png'),
        size: 10,
        color: Colors.blue,
      ),
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

      Widget btnRepeat(){
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon :Icon(_icons[4],size: 15),
      color: color,
      onPressed: (){
        if(isRepeat==false){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState((){
            isRepeat=true;
            color=Colors.blue;
          });
        }else if(isRepeat==true){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState((){
            isRepeat=false;
            color=Colors.black;
          });
        }
      },
    );
  }

Widget btnLoop(){
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon :Icon(_icons[5],size: 15),
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget slider(){
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value){
        setState(() {
          changeToSecond(value.toInt());
          value= value;
        });
      },
    );
  }
  void changeToSecond(int second){
    Duration newDu = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDu);
  }

  Widget loadAsset(){
    return
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            btnRepeat(),
            btnSlow(),
            btnStart(),
            btnFastt(),
            btnLoop(),
          ],
        ),
      );
  }



    @override
  Widget build(BuildContext context){
    return Container(
      child:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split(".")[0],style: TextStyle(fontSize: 16),),
                Text(da.toString(),style: TextStyle(fontSize: 16),)
              ],
            )
            ),
            
           // slider(),
            loadAsset(),
        ],
      ),
    );
  }
}