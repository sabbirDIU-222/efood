import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';

class CustomShadowWidget extends StatelessWidget {

  final Widget child;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final double? borderRadius;

  const CustomShadowWidget({
    Key? key, required this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius = Dimensions.radiusDefault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ,
      margin:  margin,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(offset: const Offset(0, 5), blurRadius: 15, spreadRadius: -3, color: Theme.of(context).primaryColor.withOpacity(0.01)),

          BoxShadow(offset: const Offset(0, 0), blurRadius: 3, color: Theme.of(context).primaryColor.withOpacity(0.02)),
        ],
      ),
      child: child,
    );
  }
}
