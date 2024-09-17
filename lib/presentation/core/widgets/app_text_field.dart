import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final String? Function(String? value)? validator;
  final bool? needObscure;
  final String? errorText;

  const AppTextFormField(
      {super.key,
      required this.labelText,
      required this.textEditingController,
      this.validator,
      this.needObscure,
      this.errorText});

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final focusNode = FocusNode();
  late String? errorText;
  late bool isObscured;
  late bool isClearIconVisible;

  @override
  void initState() {
    super.initState();
    errorText = widget.errorText;
    isObscured = widget.needObscure ?? false;
    isClearIconVisible = widget.textEditingController.text.isNotEmpty;
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    errorText = widget.errorText;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // можно обернуть в FormField
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AnimatedDefaultTextStyle(
            style: Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(
                fontSize: focusNode.hasFocus ? 16 : 20, color: AppColors.black),
            duration: const Duration(milliseconds: 250),
            child: Text(widget.labelText),
          ),
        ),
        Stack(children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUnfocus,
            controller: widget.textEditingController,
            validator: widget.validator,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
            obscureText: isObscured,
            onChanged: (value) {
              setState(() {
                isClearIconVisible = value.isNotEmpty;
                errorText = null;
              });
            },
            decoration: InputDecoration(
              errorText: errorText,
            ),
          ),
          Positioned(
            right: 10,
            top: errorText == null ? 15 : 0,
            bottom: errorText == null ? 15 : 20,
            child: Visibility(
              visible: widget.needObscure == true || isClearIconVisible,
              child: widget.needObscure == null
                  ? InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => setState(() {
                        widget.textEditingController.clear();
                        errorText = null;
                      }),
                      child: const Icon(
                        Icons.clear,
                      ),
                    )
                  : InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => setState(() => isObscured = !isObscured),
                      child: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
            ),
          )
        ]),
      ],
    );
  }
}
