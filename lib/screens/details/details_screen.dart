import 'package:flutter/material.dart';
import 'package:shop_app/models/Friends.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final FriendDetailsArguments friendagrs =
    ModalRoute.of(context)!.settings.arguments as FriendDetailsArguments;
    return Scaffold(
      //backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(23.0),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      //body: Body(product: agrs.product),
      body: Body(),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}

class FriendDetailsArguments {
  final Friends friends;

  FriendDetailsArguments({required this.friends});
}
