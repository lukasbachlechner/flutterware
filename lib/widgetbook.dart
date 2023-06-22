/* import 'package:flutter/material.dart';
import 'package:flutterware/src/theme/dark_theme.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'src/theme/light_theme.dart';

@WidgetbookApp.material(
  name: 'Flutterware',
  devices: [
    Apple.iPhone13Pro,
  ],
  foldersExpanded: true,
  widgetsExpanded: true,
)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterware',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutterware'),
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutterware/src/theme/light_theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the generated directories variable
import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use the generated directories variable
      directories: directories,
      addons: [
        /*  DeviceFrameAddon(
          initialDevice: Devices.ios.iPhone13,
          devices: [
            Devices.ios.iPhone13,
          ],
        ), */
        ThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: getLightTheme()),
          ],
          themeBuilder: (context, theme, child) =>
              Theme(data: theme, child: child),
        )
      ],
      appBuilder: (context, child) {
        return child;
      },
    );
  }
}
