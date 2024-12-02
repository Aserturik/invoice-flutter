// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:facturacion/utils/date_extension.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:facturacion/widgets/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SsDateInput extends StatefulWidget {
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DatePickerMode initialDatePickerMode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<DateTime>? onChange;
  final bool enabled;
  final String dateFormat;
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final FormFieldValidator? validator;
  final bool changeDate;
  final String? labelText;

  const SsDateInput({
    super.key,
    this.hintText,
    this.initialDate,
    this.maxDate,
    this.minDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.prefixIcon,
    this.suffixIcon,
    this.dateFormat = 'dd/MM/yyyy',
    this.enabled = true,
    this.onChange,
    this.controller,
    this.formKey,
    this.validator,
    this.changeDate = true,
    this.labelText,
  });

  @override
  State<SsDateInput> createState() => _SsDateInputState();
}

class _SsDateInputState extends State<SsDateInput> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    if (widget.initialDate != null) {
      controller.text = widget.initialDate!.toFormat(widget.dateFormat);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != widget.controller && widget.controller != null) {
      controller = widget.controller!;
    }
    if (widget.formKey == null) {
      return buildTextFormField(context);
    }
    return Form(
      key: widget.formKey,
      child: buildTextFormField(context),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enabled,
      readOnly: true,
      onTap: () => _onShowDatePicker(context),
      textAlignVertical: TextAlignVertical.center,
      validator: widget.validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: widget.labelText,
        fillColor: Colors.white.withOpacity(0.8),
        filled: true,
      ),
      // style: inputTextStyle(widget.enabled),
    );
  }

  void _onShowDatePicker(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DateTime init = widget.initialDate ??
        controller.text.tryParseFormat(widget.dateFormat) ??
        DateTime.now().subtract(const Duration(minutes: 1));
    DateTime first = widget.minDate ??
        DateTime.now().subtract(const Duration(days: 365 * 100));
    DateTime last =
        widget.maxDate ?? DateTime.now().add(const Duration(days: 365 * 50));
    DateTime? pickedDate;

    if (Platform.isAndroid) {
      pickedDate = await showDatePicker(
        keyboardType: TextInputType.datetime,
        context: context,
        initialDate: init,
        firstDate: first,
        lastDate: last,
        initialDatePickerMode: widget.initialDatePickerMode,
      );
    } else {
      pickedDate = await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          DateTime? date;
          return Container(
            height: 0.4,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CupertinoButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: SsColors.orange,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(date ?? init),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: init,
                    minimumDate: first,
                    maximumDate: last,
                    dateOrder: DatePickerDateOrder.dmy,
                    onDateTimeChanged: (value) {
                      date = value;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    if (pickedDate != null) {
      if (widget.changeDate) {
        String formattedDate = DateFormat(widget.dateFormat).format(pickedDate);
        controller.text = formattedDate;
      }
      widget.onChange?.call(pickedDate);
    }
    FocusScope.of(context).unfocus();
  }
}
