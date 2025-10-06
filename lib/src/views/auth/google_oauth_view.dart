import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:mddblog/controllers/oauth_controller.dart';

class GoogleOauthView extends StatelessWidget {
  GoogleOauthView({super.key});

  final OauthController oAuthController = Get.put(OauthController());
  @override
  Widget build(BuildContext context) {
    void launchSignInUrl(String url) async {
      try {
        await launchUrl(
          Uri.parse(url),
          customTabsOptions: CustomTabsOptions(
            colorSchemes: CustomTabsColorSchemes.defaults(
              toolbarColor: Theme.of(context).primaryColor,
            ),
            urlBarHidingEnabled: true,
            showTitle: true,
            browser: CustomTabsBrowserConfiguration(
              prefersDefaultBrowser: false,
            ),
          ),
        );
      } catch (error) {
        throw Exception('Failed to launch sign-in URL: $error');
      }
    }

    return Scaffold(
      body: Obx(() {
        if (oAuthController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (oAuthController.signInUrl.isEmpty) {
          return const Center(child: Text('Failed to load auth URL'));
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          launchSignInUrl(oAuthController.signInUrl.value);
        });

        return const Center(child: Text('Redirecting to Google login...'));
      }),
    );
  }
}
