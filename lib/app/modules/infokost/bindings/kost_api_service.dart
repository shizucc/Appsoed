import 'package:appsoed/app/modules/infokost/models/kost_model.dart';
import 'package:http/http.dart' as http;

class KostAPIService {
  static const String _baseURL = 'https://api.bem-unsoed.com/api';

  final http.Client client;

  KostAPIService({required this.client});

  @override
  Future<List<Kost>> getUser(String token) async {
    final http.Response response = await http.get(
      Uri.parse('$_baseURL/kost'),
    );
    return kostFromJson(response.body);
  }
}
