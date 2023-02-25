part of '../app_scope.dart';

abstract class Loader {
  static const routeName = "/loading_dialog";

  Route? _dialogRoute;

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: Navigator.of(context).context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      settings: const RouteSettings(name: "/loading_dialog"),
      themes: themes,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: Center(child: buildLoader()),
        ),
      ),
    );
  }

  void show(BuildContext context) {
    if (_dialogRoute != null) return;
    _dialogRoute = _buildDialogRoute(context);
    Navigator.of(context).push(_dialogRoute!);
  }

  void dismiss(BuildContext context) {
    if (_dialogRoute != null) Navigator.of(context).removeRoute(_dialogRoute!);
    _dialogRoute = null;
  }

  Widget buildLoader();
}

/*
import 'package:components/components.dart';
import 'package:flutter/material.dart';

mixin LoadingMixin {
  late final _navigator = Navigator.of(context);
  Route? _dialogRoute;

  BuildContext get context;

  void handleLoading(bool isLoading) {
    if (isLoading) {
      startLoading();
    } else {
      stopLoading();
    }
  }

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: _navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      settings: const RouteSettings(name: "/loading_dialog"),
      themes: themes,
      builder: (context) => const LoadingDialog(),
    );
  }

  void startLoading() {
    if (_dialogRoute != null) return;
    dialogRoute = buildDialogRoute(context);
    _navigator.push(_dialogRoute!);
  }

  void stopLoading() {
    if (dialogRoute != null) navigator.removeRoute(_dialogRoute!);
    _dialogRoute = null;
  }
}
 */
