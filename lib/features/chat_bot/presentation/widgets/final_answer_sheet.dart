import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/option_item.dart';

class FinalAnswerSheet extends StatelessWidget {
  final String message;
  const FinalAnswerSheet({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                _subtracktParagraph(message),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(color: Colors.black.withOpacity(0.3), height: 1),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  children:
                      _buildTextSpans(_subtracktRestAfterParagarph(message)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Bitte beachte, dass ich kein Ersatz für eine angemessene rechtliche Vertretung bin",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OptionItem(
                    text: "Kostenlose\nBeratung",
                    imgPath: "assets/images/lawyer.png",
                    onTap: (_) => launchUrl(
                        Uri.parse("https://www.advocado.de/rechtsanwalt.html")),
                    elevation: 6,
                  ),
                  OptionItem(
                    text: "Studentische\nRechts-\nberatung",
                    imgPath: "assets/images/lawyer.png",
                    onTap: (_) => launchUrl(
                        Uri.parse("https://www.refrat.de/beratung.recht.html")),
                    elevation: 6,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Center(
                    child: Text(
                      "Zurück zum Start",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  String _subtracktParagraph(String message) {
    // Finde first * and next * and subtrackt the string
    message = message.substring(message.indexOf("*") + 1);
    message = message.substring(0, message.indexOf("*"));

    return message;
  }

  String _subtracktRestAfterParagarph(String message) {
    // subtrackt the string after the first two *
    message = message.substring(message.indexOf("*") + 1);
    message = message.substring(message.indexOf("*") + 1);

    while (message.startsWith("\n")) {
      message = message.substring(2);
    }

    return message;
  }

  List<TextSpan> _buildTextSpans(String text) {
    final pattern = RegExp(r'\*(.+?)\*');
    final matches = pattern.allMatches(text);
    int currentPosition = 0;
    final spans = <TextSpan>[];
    for (Match match in matches) {
      if (match.start > currentPosition) {
        spans.add(TextSpan(
          text: text.substring(currentPosition, match.start),
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      currentPosition = match.end;
    }
    if (currentPosition < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentPosition),
      ));
    }
    return spans;
  }
}
