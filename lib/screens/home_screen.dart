import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'excercise_screen.dart';
import '../screens/excersize_hub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'excercise_start_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiURL =
      'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json';

  ExcersizeHub? excersizehub;
  @override
  void initState() {
    getExcersize();
    super.initState();
  }

  Future<ExcersizeHub> getExcersize() async {
    var response = await http.get(Uri.parse(apiURL));
    var body = response.body;
    var decode = jsonDecode(body);
    excersizehub = ExcersizeHub.fromJson(decode);
    setState(() {});
    return excersizehub!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: Container(
        child: excersizehub != null
            ? ListView(
                children: excersizehub!.exercises!.map((e) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExerciseStartScreen(
                                  exercises: e,
                                )));
                  },
                  child: Hero(
                    tag: e.id!,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // child: FadeInImage(
                            //   placeholder:
                            //       AssetImage('assets/logo_foreground.png'),
                            //   image: NetworkImage(e.thumbnail),
                            //   width: MediaQuery.of(context).size.width,
                            //   height: 250,
                            //   fit: BoxFit.cover,
                            // ),
                            child: CachedNetworkImage(
                              imageUrl: e.thumbnail,
                              placeholder: (context, url) => Image(
                                image: AssetImage('assets/logo_round.png'),
                                fit: BoxFit.cover,
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 261,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF000000),
                                    Color(0x00000000),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            height: 250,
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Text(
                              e.title!,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList())
            : LinearProgressIndicator(),
      ),
    );
  }
}
