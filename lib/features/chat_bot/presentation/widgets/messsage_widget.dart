import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageWidget extends StatefulWidget {
  final Widget child;
  final bool showLoadingAnimation;
  final bool isBot;
  const MessageWidget({
    Key? key,
    required this.child,
    this.showLoadingAnimation = true,
    required this.isBot,
  }) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool showChild = false;

  final Duration loadingDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    showChild = !widget.showLoadingAnimation;
    if (widget.showLoadingAnimation) {
      Future.delayed(loadingDuration)
          .then((value) => setState(() => showChild = true));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...(widget.isBot
                ? const [MessageAvatar(), SizedBox(width: 10)]
                : [SizedBox(width: MediaQuery.of(context).size.width / 4)]),
            MessageBubble(
              left: widget.isBot,
              child: showChild
                  ? widget.child
                  : SizedBox(
                      width: 14,
                      height: 14,
                      child: SpinKitThreeBounce(
                        size: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                      ),
                    ),
            ),
            ...(!widget.isBot
                ? []
                : [SizedBox(width: MediaQuery.of(context).size.width / 4)]),
          ],
        ),
      ),
    );
  }
}

class MessageAvatar extends StatelessWidget {
  const MessageAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        shape: BoxShape.circle,
      ),
      child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            "assets/images/robot-avatar.png",
            filterQuality: FilterQuality.high,
          )),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final radius = const Radius.circular(10);
  final Widget child;
  final bool left;

  const MessageBubble({
    Key? key,
    required this.child,
    this.left = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: left ? Alignment.bottomLeft : Alignment.bottomRight,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 130,
              minHeight: 40,
            ),
            decoration: BoxDecoration(
                color: left
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary.withOpacity(1),
                borderRadius: BorderRadius.only(
                  bottomRight: left ? radius : Radius.zero,
                  topLeft: radius,
                  topRight: radius,
                  bottomLeft: left ? Radius.zero : radius,
                )),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
