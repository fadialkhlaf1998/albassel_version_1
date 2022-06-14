// ignore_for_file: must_be_immutable

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/verification_code_controller.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationCode extends StatelessWidget{

  VerificationCodeController verificationCodeController= Get.put(VerificationCodeController());

  TextEditingController code=TextEditingController();

  VerificationCode({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: App.midOrange,
        body: Obx((){
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background/signin.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child:verificationCodeController.loading.value?
                const Center(child: CircularProgressIndicator(),)
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Image.asset("assets/logo/logo.png"),
                    ),

                    Column(
                      children: [
                        textFieldBlock("v_code",code,context,verificationCodeController.code_vaildate.value),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                verificationCodeController.resend(context);
                              },
                              child: Text(App_Localization.of(context).translate("re_send"),style: TextStyle(color: App.midOrange,fontSize: 12),),
                            )
                          ],
                        )
                      ],
                    ),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       GestureDetector(
                         onTap: (){
                           verificationCodeController.verificate(context, code.value.text);
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width*0.4,
                           height:  MediaQuery.of(context).size.height * 0.06 > 70
                               ? 70
                               : MediaQuery.of(context).size.height * 0.06,
                           decoration: BoxDecoration(
                               color: App.midOrange,
                               borderRadius: BorderRadius.circular(50)
                           ),
                           child: Center(
                             child: Text(App_Localization.of(context).translate("send").toUpperCase(),style: App.textBlod(Colors.white, 18),),
                           ),
                         ),
                       ),

                       GestureDetector(
                         onTap: (){
                           Get.offAll(()=>Home());
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width*0.4,
                           height:  MediaQuery.of(context).size.height * 0.06 > 70
                               ? 70
                               : MediaQuery.of(context).size.height * 0.06,
                           decoration: BoxDecoration(
                               color: App.midOrange,
                               borderRadius: BorderRadius.circular(50)
                           ),
                           child: Center(
                             child: Text(App_Localization.of(context).translate("cancel").toUpperCase(),style: App.textBlod(Colors.white, 18),),
                           ),
                         ),
                       ),
                     ],
                   )



                  ],
                ),
              ),
            ),
          );
        })
    );
  }

  textFieldBlock(String translate,TextEditingController controller,BuildContext context,bool validate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: App.textNormal(Colors.grey, 14),),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
            onSubmitted: (q){
              verificationCodeController.verificate(context, code.value.text);
            },
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: validate?Colors.white:Colors.red)
              ),
              focusedBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: validate?App.orange:Colors.red)
              ),
            ),
            style: App.textNormal(Colors.white, 14),
          ),
        ),
        const SizedBox(height: 50,)
      ],
    );
  }


}