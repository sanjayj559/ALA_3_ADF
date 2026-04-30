import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver(
      onScreenshot: (String name, List<int> bytes, [Map<String, dynamic>? args]) async {
        final File image = File('assets/images/$name.png');
        await image.writeAsBytes(bytes);
        print('Screenshot saved to: ${image.path}');
        return true;
      },
    );
