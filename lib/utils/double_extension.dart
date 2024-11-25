extension ColorExtension on double {
  double toDouble() {
    return this;
  }

  String toMoney() {
    return '\$${toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
