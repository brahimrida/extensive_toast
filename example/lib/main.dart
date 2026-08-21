import 'package:extensive_toast/extensive_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int displayedToasts = 0;

  void _clearAll() {
    ExtensiveToastManager.clearAllToasts();
    setState(() {
      displayedToasts = ExtensiveToastManager.count;
    });
  }

  void _reflectCount() {
    setState(() {
      displayedToasts = ExtensiveToastManager.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: _clearAll,
        child: Container(
          alignment: .center,
          height: 100,
          width: 100,
          color: Colors.red,
          child: Text(
            "clear all",
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 20,
          children: [
            Text('Hello Extensive Toast!'),

            Text("Toasts Count: $displayedToasts"),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
              ),
              onPressed: () {
                ExtensiveToastManager.insertToast(
                  context,
                  toast: ExtensiveToast(
                    backgroundColor: Colors.amberAccent,
                    title: ":)",
                    body: "Auto dismissed",
                    onDismiss: _reflectCount,
                  ),
                );
                _reflectCount();
              },
              child: Text("auto dismissed toast"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                ExtensiveToastManager.insertToast(
                  context,
                  toast: ExtensiveToast(
                    backgroundColor: Colors.greenAccent,
                    title: ":)",
                    body: "Removed on tap",
                    autoDismiss: false,
                    removeOnTap: true,
                    onDismiss: _reflectCount,
                  ),
                );
                _reflectCount();
              },
              child: Text("removed on tap toast"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                ExtensiveToastManager.insertToast(
                  context,

                  toast: ExtensiveToast(
                    backgroundColor: Colors.redAccent,
                    autoDismiss: false,

                    title: ":)",
                    body: "removed when swiped",
                    onDismiss: _reflectCount,
                  ),
                );
                _reflectCount();
              },
              child: Text("swiped to remove toast"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                ExtensiveToastManager.insertToast(
                  context,

                  toast: ExtensiveToast(
                    backgroundColor: Colors.blueAccent,
                    autoDismiss: true,
                    from: .bottom,
                    title: ":)",
                    body: "show from bottom while auto dismissed",
                    onDismiss: _reflectCount,
                  ),
                );
                _reflectCount();
              },
              child: Text("swiped to remove toast"),
            ),
          ],
        ),
      ),
    );
  }
}
