
// ignore_for_file: must_be_immutable

import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view.dart';

class ImageShow extends StatelessWidget {

  String image;


  ImageShow(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(

            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                color: App.midOrange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _header(context),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height * 0.1),
                      child: PhotoView(
                       imageProvider: NetworkImage(image),
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      color: App.midOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 0,left: 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10,left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => Home());
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
