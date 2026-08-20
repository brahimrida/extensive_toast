

import 'package:extensive_toast/src/extensive_toast_entry.dart';

import '../extensive_toast.dart';
import 'package:flutter/material.dart';

/// the class that manages all your toasts through exposing it's static methods
class ExtensiveToastManager {

  /// list of toasts to keep track of the overlay Stack
  /// managed by the package
  static final List<ExtensiveToastEntry> _toasts = [];

  /// internal reference to be used in case we insert or remove a toast
  /// entry from both the [_toasts] list and [overlayStack]
  static int _nextRef = 0;

  /// to know how many toasts are currently displayed
  static int get count => _toasts.length;

  /// Use [rootOverlay] to choose whether the toast is displayed
  /// above the entire app (root overlay) or within the nearest
  /// local overlay scope (e.g. a nested Navigator's own overlay).
  ///
  /// Note: this setting only controls *where the toast is shown*,
  /// not where `onTap` navigation lands. The `context` your `onTap`
  /// callback receives is scoped to wherever the toast widget itself
  /// sits in the tree. If you navigate inside `onTap` using
  /// `Navigator.push(context, ...)`, it resolves to the *nearest*
  /// Navigator to that context — which may not be the Navigator
  /// you expect, especially if your app has nested Navigators
  /// (e.g. per-tab navigation). If your push isn't showing up until
  /// you switch screens, try `Navigator.of(context, rootNavigator: true)`
  /// explicitly inside your `onTap`.
  static void insertToast(
    BuildContext context, {
    required ExtensiveToast toast,
    bool rootOverlay = true,
  }) {
    final overlayStack = Overlay.of(context, rootOverlay: rootOverlay);
    final extensiveToastEntry = toast.newToastEntry(_nextRef++);
    overlayStack.insert(extensiveToastEntry.entry);
    _toasts.add(extensiveToastEntry);
  }


  /// removing a toast using the internally stored reference passed by the widget (toast widget) itself
  static void removeToast(int ref) {
    final index = _toasts.indexWhere((e) => e.ref == ref);
    if (index >= 0) {
      final toast = _toasts.removeAt(index);
      toast.entry.remove();
    }
  }

  /// to fully wipe the managed toasts
  static void clearAllToasts() {
    for (ExtensiveToastEntry toast in _toasts) {
      toast.entry.remove();
    }
    _toasts.clear();
  }
}

