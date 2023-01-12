import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/option_item.dart';

class SOSButton extends StatelessWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(context),
      child: Container(
        width: 84,
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
            child: Text(
          "SOS",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }

  showDialog(BuildContext context) {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Notruf wählen",
        context: context,
        pageBuilder: (context, _, __) => const SOSDialog());
  }
}

class SOSDialog extends StatelessWidget {
  const SOSDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SOS Notruf",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OptionItem(
                            imgPath: "assets/images/polizei.png",
                            text: "Polizei",
                            onTap: (context) => launch("tel:+490000000"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OptionItem(
                            imgPath: "assets/images/lawyer.png",
                            text: "Rechts-beratung",
                            onTap: (context) => launch("tel:+490000000"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 84,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Close",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
