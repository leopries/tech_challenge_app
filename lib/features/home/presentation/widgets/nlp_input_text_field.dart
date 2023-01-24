import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat_bot/presentation/pages/chat_bot.dart';
import '../bloc/nlp_bloc.dart';

class NLPInputTextField extends StatefulWidget {
  const NLPInputTextField({Key? key}) : super(key: key);

  @override
  State<NLPInputTextField> createState() => _NLPInputTextFieldState();
}

class _NLPInputTextFieldState extends State<NLPInputTextField> {
  bool active = false;
  bool showErrorMessage = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NlpBloc, NlpState>(
      listener: (context, state) {
        if (state is NlpLoaded) {
          _controller.clear();
          active = false;
          FocusScope.of(context).unfocus();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatBot(treeNode: state.treeNode),
            ),
          );
        }
        if (state is NlpError) {
          _showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is NlpLoading,
          child: Opacity(
            opacity: state is NlpLoading ? 0.5 : 1,
            child: Column(
              children: [
                _buildTextInputField(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildErrorMessage(),
                    _buildSendButton(state),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextInputField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) => setState(() {
          showErrorMessage = false;
          active = value.trim().isNotEmpty;
        }),
        decoration: const InputDecoration(
          hintText: "Bitte beschreibe mir was passiert ist...",
          contentPadding: EdgeInsets.all(16),
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        cursorColor: Theme.of(context).colorScheme.tertiary,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        expands: true,
      ),
    );
  }

  Widget _buildSendButton(NlpState state) {
    return InkWell(
      onTap: () {
        if (active) {
          context
              .read<NlpBloc>()
              .add(NlpSendEvent(input: _controller.text.trim()));
        } else {
          setState(() {
            showErrorMessage = true;
          });
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: active ? 1 : 0.5,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 40,
          width: state is NlpLoading ? 40 : 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: state is NlpLoading
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 3),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showErrorMessage ? 1 : 0,
        child: Text(
          "Please enter a valid input",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
