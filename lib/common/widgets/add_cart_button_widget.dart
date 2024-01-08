import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/styles.dart';

class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.2), offset: const Offset(0, 5), blurRadius: 20)
          ]
      ),
      child: Row(children: [
        Icon(Icons.add_circle, color: Theme.of(context).primaryColor, size: Dimensions.paddingSizeLarge),
        const SizedBox(width: Dimensions.paddingSizeSmall),


        Text(getTranslated('add', context)!, style: rubikMedium.copyWith(
          color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall,
        )),
      ]),
    );
  }
}
