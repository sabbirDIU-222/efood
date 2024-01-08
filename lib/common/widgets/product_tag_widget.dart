import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/product_model.dart';
import 'package:flutter_restaurant/features/splash/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class ProductTagWidget extends StatelessWidget {
  final Product product;
  const ProductTagWidget({
    Key? key, required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splashProvider, _) {
      return Visibility(
        visible: splashProvider.configModel!.isVegNonVegActive!,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: product.productType == 'veg'
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColor, width: 2,
            ),
          ),
          padding: const EdgeInsets.all(1),
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: product.productType == 'veg'
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    });
  }
}
