import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum AppBarState { expanded, collapsed }

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  late AppBarState _appBarState;

  final List<String> imgList = [
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FSoedirman%20Student%20Summit.png?alt=media&token=18959a10-40db-4280-b6dc-1a98c07f468a",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FSoedirman%20Digital%20School.png?alt=media&token=17194dd4-02d9-4736-869a-9dbe7dbf47dc",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FSchool%20of%20Leadership%20Organization.png?alt=media&token=6c6d179e-cf38-4ec1-88d0-14faeb6d8b5b",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FSTARFEST.png?alt=media&token=765d4446-efd7-4d35-bc03-0fa6f50df2ce",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FDesa%20Cita.png?alt=media&token=4aba3fad-7c6d-413f-8e73-e5ad47d1a9c3",
  ];

  final List<Widget> imageSliders = [
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FCarousel%2FDesa%20Cita.png?alt=media&token=95aafe0c-9f22-4fc4-a3c9-3ffc38519461",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FCarousel%2FSTARFEST.png?alt=media&token=48247f53-e3ff-4c4d-b938-458406cff427",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FCarousel%2FSchool%20of%20Leadership%20Organization.png?alt=media&token=e02475b4-4b12-4572-9500-b33680a0dac8",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FCarousel%2FSoedirman%20Digital%20School.png?alt=media&token=cdb68cc4-57bc-4967-9ce7-5f7361a81aaa",
    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FCarousel%2FSoedirman%20Student%20Summit.png?alt=media&token=156a48a6-55b5-4f12-aca8-9b036b62da50",
  ]
      .map((item) => Container(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    ],
                  )),
            ),
          ))
      .toList();

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: const Color(0xffFDB731),
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2FGroup%20182.png?alt=media&token=8b034eee-9b01-4ad9-9cd5-b0a39b5cd742",
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
                    "Selamat Datang",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffFFFFFF)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "di AppSoed",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFFFFFF)),
                  ),
                ],
              )),
          Stack(children: [
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
                            ? Colors.white
                            : const Color.fromRGBO(241, 239, 239, 1)),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/tilikFakultas");
                                            },
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fcil_library-building.png?alt=media&token=1116d667-057a-4001-b3bd-5eded113c750",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Tilik\nFakultas",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: null,
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fu_file-info-alt.png?alt=media&token=cdbd7d11-8c75-47ce-8c9e-ec61cfe1b3ac",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Layanan\nUnsoed",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: null,
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ffluent_people-audience-24-regular.png?alt=media&token=1329d7e7-347b-481c-aa8e-0fda2f7b6eaf",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Info\nUKM",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: null,
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fu_notebooks.png?alt=media&token=8d52b921-b7d7-46cf-a0d4-b59c10c61f78",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Komik",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: null,
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fclarity_media-changer-line.png?alt=media&token=af7f5cdc-490d-493b-b260-373e41f95280",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Media\nPartner",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/liveChat");
                                            },
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Flive%20chat.png?alt=media&token=ca70d727-8258-4ab2-8cc1-317b590b2fc4",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "FAQ",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: null,
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ffluent_people-team-20-regular.png?alt=media&token=d2966dbc-5290-4a94-b51a-f97bb20ede1c",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Profile\nKabinet",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          241, 239, 239, 1),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SizedBox(
                                                      height: 600,
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 30,
                                                                horizontal: 10),
                                                        child: Center(
                                                            child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      bottom:
                                                                          20),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "Semua Fitur",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        21),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fcil_library-building.png?alt=media&token=1116d667-057a-4001-b3bd-5eded113c750",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Tilik\nFakultas",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fu_file-info-alt.png?alt=media&token=cdbd7d11-8c75-47ce-8c9e-ec61cfe1b3ac",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Layanan\nUnsoed",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ffluent_people-audience-24-regular.png?alt=media&token=1329d7e7-347b-481c-aa8e-0fda2f7b6eaf",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Info\nUKM",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fu_notebooks.png?alt=media&token=8d52b921-b7d7-46cf-a0d4-b59c10c61f78",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Komik",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Fclarity_media-changer-line.png?alt=media&token=af7f5cdc-490d-493b-b260-373e41f95280",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Media\nPartner",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Flive%20chat.png?alt=media&token=ca70d727-8258-4ab2-8cc1-317b590b2fc4",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "FAQ",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ffluent_people-team-20-regular.png?alt=media&token=d2966dbc-5290-4a94-b51a-f97bb20ede1c",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "Profile\nKabinet",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            null,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                4,
                                                                            color:
                                                                                const Color(0xffFDB731),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ficon%20_book%201_.png?alt=media&token=940056e4-4686-4f4c-8718-1ebe16195260",
                                                                                width: 24,
                                                                                height: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      const Text(
                                                                        "E-Magz",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            20,
                                                                        left:
                                                                            30),
                                                                child: Row(

                                                                    // mainAxisAlignment:
                                                                    //     MainAxisAlignment
                                                                    //         .spaceEvenly,
                                                                    // crossAxisAlignment:
                                                                    //     CrossAxisAlignment
                                                                    //         .start,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                null,
                                                                            child:
                                                                                SizedBox(
                                                                              height: 60,
                                                                              width: 60,
                                                                              child: Card(
                                                                                elevation: 4,
                                                                                color: const Color(0xffFDB731),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Image.network(
                                                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ficon%20_home%202_.png?alt=media&token=7f3eb2ff-8dcb-4fe2-963d-1a302c8f0da0",
                                                                                    width: 24,
                                                                                    height: 24,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          const Text(
                                                                            "Info Kos",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              30),
                                                                      Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                null,
                                                                            child:
                                                                                SizedBox(
                                                                              height: 60,
                                                                              width: 60,
                                                                              child: Card(
                                                                                elevation: 4,
                                                                                color: const Color(0xffFDB731),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Image.network(
                                                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ficon%20_warning%202_.png?alt=media&token=9b355d1c-fd53-4304-bf97-2fee6a1f6c56",
                                                                                    width: 24,
                                                                                    height: 24,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          const Text(
                                                                            "Lapor",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ]))
                                                          ],
                                                        )),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: Card(
                                                elevation: 4,
                                                color: const Color(0xffFDB731),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://firebasestorage.googleapis.com/v0/b/react-native-crud-fireba-ea6c9.appspot.com/o/Appsoed%2Ficon%20_menu_.png?alt=media&token=da9bf633-7b48-457d-9fda-84e658ee9967",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "semua\nMenu",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                // Column(children: [
                                //   Expanded(
                                //       child: CarouselSlider(
                                //         items: imageSliders,
                                //         carouselController: _controller,
                                //         options: CarouselOptions(
                                //             autoPlay: true,
                                //             enlargeCenterPage: true,
                                //             // aspectRatio: 2.0,
                                //             onPageChanged: (index, reason) {
                                //               setState(() {
                                //                 _current = index;
                                //               });
                                //             }),
                                //       )
                                //   )
                                // ]),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: imgList.asMap().entries.map((entry) {
                                //     return GestureDetector(
                                //       onTap: () => _controller.animateToPage(entry.key),
                                //       child: Container(
                                //         width: 12.0,
                                //         height: 12.0,
                                //         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                //         decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: (Theme.of(context).brightness == Brightness.dark
                                //                 ? Colors.white
                                //                 : Colors.black)
                                //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),

                                Container(
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: true,
                                    ),
                                    items: imageSliders,
                                  ),
                                ),

                                const SizedBox(height: 200),
                              ],
                            ),
                          ))
                        ]))))
          ]),
        ]))
      ]),
    );
  }
}
