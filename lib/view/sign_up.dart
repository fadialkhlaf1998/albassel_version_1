// ignore_for_file: must_be_immutable

import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/controler/sign_up_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUp extends StatelessWidget{

  SignUpController signUpController= Get.put(SignUpController());

  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController phone=TextEditingController();


  SignUp({Key? key}) : super(key: key){
    signUpController.showCustomerType.value = true;
    signUpController.showFileUploader.value = true;
  }

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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image:DecorationImage(
                image: AssetImage("assets/background/signin.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(

                child:signUpController.loading.value?
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator(),))
                    :signUpController.showCustomerType.value?customerType(context)
                    :signUpController.showFileUploader.value?fileUploader(context)
                    :Column(
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
                        textFieldBlock("first_name",fname,context,signUpController.fname_vaildate.value),
                        textFieldBlock("last_name",lname,context,signUpController.lname_vaildate.value),
                        Global.customer_type==0?const Center():phoneBlock("phone",phone,context,signUpController.phone_vaildate.value),
                        textFieldBlock("email",email,context,signUpController.email_vaildate.value),
                        Obx((){
                          return textFieldBlockPassword("password",password,context,signUpController.hide_passeord.value,signUpController.pass_vaildate.value);
                        }),
                        GestureDetector(
                          onTap: (){
                            openCountryPicker(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.arrow_drop_up,color: Colors.transparent,),

                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(signUpController.country.value,style: const TextStyle(color: Colors.white),),
                                ),

                                const Icon(Icons.arrow_drop_up,color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),

                    GestureDetector(
                      onTap: (){
                        signUpController.signUp(context,email.value.text,password.value.text,fname.value.text,lname.value.text,phone.text,signUpController.country_code.value);
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
                        const SizedBox(width: 5,),
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
          ),
        );
      })
    );
  }
  openCountryPicker(BuildContext context){
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        signUpController.country.value = country.name;
        signUpController.country_code.value = country.countryCode;
      },
    );
  }
  phoneBlock(String translate,TextEditingController controller,BuildContext context,bool validate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: App.textNormal(Colors.grey, 14),),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width*0.9,
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: Colors.white),
            initialValue: signUpController.isoCode.value,
            textFieldController: controller,
            formatInput: false,
            keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
            // controller: controller,
            textStyle: App.textNormal(Colors.white, 14),
            maxLength: 9,
            inputDecoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: validate?Colors.white:Colors.red)
              ),
              focusedBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: validate?App.orange:Colors.red)
              ),
            ),
            // style: App.textNormal(Colors.white, 14),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
              signUpController.isoCode.value = number;
            },
          ),
        ),
        const SizedBox(height: 50,)
      ],
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

  textFieldBlockPassword(String translate,TextEditingController controller,BuildContext context,bool hide,bool validate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(App_Localization.of(context).translate(translate),style: App.textNormal(Colors.grey, 14),),
        SizedBox(
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
        const SizedBox(height: 50,)
      ],
    );
  }

  customerType(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          ],
        ),

        const SizedBox(height: 120,),

          Container(
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
              color: App.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
              onTap: (){
                signUpController.setCustomerType(0);
              },
              title: Text(App_Localization.of(context).translate("user"),style: const TextStyle(color: Colors.white),),
              subtitle: Text(App_Localization.of(context).translate("user_sub_title"),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
              selectedColor: App.orange,
              selectedTileColor:  App.orange,
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person,color: App.orange,),
              ),
            ),
          ),
        const SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              color: App.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            onTap: (){
              signUpController.setCustomerType(1);
            },
            title: Text(App_Localization.of(context).translate("salon"),style: const TextStyle(color: Colors.white),),
            subtitle: Text(App_Localization.of(context).translate("salon_sub_title"),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
            selectedColor: App.orange,
            selectedTileColor:  App.orange,
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.home_sharp,color: App.orange,),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              color: App.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            onTap: (){
              signUpController.setCustomerType(2);
            },
            title: Text(App_Localization.of(context).translate("whole_saller"),style: const TextStyle(color: Colors.white),),
            subtitle: Text(App_Localization.of(context).translate("whole_saller_sub_title"),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12,),),
            selectedColor: App.orange,
            selectedTileColor:  App.orange,
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.shop_two_outlined,color: App.orange,),
            ),
          ),
        )
      ],
    );
  }
  fileUploader(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context).translate("please_upload_license"),style: TextStyle(color: App.orange,fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: ()async{
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null&&result.files.single.path != null) {
                signUpController.path = result.files.single.path!;
                signUpController.showFileUploader.value = false;
              } else {
                App.error_msg(context, "oops");
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.width*0.3/1.5,
              decoration: BoxDecoration(
                  color: App.orange.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      height: MediaQuery.of(context).size.width*0.3/1.5,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.cloud_upload_outlined,color: Colors.white,size: MediaQuery.of(context).size.width*0.3/3)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}