abstract class BaseConfig {
  const BaseConfig();

  String get baseUrl;

  String get imageUrl;

  String get socketUrl;

  bool get isLogEnabled;

  String get encryptionKey;

  String get encryptionIv;

  String get decryptionKey;

  String get decryptionIv;

  String get userDocUrl;

  String get chatAttachmentUrl;

  String get userThumbNail;
}
