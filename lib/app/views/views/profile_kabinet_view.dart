import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../provider/launcer_provider.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/social_widget.dart';

/// A class that displays the profile of the BEM Unsoed Medkom.

class ProfileKabinetView extends GetView {
  const ProfileKabinetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // NOTE: green gradient background containing content
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff91D2A8), Color(0xffF1EFEF)],
                ),
              ),
              margin: const EdgeInsets.only(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                ),
                shrinkWrap: true,
                children: [
                  Image.asset("assets/images/simpulasa.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  // NOTE: TITLE CONTENT
                  const Text(
                    'KABINET SIMPUL ASA',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff373737),
                    ),
                  ),
                  // NOTE: END TITLE CONTENT ========
                  // NOTE: CONTENT
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 28,
                    ),
                    child: const Text(
                      'Burung Merak dianggap sebagai lambang keindahan dengan berbagai spektrum warna yang melambangkan kekuatan, keindahan, dan keunggulan. Badannya yang membentuk simpul menjadi satu kesatuan tali yang saling terikat menjadi utuh, merupakan penghubung dan penyatu dari segala aspek yang saling menguatkan dan bekerja secara sinergis untuk mencapai sebuah asa. Ekor yang menghadap ke atas melambangkan keteguhan dan kearifan sebagai penunjuk arah dan penuntun jalan ke arah kebaikan, sedangkan dua belas warna di ekornya melambangkan seluruh fakultas di Unsoed yang bersinergi membangun asa',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff373737),
                        wordSpacing: 10,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // NOTE: END CONTENT ===========

                  // NOTE: MEDIA SOCIAL OF BEM
                  Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Media Sosial',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff373737),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            SocialWidget(
                              image: 'Instagram-green',
                              link: 'https://instagram.com/bem_unsoed',
                            ),
                            SocialWidget(
                              image: 'YouTube-green',
                              link: 'https://m.youtube.com/c/BEMUnsoed',
                            ),
                            SocialWidget(
                              image: 'Line-green',
                              link:
                                  'https://liff.line.me/1645278921-kWRPP32q/?accountId=uzf4935f',
                            ),
                            SocialWidget(
                              image: 'Twitter-green',
                              link: 'https://twitter.com/bem_unsoed',
                            ),
                            SocialWidget(
                                image: 'Spotify-green',
                                link:
                                    'https://open.spotify.com/show/4G1FeEt60JftSEGSx8uVDt?si=OVf1hSeOQ2iOhATTvyQTFA&utm_source=copy-link'),
                            SocialWidget(
                                image: 'TikTok-green',
                                link: 'https://vt.tiktok.com/ZSd4JhVah/'),
                          ],
                        )
                      ],
                    ),
                  ),
                  // NOTE: END MEDIA SOCIAL BEM ============

                  // NOTE: CONTACT US
                  Container(
                    margin:
                        const EdgeInsets.only(left: 26, top: 28, bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi lebih lanjut dapat dilihat di :',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff373737),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Website BEM Unsoed',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              LauncherProvider.launcherURL(
                                'https://apps.bem-unsoed.com/',
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  // NOTE: END CONTACT US ============
                ],
              ),
            ),
            // NOTE: END White Background =======

            Positioned(
              top: 24,
              left: 24,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xff9AD5AF),
                  ),
                ),
              ),
            ),
            // NOTE: END TOP CONTENT ==========
          ],
        ),
      ),
    );
  }
}

/// This class is a stateless widget that takes in an image and a link and returns a GestureDetector
/// that launches the link when tapped

