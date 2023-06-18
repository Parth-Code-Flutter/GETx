
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../common/color_constants.dart';

class dynamicWidget extends StatelessWidget {
  TextEditingController sizeController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  bool isVarient=false;
   dynamicWidget({Key? key, required this.isVarient}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
//      margin: new EdgeInsets.all(8.0),
      child:ListBody(
        children: <Widget>[
          Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  if (isVarient)
                  SizedBox(
                    width:isVarient
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                   // height: Get.height * 0.05,
                    child: Material(
                      shadowColor: kColorDropShadow,
                      child: TextFormField(
                        scrollPadding:EdgeInsets.all(0),
                        controller:sizeController,
                        keyboardType: TextInputType.number,
                        //maxLength: 5,
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kColorTextFieldBorder, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: isVarient
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                    //height: Get.height * 0.05,
                    child: Material(
                      shadowColor: kColorDropShadow,
                      child: TextFormField(
                        scrollPadding:EdgeInsets.all(0),
                        controller: qtyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kColorTextFieldBorder, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: isVarient
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                   // height: Get.height * 0.05,
                    child: Material(
                      // elevation: 8.0,
                      shadowColor: kColorDropShadow,
                      child: TextFormField(
                        scrollPadding:EdgeInsets.all(0),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kColorTextFieldBorder, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                    SizedBox(
                      width: isVarient
                          ? Get.width * 0.17
                          : Get.width * 0.22,
                    //  height: Get.height * 0.05,
                      child: Material(
                        shadowColor: kColorDropShadow,
                        child: TextFormField(
                          scrollPadding:EdgeInsets.all(0),
                          controller: discountController,
                          keyboardType: TextInputType.number,
                        //  maxLength: 5,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                            counterText: '',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1)),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kColorTextFieldBorder, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       width: 200,
          //       padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          //       child: new TextFormField(
          //         controller: Product,
          //         decoration: const InputDecoration(
          //             labelText: 'Product Name',
          //             border: OutlineInputBorder()
          //         ),
          //       ),
          //     ),
          //     Container(
          //       width: 100,
          //       padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          //       child: new TextFormField(
          //         controller: Price,
          //         decoration: const InputDecoration(
          //             labelText: 'Price',
          //             border: OutlineInputBorder()
          //         ),
          //         keyboardType: TextInputType.number,
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

}