import 'package:url_launcher/url_launcher.dart';

class CommonUrlLauncher {
  Future launchMap(String address) async {
    final uri = Uri.parse(address);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch Map $uri';
    }
  }
}
