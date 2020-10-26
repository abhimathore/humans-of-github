import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humans_of_github/user_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic futureUsers;
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar =
      Text("Humans of GitHub", style: GoogleFonts.montserrat());
  String searchText;

  @override
  void initState() {
    super.initState();
    this.futureUsers = fetchUsers('abhi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    onSubmitted: (value) {
                      setState(() {
                        searchText = value;
                        this.futureUsers = fetchUsers(searchText);
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Search for user'),
                    textInputAction: TextInputAction.go,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar =
                      Text("Humans of GitHub", style: GoogleFonts.montserrat());
                }
              });
            },
            icon: cusIcon,
          ),
        ],
        title: cusSearchBar,
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: this.futureUsers,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.redAccent,
                            child: CircleAvatar(
                              radius: 54,
                              backgroundImage:
                                  NetworkImage('${snapshot.data[index].image}'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            snapshot.data[index].login,
                            style: GoogleFonts.montserrat(fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}
