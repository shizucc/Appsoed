import 'package:appsoed/app/modules/gensoed_merch/controller/gensoedmerch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appsoed/app/modules/gensoed_merch/bindings/gensoedmerch_api_services.dart';
import 'package:appsoed/app/modules/gensoed_merch/model/gensoedmerch_model.dart';
import 'package:shimmer/shimmer.dart';

class GensoedMerchView extends StatelessWidget {
  const GensoedMerchView({super.key});

  @override
  Widget build(BuildContext context) {
    final gensoedMerchAPIService = GensoedMerchAPIService();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.back),
        ),
        title: const Text("Gensoed Merch"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: gensoedMerchAPIService.getGensoedMerchs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const MerchsError();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: const MerchsShimmer());
                } else if (snapshot.hasData) {
                  var gensoedMerchsDump = snapshot.data ?? [];
                  List<GensoedMerch> gensoedMerchs = gensoedMerchsDump.toList();
                  return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Merchs(gensoedMerchs: gensoedMerchs));
                } else {
                  return const Text("Gensoed Merch tidak tersedia");
                }
              })),
    );
  }
}

class Merchs extends StatelessWidget {
  const Merchs({super.key, required this.gensoedMerchs});
  final List<GensoedMerch> gensoedMerchs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: gensoedMerchs.map((merch) {
        return Merch(
          merch: merch,
        );
      }).toList(),
    );
  }
}

class Merch extends StatelessWidget {
  Merch({super.key, required this.merch});
  final GensoedMerch merch;
  final GensoedMerchAPIService gensoedMerchAPIService =
      GensoedMerchAPIService();
  final GensoedMerchController gensoedMerchController =
      GensoedMerchController();

  @override
  Widget build(BuildContext context) {
    var priceStart =
        gensoedMerchController.convertToIdr(merch.priceStart, true);
    var priceEnd = gensoedMerchController.convertToIdr(merch.priceEnd, false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          gensoedMerchController.openStore(merch.productLink.toString());
        },
        child: Container(
          width: Get.height / 5,
          height: Get.height / 3.3,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                gensoedMerchAPIService.getImageUri(merch.image),
                fit: BoxFit.cover,
                height: Get.height / 5,
                width: Get.height / 5,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/gensoedmerch_no_image.png',
                    height: Get.height / 5,
                    width: Get.height / 5,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${merch.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    merch.priceEnd == 0
                        ? Text(
                            priceStart,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        : Text('$priceStart - $priceEnd',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class MerchsShimmer extends StatelessWidget {
  const MerchsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            MerchShimmer(),
            MerchShimmer(),
            MerchShimmer(),
            MerchShimmer(),
            MerchShimmer(),
            MerchShimmer(),
            MerchShimmer()
          ],
        ),
      ),
    );
  }
}

class MerchShimmer extends StatelessWidget {
  const MerchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                width: Get.height / 5,
                height: Get.height / 5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: Get.height / 6,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: Get.height / 8,
                height: 10,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MerchsError extends StatelessWidget {
  const MerchsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset("assets/images/error.png")),
      const Text(
        "Terjadi Kesalahan",
        style: TextStyle(fontSize: 20),
      )
    ]);
  }
}
