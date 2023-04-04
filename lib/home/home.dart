import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_in/mygame/mygame.dart';
import 'package:flutter_in/widget/list.dart';
import '../widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List gameList = [];
  List browserGames = [];
  List pcGames = [];
  String selectedCategory = 'shooter';
  @override
  void initState() {
    allgame();
    browse();
    pcgame();

    super.initState();
  }

  allgame() async {
    final response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      setState(() {
        gameList = jsonDecode(response.body.toString());
        log(gameList.toString());
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

    }
  }

  CategoryGame() async {
    final response = await http.get(Uri.parse(
        'https://www.freetogame.com/api/games?platform=browser&category=$selectedCategory'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      setState(() {
        browserGames = jsonDecode(response.body.toString());
        log(browserGames.toString());
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

    }
    final res = await http.get(Uri.parse(
        'https://www.freetogame.com/api/games?platform=pc&category=$selectedCategory'));

    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      setState(() {
        pcGames = jsonDecode(res.body.toString());
        log(pcGames.toString());
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

    }
  }

  browse() async {
    log(selectedCategory);
    final response = await http.get(
        Uri.parse('https://www.freetogame.com/api/games?platform=browser'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      browserGames = jsonDecode(response.body);

      setState(() {
        for (var element in gameList) {
          if (element['platform'] == 'Browser') {
            browserGames.add(element);
          } else if (element['platform'] == '"PC (Windows)') {
            pcGames.add(element);
          }
        }
      });

      print(gameList);

      // setState(() {
      //   browserGames =
      //   log(gameList.toString());
      // });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

    }
  }

  pcgame() async {
    final response = await http
        .get(Uri.parse('https://www.freetogame.com/api/games?platform=pc'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      setState(() {
        pcGames = jsonDecode(response.body.toString());
        log(gameList.toString());
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 132, 130, 123),
          child: Padding(
            padding: const EdgeInsets.only(top: 100, right: 10, left: 10),
            child: Column(children: [
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'shooter');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: MyWidget(name: 'shooter'),
              ),
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'strategy');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: const MyWidget(
                  name: 'strategy',
                ),
              ),
              const MyWidget(
                name: 'racing',
              ),
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'sports');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: const MyWidget(
                  name: 'sports',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'social');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: const MyWidget(
                  name: 'social',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'open-world');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: const MyWidget(
                  name: 'open-world',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => selectedCategory = 'zombie');
                  print(selectedCategory);

                  CategoryGame();
                  Navigator.pop(context);
                },
                child: const MyWidget(
                  name: 'zombie',
                ),
              )
            ]),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyGame()));
                },
                icon: const Icon(Icons.favorite))
          ],
          bottom: const TabBar(tabs: [
            Tab(child: Text('All')),
            Tab(child: Text('Browser')),
            Tab(child: Text('Pc'))
          ]),
        ),
        body: TabBarView(children: [
          GameOfGame(gamelength: gameList),
          GameOfGame(gamelength: browserGames),
          GameOfGame(gamelength: pcGames),
        ]),
      ),
    );
  }
}
