import 'package:http/http.dart' as http;
import 'package:appsoed/app/modules/gensoed_merch/model/gensoedmerch_model.dart';

class GensoedMerchAPIService {
  static const String _baseURL = 'https://api.bem-unsoed.com/api';

  Future<List<GensoedMerch>> getGensoedMerchs() async {
    final http.Response response =
        await http.get(Uri.parse('$_baseURL/gensoedmerch'));

    return gensoedMerchsFromJson(response.body);
  }

  String getImageUri(String? image) {
    final uri = ('$_baseURL/gensoedmerch/image/$image');
    return uri;
  }
}
