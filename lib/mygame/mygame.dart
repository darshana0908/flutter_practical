import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_in/db/sqldb.dart';
import 'package:flutter_in/widget/list.dart';

import '../game_details/game_detais.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  SqlDb sqlDb = SqlDb();
  List gamelength = [];
  @override
  void initState() {
    myGameView();
    // TODO: implement initState
    super.initState();
  }

  myGameView() async {
    gamelength = await sqlDb.readData('Select * from gamelist ');
    log(gamelength.toString());
    setState(() {
      gamelength;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView.builder(
              itemCount: gamelength.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameDetails(
                                  description: gamelength[index]
                                          ['short_description']
                                      .toString(),
                                  deverloper:
                                      gamelength[index]['developer'].toString(),
                                  genre: gamelength[index]['genre'].toString(),
                                  id: gamelength[index]['id'].toString(),
                                  img:
                                      gamelength[index]['thumbnail'].toString(),
                                  platform:
                                      gamelength[index]['platform'].toString(),
                                  release: gamelength[index]['release_date']
                                      .toString(),
                                  title: gamelength[index]['title'].toString(),
                                )));
                  },
                  child: Card(
                    child: ListTile(
                      leading: SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.network(
                              '${gamelength[index]['thumbnail']}')),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${gamelength[index]['id']}'),
                              SingleChildScrollView(
                                child: SizedBox(
                                    width: 100,
                                    child:
                                        Text('${gamelength[index]['title']}')),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
