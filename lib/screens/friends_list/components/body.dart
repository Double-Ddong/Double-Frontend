import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';

import '../../../size_config.dart';
import '../friends_list_screen.dart';
import 'friends_list.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all((30)),
      child: Column(
        children: [
          // HomeHeader(),
          // SizedBox(height: getProportionateScreenWidth(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "ㅇㅇ대학교 친구들",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  ),
              ),
            ],
          ),
          Expanded(child: ListView.builder(
            itemCount: 4,
            itemBuilder: (_,i){
              return GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, DetailsScreen.routeName)
                },
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: SizeConfig.screenWidth * 0.35,
                      height: SizeConfig.screenHeight * 0.25,
                      padding: EdgeInsets.only(left: 30, right: 30,bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/paypal.png"
                            )
                        ),
                        boxShadow: [
                        ],
                      ),
                      child: Center(
                        child : Align(
                          alignment: Alignment.bottomCenter,

                          child: Text(
                            "김보현",
                            style: TextStyle(
                              fontSize: 20,
                              // color: Color.black
                            ),
                          ),
                        ),)
                  ),

                  Container(
                      width: SizeConfig.screenWidth * 0.35,
                      height: SizeConfig.screenHeight * 0.25,
                      padding: EdgeInsets.only(left: 30, right: 30,bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/paypal.png"
                            )
                        ),
                        boxShadow: [

                        ],

                      ),
                      child: Center(
                        child : Align(
                          alignment: Alignment.bottomCenter,

                          child:
                          Text(
                            "김보현",
                            style: TextStyle(
                              fontSize: 20,
                              // color: Color.black
                            ),
                          ),
                          // Column(
                          //   children: [
                          //     Text(
                          //     "김보현",
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       // color: Color.black
                          //     ),
                          //   ),
                          //   ],
                          // )
                        ),)
                  )
                ],
              )
              );


          }
          )),
          SizedBox(height: 30,),

        ],
      ),
    );
      
    //   SafeArea(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SizedBox(height: getProportionateScreenHeight(20)),
    //         // SpecialOffers(),
    //         SizedBox(height: getProportionateScreenWidth(15)),
    //         FriendsList(),
    //         SizedBox(height: getProportionateScreenWidth(30)),
    //
    //       ],
    //     ),
    //   ),
    // );
  }
}
