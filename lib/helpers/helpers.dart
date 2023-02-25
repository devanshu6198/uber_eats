library helpers;

export 'src/after_layout_mixin.dart';
export 'src/connectivity_helper.dart';
export 'src/event_bus.dart';
export 'src/extensions/extensions.dart';
export 'src/input_formatters.dart';
export 'src/logger.dart';
export 'src/storage_helper.dart';
export 'src/system_helper.dart';
export 'src/url_helper.dart';

const serverDateTimeFormat = "yyyy-MM-dd HH:mm:ss";
const serverDateFormat = "yyyy-MM-dd";
const serverTimeFormat = "HH:mm:ss";
const localDateFormat = "dd/MM/yyyy";
const localTimeFormat = "hh:mm a";

const urlLinkValidation =
    r'^((?:.|\n)?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=|!:,.;])?(\?[A-Z0-9+&@#/%=|!:‌​,.;]*)?)';
const kEmailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const kPasswordPattern = r'^.*(?=.{8,255})((?=.*[!@#$%^&*_]){1})(?=.*\d)((?=.*[a-zA-Z]){1}).*$';
