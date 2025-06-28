class DeliveryTip {
  final double amount;
  final bool isSelected;

  DeliveryTip({
    required this.amount,
    this.isSelected = false,
  });

  DeliveryTip copyWith({
    double? amount,
    bool? isSelected,
  }) {
    return DeliveryTip(
      amount: amount ?? this.amount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}