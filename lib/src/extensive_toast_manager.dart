

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

  /// Inserts [toast] into the nearest (or root) [Overlay] and returns a
  /// reference to it via [toastReference].
  ///
  /// Use [rootOverlay] to choose whether the toast is displayed
  /// above the entire app (root overlay) or within the nearest
  /// local overlay scope (e.g. a nested Navigator's own overlay).
  ///
  /// Note: [rootOverlay] only controls *where the toast is shown*,
  /// not where `onTap` navigation lands. The `context` your `onTap`
  /// callback receives is scoped to wherever the toast widget itself
  /// sits in the tree. If you navigate inside `onTap` using
  /// `Navigator.push(context, ...)`, it resolves to the *nearest*
  /// Navigator to that context — which may not be the Navigator
  /// you expect, especially if your app has nested Navigators
  /// (e.g. per-tab navigation). If your push isn't showing up until
  /// you switch screens, try `Navigator.of(context, rootNavigator: true)`
  /// explicitly inside your `onTap`.
  ///
  /// The toast may already be removed (e.g. after its display duration
  /// elapses) by the time you act on the reference passed to
  /// [toastReference]. Removing an already-removed toast is a safe
  /// no-op, but you can call [isToastActive] first if you need to know
  /// whether the toast is still showing.
  static void insertToast(
    BuildContext context, {
    required ExtensiveToast toast,
    bool rootOverlay = true,
    Function(int toastRef)? toastReference,
  }) {
    int ref = _nextRef++;
    final overlayStack = Overlay.of(context, rootOverlay: rootOverlay);
    final extensiveToastEntry = toast.newToastEntry(ref);
    overlayStack.insert(extensiveToastEntry.entry);
    _toasts.add(extensiveToastEntry);
    toastReference?.call(ref);
  }

  /// Returns `true` if the toast referenced by [ref] is still active
  /// (i.e. hasn't been removed yet). Use this to guard manual removal
  /// when relying on the `toastReference` callback from [insertToast],
  /// since that reference can become stale.
  static bool isToastActive(int ref) => _toasts.indexWhere((e) => e.ref == ref) >= 0;


  /// Removing a toast by reference
  static void removeToast(int ref) {
    final index = _toasts.indexWhere((e) => e.ref == ref);
    if (index >= 0) {
      final toast = _toasts.removeAt(index);
      toast.entry.remove();
    }
  }

  /// To completely wipe the managed toasts
  static void clearAllToasts() {
    for (ExtensiveToastEntry toast in _toasts) {
      toast.entry.remove();
    }
    _toasts.clear();
  }
}

