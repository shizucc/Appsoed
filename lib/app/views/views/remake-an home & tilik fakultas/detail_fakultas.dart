import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> fetchData(idFakultas) async {
  final response = await http
      .get(Uri.parse('https://api.bem-unsoed.com/api/faculty/${idFakultas}'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class DetailFakultas extends StatefulWidget {
  const DetailFakultas({super.key, required this.idFakultas});
  final dynamic idFakultas;

  @override
  State<DetailFakultas> createState() => _DetailFakultasState();
}

Future<void> openSomething(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

enum AppBarState { expanded, collapsed }

class _DetailFakultasState extends State<DetailFakultas> {
  final ScrollController _scrollController = ScrollController();
  late AppBarState _appBarState;
  late dynamic fakultas;

  @override
  void initState() {
    super.initState();
    _appBarState = AppBarState.expanded;
    _scrollController.addListener(_handleScroll);
    fakultas = fetchData(widget.idFakultas);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 150 &&
        _appBarState == AppBarState.expanded) {
      setState(() {
        _appBarState = AppBarState.collapsed;
      });
    } else if (_scrollController.offset <= 150 &&
        _appBarState == AppBarState.collapsed) {
      setState(() {
        _appBarState = AppBarState.expanded;
      });
    }
  }

  Future<dynamic> displayFakultas() async {
    return fakultas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
          floating: true,
          backgroundColor: const Color(0xffFDB731),
          // backgroundColor: Colors.transparent,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder(
                  future: displayFakultas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var dataFakultas = snapshot.data;
                      final String image = dataFakultas['image'] ?? '';
                      final String name = dataFakultas['name'] ?? '';
                      return Stack(
                        children: [
                          Image.network(
                            "https://api.bem-unsoed.com/api/faculty/image/${image}",
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 200),
                              padding: EdgeInsets.only(left: 10),
                              // height: MediaQuery.of(context).size.height,
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                stops: [0.1, 0.5],
                              )),
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      );
                    }
                  }))),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.black,
          // ),
          padding: const EdgeInsets.only(bottom: 30),
          child: FutureBuilder(
              future: displayFakultas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var dataFakultas = snapshot.data;
                  final String name = dataFakultas['name'] ?? '';
                  final String location = dataFakultas['location'] ?? '';
                  final String description = dataFakultas['description'] ?? '';
                  final String instagram_link =
                      dataFakultas['instagram_link'] ?? '';
                  final String youtube_link =
                      dataFakultas['youtube_link'] ?? '';
                  final String line_link = dataFakultas['line_link'] ?? '';
                  final String twitter_link =
                      dataFakultas['twitter_link'] ?? '';
                  final String spotify_link =
                      dataFakultas['spotify_link'] ?? '';
                  final String tiktok_link = dataFakultas['tiktok_link'] ?? '';
                  final String website_link =
                      dataFakultas['website_link'] ?? '';

                  return Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Lokasi Fakultas",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                                onTap: () => {openSomething(location)},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2Flocation_kost.png?alt=media&token=ed7d705d-8511-4286-b75e-f725d723cb80",
                                    height: 150,
                                  ),
                                )),
                            const SizedBox(height: 30),
                            Text(
                              "Tentang ${name}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${description}",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Media Sosial",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => {openSomething(instagram_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FInstagram.png?alt=media&token=dab6d85e-b813-4024-85fa-40d9c4fe2cf9",
                                    width: 55,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {openSomething(youtube_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FYouTube.png?alt=media&token=37bc4981-01d7-4af1-b0bd-3bbbb5e7dc41",
                                    width: 55,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {openSomething(line_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FLine.png?alt=media&token=527bf76b-d1a7-466f-9f54-8f7278bc290d",
                                    width: 55,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {openSomething(twitter_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FTwitter.png?alt=media&token=a7e5ca14-ce2f-4f4d-84a8-37c2acce0fc4",
                                    width: 55,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {openSomething(spotify_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FSpotify.png?alt=media&token=6ff92dbb-5868-41ec-934a-ac969210907f",
                                    width: 55,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {openSomething(tiktok_link)},
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FIcon%2FTikTok.png?alt=media&token=fd478a0f-28cd-4baa-b7e5-ce1d6804a43f",
                                    width: 55,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: Text(
                                "Informasi lebih lanjut dapat dilihat di :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                // color: Colors.white,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () => {openSomething(website_link)},
                                  child: Text(
                                    "Website",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ]));
                }
              }),
        ),
      ]))
    ]));
  }
}
