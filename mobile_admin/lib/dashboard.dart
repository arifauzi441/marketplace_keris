import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_admin/login.dart';
import 'package:mobile_admin/model/user_api.dart';

class Dashboard extends StatefulWidget {
  final String token;
  const Dashboard({super.key, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String api = dotenv.env['API_URL'] ?? "";
  UserApi? user;
  List<UserApi>? users;
  late String token = widget.token;

  @override
  void initState() {
    super.initState();
    fetchAllUsers('');
  }

  Future<void> fetchAllUsers(String search) async {
    try {
      var response = await UserApi.getAllUser(token, search);
      setState(() {
        users = response;
      });
    } catch (e) {
      print("haiii");
      print(e);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5 * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: Color(0xFF3B8D28),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                token = '';
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          user?.username ?? 'Ari',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 15.0),
                          child: ClipOval(
                            child: (user?.photo == null)
                                ? Image.asset(
                                    "images/account.png",
                                    width: 40.0,
                                    height: 40.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "$api/${user?.photo}",
                                    width: 40.0,
                                    height: 40.0,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Daftar Akun",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Column(
                      children: [
                        // Search Box
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  onChanged: (value) {
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      setState(() {
                                        fetchAllUsers(value);
                                      });
                                    });
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                          color: Color(0xFF2E6C25),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text("ID",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text("Rolee",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text("Username",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text("Phone",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text("Status",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        users == null
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: users!.length,
                                  itemBuilder: (context, index) {
                                    final user = users![index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Text(
                                                (user.idAdmin.toString() !=
                                                        "null")
                                                    ? "admin"
                                                    : "seller",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Text(
                                                user.username ?? "",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Text(
                                                user.phone ?? "",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5 *
                                                    0.4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                color: (user.status ==
                                                        "belum diterima")
                                                    ? Color(0xFF3B8D28)
                                                    : Colors.red,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      try {
                                                        var response = (user
                                                                    .idAdmin ==
                                                                null)
                                                            ? await UserApi
                                                                .changeStatus(
                                                                    token,
                                                                    "seller",
                                                                    user.idSeller ??
                                                                        0)
                                                            : await UserApi
                                                                .changeStatus(
                                                                    token,
                                                                    "admin",
                                                                    user.idAdmin ??
                                                                        0);
                                                        if (response[
                                                                'status'] ==
                                                            200)
                                                          fetchAllUsers('');
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        (user.status ==
                                                                "belum diterima")
                                                            ? "terima"
                                                            : "tolak",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
