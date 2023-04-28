import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';

class WelcomeScreen extends StatelessWidget {
const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        child:  Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,

        children:  [   
           SizedBox(height: 50),

           const Text("Welcome To EMS",style: TextStyle(
            color: Colors.black,
            fontSize: 27,
            fontWeight: FontWeight.w700,
           ),),

           const SizedBox(height: 5),

           const Text("Event Management System",style: TextStyle(
            color: Colors.black,
            fontSize: 27,
            fontWeight: FontWeight.w700,
           ),),

            SizedBox(height: 30),
           Image.asset('assets/onboardIcon.png'),

           const SizedBox(height: 30),

           Expanded(
            child: Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
               boxShadow: [   BoxShadow(
                 color: Colors.black12,
                 blurRadius: 5,
                 spreadRadius: 2,
               ),
               ],
              borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16) ) 
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                 const SizedBox(height: 10),

                 const Padding(
                  padding: EdgeInsets.only(left: 15, right:15) ,
                  child: Text("The social media platform desgned to get you offline", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                 ),

                 const Padding(
                  padding: EdgeInsets.only(left: 15, right:15) ,
                  child: Text("EMS is an app where users can leverage their social network to create, discover, share, and monetize events or services.", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),),
                 ),
                 
                 Padding(padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                 ),
                 child: MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.white,
                  elevation: 2,
                  onPressed: () {
                    Get.to(()=>const LoginView());
                  }, 
                  child:const Text("Get started",
                 style: TextStyle(
                  fontSize: 20,
                  color: Color(0Xff274560),
                  fontWeight: FontWeight.w500,
                 ),
                 )),
                 )

                ],
              ),
           ),)
        ],
      ),
      ),
    )
    );
  }
}