import 'package:flutter/cupertino.dart';
import 'package:flutter_pixabay_api_search_app/app/pixabay_search/pixabay_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Create application that uses Cupertino (iOS) design.
    return CupertinoApp(
      title: 'Pixabay API Search App',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        // make primary colour orange so that the correct cursor color is set
        primaryColor: CupertinoColors.activeOrange,
      ),
      // Basic visual layout structure for single page iOS app
      home: CupertinoPageScaffold(
        // wrap all content in safe area to prevent clash with OS interface
        child: SafeArea(
          // main application specific code
          child: PixabaySearch(),
        ),
      ),
    );
  }
}
