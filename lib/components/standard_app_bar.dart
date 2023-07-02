

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtim_innovation_assigment/components/standard_regular_text.dart';
import 'package:realtim_innovation_assigment/utils/colors_utils.dart';

class StandardAppbar  extends StatelessWidget implements PreferredSizeWidget {
final Color? backgroundColor = primaryColor;
final StandardCustomText? title;
final AppBar? appBar;
final List<Widget>? widgets;


const StandardAppbar({Key? key, this.title, this.appBar, this.widgets})
: super(key: key);

@override
Widget build(BuildContext context) {
  return AppBar(
    title: title,
    centerTitle: false,
    backgroundColor: backgroundColor,
    actions: widgets,
      leadingWidth: 0
  );
}

@override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}