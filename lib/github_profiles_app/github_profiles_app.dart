import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ten_apps_challenge/github_profiles_app/github_user.dart';

class GithubProfilesApp extends StatefulWidget {
  @override
  _GithubProfilesAppState createState() => _GithubProfilesAppState();
}

class _GithubProfilesAppState extends State<GithubProfilesApp> {
  Future<GithubUser> githubUser;
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Profiles App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search username',
              ),
            ),
            SizedBox(height: 120),
            FutureBuilder<GithubUser>(
              future: githubUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError)
                  return Center(child: Text('User not found'));

                if (snapshot.data == null) {
                  return Center(child: Text('Find a user'));
                }

                final user = snapshot.data;
                return Column(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                    radius: 70,
                  ),
                  SizedBox(height: 20),
                  Text(
                    user.login,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Text(user?.location ?? ''),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Repositories'),
                          Text(user.publicRepos.toString())
                        ],
                      ),
                      Column(
                        children: [
                          Text('Following'),
                          Text(user.following.toString())
                        ],
                      ),
                      Column(
                        children: [
                          Text('Followers'),
                          Text(user.followers.toString())
                        ],
                      ),
                    ],
                  )
                ]);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            githubUser = fetchGithubUser(searchController.text);
          });
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

Future<GithubUser> fetchGithubUser(String user) async {
  final response = await http.get('https://api.github.com/users/$user');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return GithubUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
