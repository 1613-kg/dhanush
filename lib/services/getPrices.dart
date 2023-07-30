import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Prices {
  Future<List<Map<String, dynamic>>> fetchMustardPrices() async {
    final response = await http
        .get(Uri.parse('https://www.commodityonline.com/mandiprices/mustard'));
    if (response.statusCode == 200) {
      return _parseHTML(response.body);
    } else {
      throw Exception('Failed to load mustard prices');
    }
  }

  List<Map<String, dynamic>> _parseHTML(String responseBody) {
    List<Map<String, dynamic>> pricesList = [];
    var document = parser.parse(responseBody);
    var rows = document.querySelectorAll('table tbody tr');

    for (var row in rows) {
      var columns = row.children;
      if (columns.length >= 2) {
        var date = columns[0].text;
        var price = columns[1].text;

        pricesList.add({
          'date': date,
          'price': price,
        });
      }
    }

    return pricesList;
  }
}
