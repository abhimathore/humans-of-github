import 'package:http/http.dart' as http;
import 'dart:convert';

var url = 'https://api.github.com/users/';

fetchUserData(String s) async {
  var userUrl = url + s;
  final response = await http.get(userUrl);
  var jsonData = json.decode(response.body);
  User user = User(jsonData["name"], jsonData["followers"],
      jsonData["following"], jsonData["public_repos"]);
  return user;
}

class User {
  final int follow;
  final int following;
  final String name;
  final int repos;

  User(this.name, this.follow, this.following, this.repos);
}
