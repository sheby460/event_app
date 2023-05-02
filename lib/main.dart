import 'package:event_app/bottom_nav_bar/bottom_nav_view.dart';
import 'package:event_app/firebase_options.dart';
import 'package:event_app/services/notification_service.dart';
import 'package:event_app/utils/app_constants.dart';
import 'package:event_app/view/home.dart';
import 'package:event_app/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> _firebaseMessagingBackgroundHadler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.toString());
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHadler);
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
          home: FirebaseAuth.instance.currentUser == null? const HomeScreen(): const BottomBarView(),
    );
  }
}
