import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<dynamic> _users = [];
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMoreData = false;
  int _page = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !_isLoadingMoreData && _hasMore) {
        setState(() {
          print('Pagination called');
          _isLoadingMoreData = true;
          _page++;
        });
        fetchUsers(); // Fetch the next page of users
      }
    });
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$_page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        print('Fetched page: $_page');
        _users.addAll(data['data']);
        _loading = false;
        _isLoadingMoreData = false;
        _hasMore = (data['page'] < data['total_pages']); // Check if there are more pages
      });
    } else {
      setState(() {
        _loading = false;
        _isLoadingMoreData = false;
      });
      throw Exception('Failed to load users');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('User List', style: GoogleFonts.cabin()),
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : _users.isEmpty
          ? Center(
        child: Text(
          'No users found',
          style: GoogleFonts.cabin(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _users.length + (_hasMore ? 1 : 0), // +1 for the loading indicator if there are more pages
          itemBuilder: (context, index) {
            if (index == _users.length && _hasMore) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else {
              final user = _users[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                child: Container(
                  height: size.height * 0.11,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(size.height * 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.03),
                          CircleAvatar(
                            backgroundImage: NetworkImage(user['avatar']),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                '${user['first_name']} ${user['last_name']}',
                                style: GoogleFonts.cabin(
                                  color: Colors.black87,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              AutoSizeText(
                                user['email'],
                                style: GoogleFonts.cabin(
                                  color: Colors.black87,
                                  fontSize: size.height * 0.017,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
