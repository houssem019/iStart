import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Map userprofilecords = {};
List Posts = [];
List PostsId = [];
List Likes = [];
List AllUsers = [];
List Messages = [];
List Messages1 = [];
Map Following = {};
List Comments = [];
List lastmessages = [];

class DatabaseService {
  final CollectionReference ProfileCollection =
      FirebaseFirestore.instance.collection('Profiles');
  final CollectionReference PostCollection =
      FirebaseFirestore.instance.collection('Posts');
  CollectionReference? LikesCollection;
  Future updateUserData(
    String name,
    String surname,
    String email,
  ) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    return await ProfileCollection.doc(user).set({
      'Name': name,
      'surname': surname,
      'email': email,
      'uid': user,
      'image':
          "https://image.freepik.com/free-photo/positive-bearded-man-hipster-smiles-broadly-has-pleased-expression-laughs-something-funny-closes-eyes_273609-16781.jpg",
      'cover':
          "https://image.freepik.com/free-photo/group-people-working-out-business-plan-office_1303-15872.jpg",
      'bio': "Write your bio..."
    });
  }

  Future updateUser(
    String name,
    String surname,
    String profile,
    String cover,
    String bio,
  ) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    return await ProfileCollection.doc(user).update({
      'Name': name,
      'surname': surname,
      'email': result.email,
      'uid': user,
      'image': profile,
      'cover': cover,
      'bio': bio,
    }).then((_) {
      fetchDatabaseList();
    });
  }

  Future CreatePost({
    required String datetime,
    required String text,
    String? postimage,
  }) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    return await PostCollection.add({
      'uid': user,
      'datetime': datetime,
      "PostImage": postimage ?? "",
      "text": text,
    });
  }

  Future SendMessage({
    required String receiverId,
    required String datetime,
    required String text,
  }) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add({
      'reveiverId': receiverId,
      'datetime': datetime,
      "text": text,
    });
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(receiverId)
        .collection('chats')
        .doc(user)
        .collection('messages')
        .add({
      'receiverId': receiverId,
      'datetime': datetime,
      "text": text,
    });
  }

  Future Follow({required String followedId}) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user)
        .collection('Following')
        .doc(followedId)
        .set({
      'followedId': followedId,
      'followed': true,
    });
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(followedId)
        .collection('Followers')
        .doc(user)
        .set({
      'followerId': user,
    });
  }

  Future UnFollow({required String followedId}) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user)
        .collection('Following')
        .doc(followedId)
        .update({
      'followedId': followedId,
      'followed': false,
    });
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(followedId)
        .collection('Followers')
        .doc(user)
        .delete();
  }

  Future getUserData() async {
    Map items = {};
    try {
      await ProfileCollection.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          items[element.id] = element.data();
        });
      });
      return items;
    } catch (e) {
      print(e);
    }
  }

  Future getPosts() async {
    List items = [];
    try {
      await PostCollection.orderBy("datetime").get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          items.add(element.data());
        });
      });
      return items;
    } catch (e) {
      print(e);
    }
  }

  Future getFollowing() async {
    Map following = {};
    try {
      await ProfileCollection.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) async {
          await element.reference.collection('Following').get().then((value) {
            value.docs.forEach((element) async {
              following[element.id] = (element.data());
              print(following);
            });
          });
        });
      });

      return following;
    } catch (e) {
      print(e);
    }
  }

  Future getAllUsers() async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    List allusers = [];
    FirebaseFirestore.instance.collection("Profiles").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["uid"] != user) {
          allusers.add(element.data());
        }
      });
    });
    return allusers;
  }

  Future getLikeslength() async {
    List likes = [];
    try {
      await PostCollection.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) async {
          var value =
              await element.reference.collection('Likes').orderBy("Like").get();
          likes.add(value.docs.length);
        });
      });
      return likes;
    } catch (e) {
      print(e);
    }
  }

  Future gePostsId() async {
    List items = [];
    try {
      await PostCollection.orderBy("datetime").get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          items.add(element.id);
        });
      });
      return items;
    } catch (e) {
      print(e);
    }
  }

  Future getLikes(String postId) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(user)
        .set({
          'Like': true,
        })
        .then((value) {})
        .catchError((error) {
          print(error);
        });
  }

  Future Comment(
    String postId,
    String comment,
    String datetime,
  ) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .add({
          'comment': comment,
          'datetime': datetime,
          'commentor': user,
        })
        .then((value) {})
        .catchError((error) {
          print(error);
        });
  }

  getLastMessage({required String receiverId}) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    List lastmessages = [];
    await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user)
        .collection('chats')
        .doc(receiverId)
        .collection("messages")
        .orderBy("datetime")
        .get()
        .then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((element) {
        lastmessages.add(element.data());
        // print(lastmessages);
      });
    });
  }

  getMessages({required String receiverId}) async {
    var result = await FirebaseAuth.instance.currentUser;
    var user = result!.uid;
    await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(user)
        .collection('chats')
        .doc(receiverId)
        .collection("messages")
        .orderBy("datetime")
        .snapshots()
        .listen((event) {
      Messages = [];
      event.docs.forEach((element) {
        Messages.add(element.data());
        print(Messages);
      });
    });
  }

  getComments({required String postId}) async {
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .orderBy("datetime")
        .snapshots()
        .listen((event) {
      Comments = [];
      event.docs.forEach((element) {
        Comments.add(element.data());
        print(Comments);
      });
    });
  }

  Future fetchDatabaseList() async {
    dynamic resultant = await DatabaseService().getUserData();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      userprofilecords = resultant;
    }
  }

  Future fetchAllusersList() async {
    dynamic resultant = await DatabaseService().getAllUsers();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      AllUsers = resultant;
    }
  }

  Future fetchPostsList() async {
    dynamic resultant = await DatabaseService().getPosts();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      Posts = new List.from(resultant.reversed);
    }
  }

  Future fetchPostsIdList() async {
    dynamic resultant = await DatabaseService().gePostsId();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      PostsId =new List.from(resultant.reversed);
    }
  }

  Future fetchlikelengthList() async {
    dynamic resultant = await DatabaseService().getLikeslength();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      Likes = resultant;
    }
  }

  Future fetchFollowingList() async {
    dynamic resultant = await DatabaseService().getFollowing();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      Following = resultant;
    }
  }

  id() {
    var uid;
    uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
