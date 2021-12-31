import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class TESTT extends StatefulWidget {
  const TESTT({Key? key}) : super(key: key);

  @override
  _TESTTState createState() => _TESTTState();
}

class _TESTTState extends State<TESTT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('UrlLauncher'),
      ),
      body: Link(
        uri: Uri.parse(
            'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
        target: LinkTarget.blank,
        builder: (BuildContext ctx, FollowLink? openLink) {
          return TextButton.icon(
            onPressed: openLink,
            label: const Text('Link Widget documentation'),
            icon: const Icon(Icons.read_more),
          );
        },
      ),
    );
  }
}
