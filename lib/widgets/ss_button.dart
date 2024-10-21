import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';

class SsButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Function() onPressed;
  final bool enable;
  final bool loading;
  const SsButton({
    this.backgroundColor = Colors.green,
    required this.text,
    required this.onPressed,
    this.enable = true,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SsCard(
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        backgroundColor: enable ? backgroundColor : Colors.grey,
        child: loading
            ? const CircularProgressIndicator()
            : Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
      ),
    );
  }
}
