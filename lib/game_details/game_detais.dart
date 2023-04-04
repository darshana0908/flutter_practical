import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GameDetails extends StatelessWidget {
  const GameDetails(
      {super.key,
      required this.description,
      required this.deverloper,
      required this.genre,
      required this.id,
      required this.img,
      required this.platform,
      required this.release,
      required this.title});

  final String id;
  final String title;
  final String img;
  final String description;
  final String genre;
  final String platform;
  final String deverloper;
  final String release;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.network(
                img,
                fit: BoxFit.fill,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('id:' + id),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'title: ' + title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('genre: ' + genre),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('platform: ' + platform),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('deverloper: ' + deverloper),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('release date : ' + release),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('description:  ' + description),
              )
            ],
          ),
        )
      ]),
    );
  }
}
