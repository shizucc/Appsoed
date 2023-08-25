import 'dart:convert';
import 'package:appsoed/app/views/views/remake-an%20home%20&%20tilik%20fakultas/detail_fakultas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  final response =
      await http.get(Uri.parse('https://api.bem-unsoed.com/api/faculty'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class ShowData extends StatelessWidget {
  const ShowData({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Faculties(faculties: snapshot.data);
          }
        });
  }
}

class Faculties extends StatelessWidget {
  const Faculties({super.key, required this.faculties});
  final List<dynamic> faculties;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 30,
        children: faculties.map((faculty) {
          return Fakultas(
              id: faculty['id'],
              name: faculty['name'].toString(),
              alias: faculty['alias'].toString(),
              location: faculty['location'].toString(),
              image: faculty['image'].toString(),
              description: faculty['description'].toString(),
              instagram_link: faculty['instagram_link'].toString(),
              youtube_link: faculty['youtube_link'].toString(),
              line_link: faculty['line_link'].toString(),
              twitter_link: faculty['twitter_link'].toString(),
              spotify_link: faculty['spotify_link'].toString(),
              tiktok_link: faculty['tiktok_link'].toString(),
              website_link: faculty['website_link'].toString());
        }).toList());
  }
}

class Fakultas extends StatelessWidget {
  const Fakultas(
      {super.key,
      required this.id,
      required this.name,
      required this.alias,
      required this.location,
      required this.image,
      required this.description,
      required this.instagram_link,
      required this.youtube_link,
      required this.line_link,
      required this.twitter_link,
      required this.tiktok_link,
      required this.spotify_link,
      required this.website_link});

  final dynamic id;
  final String name;
  final String alias;
  final String location;
  final String image;
  final String description;
  final String instagram_link;
  final String youtube_link;
  final String line_link;
  final String twitter_link;
  final String spotify_link;
  final String tiktok_link;
  final String website_link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailFakultas(idFakultas: id)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Image.network(
                        "https://api.bem-unsoed.com/api/faculty/image/${image}",
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alias,
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 150,
                          ),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TilikFakultas extends StatefulWidget {
  const TilikFakultas({super.key});

  @override
  State<TilikFakultas> createState() => _TilikFakultasState();
}

enum AppBarState { expanded, collapsed }

class _TilikFakultasState extends State<TilikFakultas> {
  final ScrollController _scrollController = ScrollController();
  late AppBarState _appBarState;

  @override
  void initState() {
    super.initState();
    _appBarState = AppBarState.expanded;
    _scrollController.addListener(_handleScroll);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        // pinned: true,
        floating: true,
        backgroundColor: const Color(0xffFDB731),
        expandedHeight: 120,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FFakultasBanner.png?alt=media&token=76751c76-aa80-4954-b2d7-92907f2f9d23",
            fit: BoxFit.cover,
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            color: const Color(0xffFDB731),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Taukah kamu ?",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffFFFFFF)),
                ),
                SizedBox(height: 5),
                Text(
                  "Ada 16 Fakultas di UNSOED lohh",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffFFFFFF)),
                ),
              ],
            )),
        Container(
            color: const Color.fromRGBO(241, 239, 239, 1),
            child: Stack(children: [
              Container(
                  color: _appBarState == AppBarState.expanded
                      ? const Color.fromRGBO(255, 183, 49, 1)
                      : Colors.transparent,
                  height: 60),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                      alignment: Alignment.topCenter,
                      // padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _appBarState == AppBarState.expanded
                              ? const Color.fromRGBO(241, 239, 239, 1)
                              : const Color.fromRGBO(241, 239, 239, 1)),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 10, right: 10),
                                child: const Column(
                                  children: <Widget>[ShowData()],
                                ))
                          ]))))
            ]))
      ]))
    ]));
  }
}
