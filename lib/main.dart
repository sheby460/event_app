import 'package:event_app/bottom_nav_bar/bottom_nav_view.dart';
import 'package:event_app/firebase_options.dart';
import 'package:event_app/view/home.dart';
import 'package:event_app/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
         ),
        primarySwatch: Colors.blue,
      ),
          home: FirebaseAuth.instance.currentUser!.uid == null? const HomeScreen(): const BottomBarView(),
    );
  }
}
