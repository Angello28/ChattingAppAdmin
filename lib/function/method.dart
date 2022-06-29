import 'package:cloud_firestore/cloud_firestore.dart';

class UserMethod{
  getUserByUsername(String username){
    return FirebaseFirestore.instance.collection('users')
      .where('searchkey',
      isEqualTo : username.substring(0, 1)
    )
      .get();
  }

  getUserByUserEmail(String email){
    return FirebaseFirestore.instance.collection('users')
      .where('email',
      isEqualTo : email
    )
      .get()
      .catchError((e) {
        print(e.toString());
    });
  }

  getChatMessages(String chatRoomId){
    return FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).collection('chats').orderBy('timestamp', descending: true).snapshots();
  }

  getRecentChatMessages(String chatRoomId){
    return FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).collection('chats').limit(1).orderBy('timestamp', descending: true).snapshots();
  }

  getEmptyChatRoom(String chatRoomId){
    return FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).collection('chats').limit(1).orderBy('timestamp', descending: true).get();
  }

  getChatRooms(String id){
    return FirebaseFirestore.instance.collection('chatroom')
      .where('users', arrayContains: id)
      .orderBy('recentTimeStamp', descending: true)
      .snapshots();
  }

  getUsernameById(String id) async{
    String name = "";
    await FirebaseFirestore.instance.collection('users')
      .where('id', isEqualTo: id).get().then((value){
        name = value.docs[0]['name'];
    });
    return name;
  }

  getProfileImageById(String id) async{
    String imgUrl = "";
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get();
    if(snapshot.size != 0)
      imgUrl = snapshot.docs[0]['profileImg'];
    else
      imgUrl = "";
    return imgUrl;
  }

  getTokenById(String id) async{
    String token = "";
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get();
    if(snapshot.size != 0)
      token = snapshot.docs[0]['tokenId'];
    else
      token = "";
    return token;
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  getStatusUnreadMessage(String id, String chatRoomId) async{
    bool isRead = true;
    await FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId).collection('chats')
      .where('sendBy', isEqualTo: id)
      .where('isRead', isEqualTo: false).get().then((value){
        if(value.size>0){
          isRead = false;
        }
    });
    return isRead;
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).get().then((value){
      if(!value.exists){
        FirebaseFirestore.instance.collection('chatroom')
          .doc(chatRoomId).set(chatRoomMap).catchError((e){
            print(e.toString());
        });
      }
      else{
        FirebaseFirestore.instance.collection('chatroom')
          .doc(chatRoomId).update(chatRoomMap).catchError((e){
            print(e.toString());
        });
      }
    });
  }

  addChatMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).collection('chats').add(messageMap).catchError((e){
        print(e.toString());
    });
    FirebaseFirestore.instance.collection('chatroom')
      .doc(chatRoomId).update({'recentTimeStamp': messageMap['timestamp']});
  }

  storeChat(messageMap) {
    FirebaseFirestore.instance.collection('MessageData').add(messageMap);
  }

  deleteChatMessages(String chatRoomId){
    FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId).collection('chats').get().then((value) {
      for(DocumentSnapshot ds in value.docs){
        ds.reference.delete();
      }
    });
    FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId).delete();
  }

  updateProfileImage(String id, String profileImgUrl){
    FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get().then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.docs[0].id).update({'profileImg': profileImgUrl});
    });
  }

  updateUserName(String id, String newUserName){
    FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get().then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.docs[0].id).update({'name': newUserName});
      FirebaseFirestore.instance.collection('users').doc(value.docs[0].id).update({'searchkey': newUserName.substring(0,1).toLowerCase()});
    });
  }

  updateToken(String id, String newToken){
    FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get().then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.docs[0].id).update({'tokenId': newToken});
    });
  }

  updateReadMessage(String id, String chatRoomId){
    FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId).collection('chats')
        .where('sendBy', isEqualTo: id).where('isRead', isEqualTo: false).get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId)
            .collection('chats').doc(element.id).update({'isRead': true});
      });
    });
  }
}

