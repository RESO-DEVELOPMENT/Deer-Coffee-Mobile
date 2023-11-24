class PromotionTypeEnum {
  static const num Automatic = 1;
  static const num Using_PromoCode = 2;
  static const num Using_Voucher = 3;
}

String getPromotionTypeLabel(num type) {
  switch (type) {
    case PromotionTypeEnum.Automatic:
      return "Tự động";
    case PromotionTypeEnum.Using_Voucher:
      return "Voucher";
    case PromotionTypeEnum.Using_PromoCode:
      return "Khuyến mãi";
    default:
      return "Tự động";
  }
}
