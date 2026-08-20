
import 'package:extensive_toast/src/extensive_toast_versions_enum.dart';
import 'package:flutter/material.dart';

class StructureOne extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const StructureOne({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.titleTextColor,
    required this.bodyTextColor,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        icon,
        Flexible(
          child: Column(
            crossAxisAlignment: .start,

            children: [
              Flexible(
                child: Text(title, style: TextStyle(color: titleTextColor)),
              ),
              Flexible(
                child: Text(
                  body,
                  overflow: .ellipsis,
                  style: TextStyle(color: bodyTextColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StructureTwo extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StructureTwo({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.titleTextColor,
    required this.bodyTextColor,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        icon,
        Flexible(
          child: Text(title, style: TextStyle(color: titleTextColor)),
        ),
        Flexible(
          child: Text(
            body,
            overflow: .ellipsis,
            style: TextStyle(color: bodyTextColor),
          ),
        ),
      ],
    );
  }
}

class StructureThree extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StructureThree({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.titleTextColor,
    required this.bodyTextColor,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: 10,
      children: [
        Flexible(
          child: Text(title, style: TextStyle(color: titleTextColor)),
        ),
        icon,
        Flexible(
          child: Text(
            body,
            overflow: .ellipsis,
            style: TextStyle(color: bodyTextColor),
          ),
        ),
      ],
    );
  }
}

class ExtesnsiveToastContent extends StatelessWidget {
  final ToastVersion v;
  final Widget? icon;
  final String? title;
  final String? body;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const ExtesnsiveToastContent({
    super.key,
    required this.v,
    this.icon,
    this.title,
    this.body,
    this.titleTextColor,
    this.bodyTextColor,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    switch (v) {
      case .version1:
        return StructureOne(
          icon: icon!,
          title: title!,
          body: body!,
          titleTextColor: titleTextColor,
          bodyTextColor: bodyTextColor,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
      case .version2:
        return StructureTwo(
          icon: icon!,
          title: title!,
          body: body!,
          titleTextColor: titleTextColor,
          bodyTextColor: bodyTextColor,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
      default:
        return StructureThree(
          icon: icon!,
          title: title!,
          body: body!,
          titleTextColor: titleTextColor,
          bodyTextColor: bodyTextColor,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
    }
  }
}
