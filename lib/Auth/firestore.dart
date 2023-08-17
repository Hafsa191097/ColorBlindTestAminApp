import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDataBase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   getQuizData() {
    return _firestore.collection('Quiz').snapshots();
  }

  Future<void> addLDataOfUsers(email,pass) async {
    final ref = FirebaseFirestore.instance
        .collection('Admin Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
      var data1 = {
        'AdminEmail' : email,
        'AdminPass' : pass,
      };

    await ref.set(data1, SetOptions(merge: true)); // create/update
  }

    Future<void> addLDataOfQuizes(img,title,desc) async {
     
      final ref = FirebaseFirestore.instance
      .collection('Quiz')
      .doc();
      var data1 = {
        'Description' : desc,
        'ImageUrl' : img,
        'Title' : title,
      };

      await ref.set(data1, SetOptions(merge: true));
      
  }

  Future<QuerySnapshot<Map<String,dynamic>>> getQuestionsForQuiz(String QuizId)  {
    return _firestore.collection('Quiz').doc(QuizId).collection('Questions').get();
    
  }
  Stream<QuerySnapshot<Map<String,dynamic>>> getQuestionsForQuizStream(String QuizId)  {
    return _firestore.collection('Quiz').doc(QuizId).collection('Questions').snapshots();
  }


  Future<bool> checkAdminEmailExists(String email) async {
    try{
      QuerySnapshot querysnapshot = await FirebaseFirestore.instance.collection('Admin Users').where('AdminEmail', isEqualTo: email).limit(1).get();
      return querysnapshot.docs.isNotEmpty;

    }catch(e){
      return false;
    }
  }
}