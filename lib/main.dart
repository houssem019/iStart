import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istart/chats.dart';
import 'package:istart/drawer.dart';
import 'package:istart/gettingstarted.dart';
import 'package:istart/mymoney.dart';
import 'package:istart/myprofile.dart';
import 'package:istart/newsfeed.dart';
import 'package:istart/settings.dart';
import 'package:istart/signin.dart';
import 'package:istart/signup.dart';
import 'package:istart/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:istart/widget/people.dart';
import 'net/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage((message) async {
    await Firebase.initializeApp();
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: Color.fromRGBO(255, 230, 250, 1),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 46, 64, 84),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        textTheme: GoogleFonts.firaSansCondensedTextTheme(),
      ),
      routes: {
        '/a': (context) => Signin(),
        '/b': (context) => Pview(),
        '/c': (context) => Splash(),
        '/d': (context) => SignUp(),
        '/e': (context) => MyHomePage(),
        '/f': (context) => Myprofile(),
        '/g': (context) => Mymoney(),
        '/h': (context) => Settings(),
        '/i': (context) => Chats(),
      },
      home: Splash(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var posts = [];
  var users = {};
  var postsId = [];
  var likes = [];
  var loading = true;
  @override
  void initState() {
    super.initState();
    DatabaseService().fetchDatabaseList();
    DatabaseService().fetchPostsList();
    DatabaseService().fetchPostsIdList();
    DatabaseService().fetchlikelengthList();
    DatabaseService().fetchAllusersList();
    DatabaseService().fetchFollowingList();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 46, 64, 84),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 46, 64, 84),
          ),
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 46, 64, 84),
            tabs: [
              Tab(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  icon: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 46, 64, 84),
                    size: 28,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.people,
                  color: Color.fromARGB(255, 46, 64, 84),
                  size: 28,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 46, 64, 84),
                  size: 28,
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 55, 134, 150),
                  Color.fromARGB(255, 190, 210, 224),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color.fromARGB(255, 46, 64, 84),
                size: 32,
              ),
              onPressed: () {},
            ),
          ],
          // backgroundColor: Color.fromARGB(255, 46, 64, 84),
          centerTitle: true,
          title: const Text(
            "iStart",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 46, 64, 84),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NewsFeed(),
            People(),
            Container(
              child: Text("${Likes}"),
            ),
          ],
        ),
        drawer: Drawers(),
      ),
    );
  }
}
