library;

export 'src/extensive_toast_manager.dart';
export 'src/extensive_toast_versions_enum.dart';
export 'src/extensive_toast_startingpoint_enum.dart';

import 'src/extensive_toast_startingpoint_enum.dart';

import 'src/extensive_toast_entry.dart';
import 'src/extensive_toast_versions_enum.dart';
import 'src/extensive_toast_widget.dart';
import 'package:flutter/material.dart';

/// toast class to create a custom toast
/// it's what constructs a toast widget internally

class ExtensiveToast {
  /// title text
  final String title;

  /// body text
  final String body;

  /// could be anything widget
  /// defaults to notification icon
  final Widget icon;

  /// top or bottom
  final StartingPoint from;

  /// if you want the toast to be remove when tapped
  final bool removeOnTap;

  /// when the toast is clicked
  final VoidCallback? onTap;

  /// toast widget height
  final double height;

  /// toast widget width minus the default paddding
  /// set the padding to 0 if you want the toast to
  /// take the whole width
  final double width;

  /// padding
  final EdgeInsetsGeometry padding;

  /// margin
  final EdgeInsetsGeometry margin;

  /// serounding list of shadows
  final List<BoxShadow>? shadows;

  /// how much time until the toast reaches it's position
  final Duration enterDuration;

  /// how much time it takes for the toast to exit the screen
  final Duration exitDuration;

  /// animation style when the toast is entering your screen
  final Curve enterAnimation;

  /// how far the toast travels from the entering position
  /// while being animated
  final double distanceFromStart;

  final Color? titleTextColor;
  final Color? bodyTextColor;
  final Color? backgroundColor;

  /// how much time until the toast is dismissed autimatically
  final Duration dismissAfter;

  /// if you need the toast to disappear by it's own
  final bool autoDismiss;

  /// when the toast is dismissed manually or automatically
  final VoidCallback? onDismiss;

  /// this enum is to select one of the existing structures
  /// if you want to use your own content set pass the custom enum instead of a version
  final ToastVersion toastVersion;

  final MainAxisAlignment contentMainAxisAlignment;

  final CrossAxisAlignment contentCrossAxisAlignment;

  /// pass a whole widget to override the existing content inside the toast
  /// use in case you want to have your own content.
  /// [important] set the toastVersion to custom when passing your own content
  final Widget? customContent;

  /// instance used to construct your toast
  ExtensiveToast({
    required this.title,
    required this.body,
    this.icon = const Icon(Icons.notifications),
    this.from = .top,
    this.removeOnTap = false,
    this.height = 70,
    this.width = double.infinity,
    this.onTap,
    this.padding = const .all(10),
    this.margin = const .symmetric(vertical: 10, horizontal: 25),
    this.shadows,
    this.enterDuration = const Duration(milliseconds: 1000),
    this.exitDuration = const Duration(milliseconds: 1000),
    this.enterAnimation = Curves.easeIn,
    this.distanceFromStart = 70,
    this.titleTextColor,
    this.bodyTextColor,
    this.backgroundColor,
    this.dismissAfter = const Duration(milliseconds: 2500),
    this.autoDismiss = true,
    this.onDismiss,
    this.toastVersion = .version1,
    this.contentMainAxisAlignment = .start,
    this.contentCrossAxisAlignment = .center,
    this.customContent,
  });

  ExtensiveToastWidget _constructToastWidget(int myRef) => ExtensiveToastWidget(
    title: title,
    body: body,
    myRef: myRef,
    removeOnTap: removeOnTap,
    onTap: onTap,
    showFrom: from,
    height: height,
    width: width,
    padding: padding,
    margin: margin,
    shadows: shadows,
    backgroundColor: backgroundColor,
    icon: icon,
    titleTextColor: titleTextColor,
    bodyTextColor: bodyTextColor,
    dismissAfter: dismissAfter,
    enterDuration: enterDuration,
    exitDuration: exitDuration,
    enterAnimation: enterAnimation,
    distanceFromStart: distanceFromStart,
    autoDismiss: autoDismiss,
    onDismiss: onDismiss,
    toastVersion: toastVersion,
    contentMainAxisAlignment: contentMainAxisAlignment,
    contentCrossAxisAlignment: contentCrossAxisAlignment,
    customContent: customContent,
  );

  ExtensiveToastEntry newToastEntry(int newRef) {
    return ExtensiveToastEntry(
      entry: OverlayEntry(builder: (context) => _constructToastWidget(newRef)),
      ref: newRef,
    );
  }
}
