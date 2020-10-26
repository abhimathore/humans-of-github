import 'package:http/http.dart' as http;
import 'dart:convert';

var userLength;
String userUrl;
var url = 'https://api.github.com/search/users?per_page=100&q=';
Future<List<User>> fetchUsers(String s) async {
  List temp = [];
  String query = '';
  s = s.trim();
  temp = s.split(" ");
  temp.removeWhere((element) => element.length == 0);
  query = temp.join('+');
  userUrl = url + query;

  final response = await http.get(userUrl);
  var jsonData = json.decode(response.body);
  List<User> users = [];
  userLength = jsonData["total_count"];
  if (userLength > 100) {
    userLength = 100;
  }
  for (var u = 0; u < userLength; u++) {
    User user =
        User(jsonData["items"][u]["login"], jsonData["items"][u]["avatar_url"]);
    users.add(user);
  }
  return users;
}

class User {
  final String login;
  final String image;

  User(this.login, this.image);
}
