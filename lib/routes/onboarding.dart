import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        height:double.infinity,
        decoration:BoxDecoration(
          gradient:LinearGradient(
            begin:Alignment.topLeft,
            end:Alignment.bottomCenter,
            colors: [
              Color(0xffFFF5D0),
              Color(0xffFFFFFF)
            ]
          )
        ),
        child:Stack(
          children: [
            Align(
              alignment:Alignment.centerRight,
              child:Image.asset("./assets/headset.png"),
            ),
            Align(
              alignment:Alignment.topRight,
              child:Image.asset("./assets/group1.png",height:MediaQuery.of(context).size.height*0.25,),
            ),
            Align(
              alignment:Alignment.bottomLeft,
              child:Image.asset("./assets/group2.png",height:MediaQuery.of(context).size.height*0.5,),
            ),
            Align(
              alignment:Alignment.topLeft,
              child:Container(
                margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.15,left:MediaQuery.of(context).size.width*0.12),
                child:Text("Listen to \nfree music you \nactually like",style:GoogleFonts.manrope(fontSize:30,fontWeight:FontWeight.bold,letterSpacing:2),),
              ),
            ),
            Align(
              alignment:Alignment.bottomCenter,
              child:Container(
                width: MediaQuery.of(context).size.width*0.35,
                height:MediaQuery.of(context).size.height*0.1,
                margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.08),
                child:Center(
                  child:Column(
                    children:[
                      TextButton(onPressed:(){
                        print("clickd");
                      },
                        child:Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text("Get started",style:GoogleFonts.manrope(fontWeight:FontWeight.bold,color:Colors.black),),
                            SizedBox(width:5,),
                            Icon(Icons.arrow_forward_sharp,color:Colors.black,size:20,)
                          ],
                        ),
                        style:TextButton.styleFrom(
                          padding:EdgeInsets.all(5),
                          primary:Colors.white,
                          backgroundColor:Color(0xffFFC900),
                            fixedSize: Size.fromHeight(55)
                        )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
