import 'dart:async';

import 'package:extensive_toast/src/extensive_toast_manager.dart';
import 'package:extensive_toast/src/extensive_toast_startingpoint_enum.dart';
import 'package:extensive_toast/src/extensive_toast_versions_enum.dart';
import 'package:extensive_toast/src/extensive_toast_content_structures.dart';
import 'package:flutter/material.dart';




class ExtensiveToastWidget extends StatefulWidget {
  final String title;
  final String body;
  final int myRef;
  final bool removeOnTap;
  final VoidCallback? onTap;
  final StartingPoint showFrom;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final List<BoxShadow>? shadows;
  final Duration enterDuration;
  final Duration exitDuration;
  final Curve enterAnimation;
  final Widget icon;
  final double distanceFromStart;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final Color? backgroundColor;
  final bool autoDismiss;
  final Duration dismissAfter;
  final VoidCallback? onDismiss;
  final ToastVersion toastVersion;
  final MainAxisAlignment contentMainAxisAlignment;
  final CrossAxisAlignment contentCrossAxisAlignment;
  final Widget? customContent;

  const ExtensiveToastWidget({
    super.key,
    required this.title,
    required this.body,
    required this.myRef,
    required this.removeOnTap,
    required this.icon,
    required this.enterDuration,
    required this.exitDuration,
    required this.autoDismiss,
    required this.dismissAfter,
    required this.distanceFromStart,
    required this.toastVersion,
    required this.contentMainAxisAlignment,
    required this.contentCrossAxisAlignment,
    required this.showFrom,
    required this.height,
    required this.width,
    required this.padding,
    required this.margin,
    required this.enterAnimation,
    this.onTap,
    this.shadows,
    this.onDismiss,
    this.titleTextColor,
    this.bodyTextColor,
    this.backgroundColor,
    this.customContent,

  }) : assert(
         (dismissAfter > enterDuration) &&
             (customContent != null && toastVersion == .custom ||
                 customContent == null && toastVersion != .custom),
       );

  @override
  State<ExtensiveToastWidget> createState() => _ExtensiveToastWidgetState();
}

class _ExtensiveToastWidgetState extends State<ExtensiveToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  Timer? _timer;
  double _position = 0;
  bool _removed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.exitDuration,
    );
    // attaching listener
    _controller.addStatusListener(_onStatusChange);
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.autoDismiss) {
      _timer = Timer(widget.dismissAfter, () {
        if (!_removed) {
          _controller.forward();
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer?.cancel();
  }

  void _onStatusChange(AnimationStatus status) {
  if (status.isCompleted) {
    _removeToast();
    }
  }

  void _start() => setState(() => _position = widget.distanceFromStart);

  void _removeToast() {
  if (_removed) return;
  _removed = true;
  ExtensiveToastManager.removeToast(widget.myRef);
  widget.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: widget.enterAnimation,
      left: 0,
      right: 0,
      top: widget.showFrom == .top ? _position : null,
      bottom: widget.showFrom == .bottom ? _position : null,
      duration: widget.enterDuration,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            widget.onTap?.call();
            if (widget.removeOnTap) {
              _removeToast();
            }
          },
          child: SlideTransition(
            position: _slideAnimation,
            child: Dismissible(
              onDismissed: (direction) => _removeToast(),
              key: ValueKey(widget.myRef),
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: widget.padding,
                margin: widget.margin,
                decoration: BoxDecoration(
                  boxShadow:
                      widget.shadows ??
                      [
                        BoxShadow(
                          color: Colors.grey.withAlpha(50),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                  color: widget.backgroundColor ?? Colors.white,
                  borderRadius: .circular(15),
                ),
                child: widget.toastVersion == .custom
                    ? widget.customContent
                    : ExtesnsiveToastContent(
                        v: widget.toastVersion,
                        icon: widget.icon,
                        title: widget.title,
                        body: widget.body,
                        titleTextColor: widget.titleTextColor,
                        bodyTextColor: widget.bodyTextColor,
                        mainAxisAlignment: widget.contentMainAxisAlignment,
                        crossAxisAlignment: widget.contentCrossAxisAlignment,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
