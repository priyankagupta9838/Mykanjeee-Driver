import 'package:http/http.dart'as http ;
import 'package:mykanjeedriver/api/apilist.dart';

class UserAccount{
  Stream<http.Response> fetchBankName()  {

    String url= '${ApiList.baseUrl}/api/bank/get-all-banks';

    return http.get(Uri.parse(url),headers: {
      "authorization":""
    }).asStream();
  }
}