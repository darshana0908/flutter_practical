import 'dart:developer';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in/db/sqldb.dart';
import 'package:flutter_in/game_details/game_detais.dart';

class GameOfGame extends StatelessWidget {
  const GameOfGame({
    super.key,
    required this.gamelength,
  });
  final List gamelength;

  @override
  Widget build(BuildContext context) {
    SqlDb sqlDb = SqlDb();
    return Container(
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
                              img: gamelength[index]['thumbnail'].toString(),
                              platform:
                                  gamelength[index]['platform'].toString(),
                              release:
                                  gamelength[index]['release_date'].toString(),
                              title: gamelength[index]['title'].toString(),
                            )));
              },
              child: Card(
                child: ListTile(
                  leading: SizedBox(
                      height: 120,
                      width: 120,
                      child:
                          Image.network('${gamelength[index]['thumbnail']}')),
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
                                child: Text('${gamelength[index]['title']}')),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                var res = await sqlDb.insertData(
                                    "INSERT INTO gamelist ('thumbnail','title','genre','platform','developer','release_date','short_description','id') VALUES('${gamelength[index]['thumbnail']}','${gamelength[index]['title']}','${gamelength[index]['genre']}','${gamelength[index]['platform']}','${gamelength[index]['developer']}','${gamelength[index]['release_date']}','${gamelength[index]['short_description']}','${gamelength[index]['id']}')");
                                log(res.toString());
                                log('id');
                              },
                              icon: Icon(Icons.download)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
