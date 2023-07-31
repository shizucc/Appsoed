import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LaporPage extends StatelessWidget {
  const LaporPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDB731),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  elevation: 1.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.chevron_left,
                    size: 30.0,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  shape: const CircleBorder(),
                ),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("./assets/Group171.png"),
                    radius: 130,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(50, 30, 50, 137),
                    shrinkWrap: true,
                    children: [
                      Text(
                        "Ada yang bisa kami bantu ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Bantu orang-orang disekitarmu dari tindak kejahatan seksual! Kalau bukan kita, siapa lagi?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            _launchUrl(
                                "pelecehanseksual.rifkiromadhan.repl.co");
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Color(0xffFDB731))))),
                          child: Text(
                            "Call Center",
                            style: TextStyle(
                                color: Color(0xffFDB731),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
