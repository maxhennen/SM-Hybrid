import 'package:flutter/material.dart';

import 'DjPlayScreen.dart';

class DjPlaylistScreen extends StatefulWidget {
  @override
  _DjPlay createState() => new _DjPlay();
}

var blueColor = Color(0xFF090e42);
var pinkColor = Color(0xFFff6b80);

var mm = '🎵';

var flume = 'https://i.scdn.co/image/8d84f7b313ca9bafcefcf37d4e59a8265c7d3fff';
var martinGarrix =
    'https://c1.staticflickr.com/2/1841/44200429922_d0cbbf22ba_b.jpg';
var rosieLowe =
    'https://i.scdn.co/image/db8382f6c33134111a26d4bf5a482a1caa5f151c';

class _DjPlay extends State<DjPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 32.0),
              CustomTextField(),
              SizedBox(height: 32.0),
              Text(
                'Collections',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 38.0),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  ItemCard('assets/images/blue.jpg', 'Extremely loud'),
                  SizedBox(
                    width: 16.0,
                  ),
                  ItemCard('assets/images/pink.jpg', 'Calm & relaxing'),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              Row(
                children: <Widget>[
                  ItemCard('assets/images/orange.jpg', 'Extremely loud'),
                  SizedBox(
                    width: 16.0,
                  ),
                  ItemCard('assets/images/yellow.jpg', 'Old Soul'),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                'Recommend',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 38.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              SongItem('In the Name of Love', 'Martin Garrix', martinGarrix),
              SongItem('Never Be Like You', 'Flume', flume),
              SongItem('Worry Bout Us', 'Rosie Lowe', rosieLowe),
              SongItem('In the Name of Love', 'Martin Garrix', martinGarrix),
              SongItem('In the Name of Love', 'Martin Garrix', martinGarrix),
            ],
          ),
        ));
  }
}

class SongItem extends StatelessWidget {
  final title;
  final artist;
  final image;

  SongItem(this.title, this.artist, this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DjPlayScreen(title, artist, image)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 80.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                    height: 80.0,
                    width: 80.0,
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white.withOpacity(0.7),
                      size: 42.0,
                    ))
              ],
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  artist,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 18.0),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.more_horiz,
              color: Colors.white.withOpacity(0.6),
              size: 32.0,
            )
          ],
        ),
      ),
    );
  }
}



class ItemCard extends StatelessWidget {
  final image;
  final title;

  ItemCard(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120.0,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 140.0,
                      width: double.infinity,
                    )),
                Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white.withOpacity(0.6),
                    size: 24.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.16),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8.0,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search music...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Icon(
            Icons.mic,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}
