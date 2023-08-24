import 'package:appsoed/app/modules/gensoed_merch/model/gensoedmerch_model.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";
import 'package:url_launcher/url_launcher.dart';

class GensoedMerchController extends GetxController {
  String convertToIdr(dynamic number, bool symbol) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: symbol ? 'Rp' : '',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }

  Future<void> openStore(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
