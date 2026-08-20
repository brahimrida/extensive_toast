import 'package:flutter/material.dart';

/// a representation class that carries a reference for the entry and plays
/// a role in inserting and removing toasts successfully
class ExtensiveToastEntry {
  final OverlayEntry entry;
  final int ref;

  ExtensiveToastEntry({required this.entry, required this.ref});
}