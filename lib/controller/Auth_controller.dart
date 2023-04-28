import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as Path;

import '../auth/add_profile.dart';


class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void login({String? email, String? password}){

    isLoading(true);
    
    auth.signInWithEmailAndPassword(email: email!, password: password!)
    .then((value) {
      isLoading(false);
     Get.to(()=> const HomeScreen());
    }).catchError((e){
      Get.snackbar("Error", "$e");
      isLoading(false);
    });
  }

  void signUp({String? email, String? password}){

     isLoading(true);
    auth.createUserWithEmailAndPassword(email: email!, password: password!)
    .then((value) {
     isLoading(false);
     Get.to(()=> ProfileScreen());
    }).catchError((e){
      print("Error in authentication is $e");
      isLoading(false);

    });
  }

  void forgetPassword(String email){
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar("Passwoed reset email sent"," Please check your emal.");
    }).catchError((e){
       print("Error in sending email is $e");
    });
  }


 signInWithGoogle() async {
  isLoading(true);
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
   FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    isLoading(false);
    Get.to(() => const HomeScreen());
   }).catchError((e){
    isLoading(false);
     print("Error in authenticate $e");

   });
}
 var isProfileInformationLoading = false.obs;
Future<String> uploadImageToFirebaseStorage(File image) async{
  String imageUrl = '';
  String fileName = Path.basename(image.path);
  var refference = FirebaseStorage.instance.ref().child('profileImages/$fileName');
  UploadTask uploadTask = refference.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  await taskSnapshot.ref.getDownloadURL().then((value) => {
     imageUrl = value,
  }).catchError((e){
    print("Error hapen $e");
  });
  return imageUrl; 
}

uploadProfileData(String imageUrl,String firstName, String lastName, String mobileNumber,String dob, String gender){
  String uid =FirebaseAuth.instance.currentUser!.uid;


  FirebaseFirestore.instance.collection("users").doc(uid).set({
    "image": imageUrl,
    "first": firstName,
    "last": lastName,
    "dob": dob,
    "gender": gender
    
  }).then((value) {
    isProfileInformationLoading (false);
    Get.offAll(()=>const HomeScreen());
  });
}
  
}