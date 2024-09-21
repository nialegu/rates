import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/money_input_formatter.dart';

class AppTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final String? Function(String? value)? validator;
  final bool? needObscure;
  final String? errorText;
  final Widget? trailing;
  final bool readOnly;
  final Function()? onTap;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    this.validator,
    this.needObscure,
    this.errorText,
    this.trailing,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
  });

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth > 600 ? 400 : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: AnimatedDefaultTextStyle(
                  style: Theme.of(context)
                      .inputDecorationTheme
                      .labelStyle!
                      .copyWith(
                          fontSize: focusNode.hasFocus ? 16 : 20,
                          color: AppColors.black),
                  duration: const Duration(milliseconds: 250),
                  child: Text(widget.labelText),
                ),
              ),
              TextFormField(
                onTap: widget.onTap,
                keyboardType: widget.keyboardType,
                inputFormatters: [
                  if (widget.keyboardType == TextInputType.number)
                    MoneyInputFormatter()
                ],
                readOnly: widget.readOnly,
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
                  suffixIcon: widget.trailing ??
                      Visibility(
                        visible:
                            widget.needObscure == true || isClearIconVisible,
                        child: widget.needObscure == null
                            ? InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => setState(() {
                                  widget.textEditingController.clear();
                                  errorText = null;
                                  focusNode.requestFocus();
                                }),
                                child: const Icon(
                                  Icons.clear,
                                ),
                              )
                            : InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () =>
                                    setState(() => isObscured = !isObscured),
                                child: Icon(
                                  isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                      ),
                  focusedBorder: widget.readOnly
                      ? Theme.of(context).inputDecorationTheme.enabledBorder
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
