part 'qiyu_user_info_data.g.dart';

// 用戶的每一項資料為一個物件
class QiyuUserInfoData {

  // 這三個是固定的基本資料，Key不能改變
  static const keyName = 'real_name';
  static const keyPhone = 'mobile_phone';
  static const keyEmail = 'email';

  // 用於排序，顯示數據時數據項按index值升序排列；不設定index的數據項將排在後面；index相同或未設定的數據項將按照其在JSON 中出現的順序排列。
  int? index;
  // 數據項的名稱，用於區別不同的數據
  String key;
  // 該數據顯示的值，類型不做限定，根據實際需要進行設定
  String value;
  // 該項數據顯示的名稱。
  String label;
  // 超鏈接地址。若指定該值，則該項數據將顯示為超鏈接樣式，點擊後跳轉到其值所指定的URL地址
  String? href;
  // 是否隱藏該item。目前僅對mobile和email有效
  bool hidden;

  QiyuUserInfoData({
    this.index,
    required this.key,
    required this.value,
    required this.label,
    this.href,
    this.hidden = false,
  });

  factory QiyuUserInfoData.fromJson(Map<String, dynamic> json) => _$QiyuUserInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$QiyuUserInfoDataToJson(this);
}
