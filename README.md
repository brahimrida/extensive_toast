# Flutter Toast Widget

A customizable Flutter toast widget for displaying notifications, messages, errors, and other temporary UI feedback within your application.

## Features

* Fully customizable.
* Display toasts on a specific screen or across the entire application.
* Position toasts at the top or bottom of the screen.
* Dismiss toasts by:

  * Tapping.
  * Swiping.
  * Automatically after a specified duration.
* Supports three built-in layout structures.
* Supports completely custom content using your own widget.
* A single manager class handles toast insertion, removal, and clearing.
* Control individual toasts programmatically using a unique toast reference.

## Getting Started

Add the package to your project:

```bash
flutter pub add extensive_toast
```

Then import it:

```dart
import 'package:extensive_toast/extensive_toast.dart';
```

## Usage

### Displaying a Toast

The simplest way to display a toast is by calling the `insertToast` static method:

```dart
GestureDetector(
  onTap: () {
    ExtensiveToastManager.insertToast(
      context,
      toast: ExtensiveToast(
        title: ":)",
        body: "Hello, and Goodbye!!",
        autoDismiss: true,
      ),
    );
  },
  child: const Text("Show toast"),
)
```

By default, the toast is displayed at the top of the screen. You can configure its position to display it at either the top or bottom.

`insertToast` requires a `BuildContext` and an `ExtensiveToast` instance containing the configuration and customization options for the toast.

`ExtensiveToastManager` handles the insertion and lifecycle of your toasts.

## Dismissing Toasts

A toast can be dismissed in three different ways:

* **Swipe:** Swipe the toast away.
* **Tap:** Dismiss the toast when tapped if the corresponding option is enabled.
* **Automatically:** Enable automatic dismissal and provide a duration.

## Managing Toasts

### Remove All Toasts

To remove every currently displayed toast:

```dart
ExtensiveToastManager.clearAllToasts();
```

### Remove a Single Toast

Each inserted toast has a unique reference. You can use that reference to remove a specific toast:

```dart
ExtensiveToastManager.removeToast(toastReference);
```

The toast reference is managed internally by the toast widget.

### Get the Toast Reference

If you need to control a toast from outside the widget itself, you can provide the optional `toastReference` callback when inserting it.

The callback gives you the unique reference of the inserted toast:

```dart
ExtensiveToastManager.insertToast(
  context,
  toast: ExtensiveToast(
    title: "Hello",
    body: "This is a toast",
  ),
  toastReference: (toastRef) {
    // Store the reference if you need to remove
    // this toast programmatically later.
  },
);
```

You can then use the reference with:

```dart
ExtensiveToastManager.removeToast(toastRef);
```

This allows you to control an individual toast from anywhere in your application.

## Additional Information

For feature requests, bug reports, contributions, or more information, visit the package's repository page.
