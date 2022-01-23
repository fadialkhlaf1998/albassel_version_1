import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/controler/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget{

  SignUpController signUpController= Get.put(SignUpController());

  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/signin.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child:signUpController.loading.value?
                  Center(child: CircularProgressIndicator(),)
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Image.asset("assets/logo/logo.png"),
                  ),

                  Column(
                    children: [
                      textFieldBlock("first_name",fname,context,signUpController.fname_vaildate.value),
                      textFieldBlock("last_name",lname,context,signUpController.lname_vaildate.value),
                      textFieldBlock("email",email,context,signUpController.email_vaildate.value),
                      Obx((){
                        return textFieldBlockPassword("password",password,context,signUpController.hide_passeord.value,signUpController.pass_vaildate.value);
                      })
                    ],
                  ),

                  GestureDetector(
                    onTap: (){
                      //todo sign up
                      signUpController.signUp(context,email.value.text,password.value.text,fname.value.text,lname.value.text);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height:  MediaQuery.of(context).size.height * 0.06 > 70
                          ? 70
                          : MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: App.midOrange,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text(App_Localization.of(context).translate("Sign_up").toUpperCase(),style: App.textBlod(Colors.white, 18),),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(App_Localization.of(context).translate("have_account"),style: App.textNormal(Colors.white, 16),),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Text(App_Localization.of(context).translate("sign_in"),style: App.textBlod(App.midOrange, 16),),
                      ),
                    ],
                  ),

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
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
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
        SizedBox(height: 50,)
      ],
    );
  }

  textFieldBlockPassword(String translate,TextEditingController controller,BuildContext context,bool hide,bool validate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: App.textNormal(Colors.grey, 14),),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
            obscureText: hide,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: validate?Colors.white:Colors.red)
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: validate?App.orange:Colors.red)
                ),
                suffix: IconButton(
                  onPressed: (){
                    signUpController.change_visibilty();
                  },
                  icon: Icon(!hide?Icons.visibility:Icons.visibility_off,color: Colors.white,size: 20,),
                )
            ),
            style: App.textNormal(Colors.white, 14),
          ),
        ),
        SizedBox(height: 50,)
      ],
    );
  }

}