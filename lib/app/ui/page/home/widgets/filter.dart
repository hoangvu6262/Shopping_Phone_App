import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
    @required this.tap,
  }) : super(key: key);

  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: tap,
        child: Container(
          height: 35.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20 * 0.4),
          margin: EdgeInsets.only(right: 20 * 0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/filter.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
