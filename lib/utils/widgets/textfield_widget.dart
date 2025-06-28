import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:sodakkuapp/utils/constant.dart';

class TextFieldPiWidget extends StatefulWidget {
  final bool? ignoring;
  final bool? visible;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? inputformat;
  final TextCapitalization? textCapitalization;
  const TextFieldPiWidget({
    super.key,
    this.ignoring,
    this.visible,
    this.readOnly,
    this.focusNode,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.inputformat,
    this.textCapitalization,
  });

  @override
  State<TextFieldPiWidget> createState() => _TextFieldPiWidgetState();
}

class _TextFieldPiWidgetState extends State<TextFieldPiWidget> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.ignoring ?? false,
      child: Visibility(
        visible: widget.visible ?? true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            cursorColor: appColor,
            cursorHeight: 20,
            readOnly: widget.readOnly ?? false,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.done,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            inputFormatters: widget.inputformat == null
                ? null
                : widget.inputformat == "number"
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ]
                : <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
            decoration: InputDecoration(
              counterText: "",
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: greyColor, fontSize: 16),
              hintTextDirection: ui.TextDirection.ltr,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              contentPadding: const EdgeInsets.only(
                left: 14.0,
                bottom: 8.0,
                top: 8.0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: whitecolor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: whitecolor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: whitecolor, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
