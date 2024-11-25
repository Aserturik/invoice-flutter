import 'package:flutter/material.dart';

class SsDropdown<T> extends StatelessWidget {
  final List<T> options;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final dynamic Function(T item)? itemBuilder;
  final double? width;
  final String? hint;
  final bool enabled;

  final bool loading;

  const SsDropdown({
    required this.options,
    this.initialValue,
    this.onChanged,
    this.itemBuilder,
    this.width,
    this.hint,
    this.enabled = true,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    T? selected = initialValue;
    return StatefulBuilder(builder: (context, setState) {
      return DropdownButtonFormField<T>(
        value: selected,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_downward_sharp,
          size: 20,
          color: Colors.black,
        ),
        style: textStyle.copyWith(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        hint: loading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                hint ?? '',
                style: textStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
        borderRadius: BorderRadius.circular(6),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
        ),
        elevation: 1,
        onChanged: enabled
            ? (T? value) {
                setState(() {
                  selected = value;
                });
                onChanged?.call(value);
              }
            : null,
        selectedItemBuilder: (context) {
          return options.map((e) {
            if (loading) {
              return const CircularProgressIndicator();
            }
            if (itemBuilder?.call(e) is Widget) {
              return itemBuilder!(e) as Widget;
            }
            return Text(
              itemBuilder?.call(e) ?? e.toString(),
              style: textStyle.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            );
          }).toList();
        },
        items: options.map<DropdownMenuItem<T>>((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: itemBuilder?.call(value) is Widget
                ? itemBuilder!(value)
                : Text(
                    itemBuilder?.call(value) ?? value.toString(),
                    style: textStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          );
        }).toList(),
      );
    });
  }
}
