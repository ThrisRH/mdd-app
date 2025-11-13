import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

class DeepLinkHandler {
  late final AppLinks _appLinks;

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Lấy initial link nếu app mở bằng deeplink
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleUri(initialLink);
    }

    // Lắng nghe khi app đang mở
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    if (uri.scheme == "myapp" && uri.host == "auth") {
      final token = uri.queryParameters["token"];
    }
  }
}
