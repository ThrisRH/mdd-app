import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/config/constants.dart';
import 'package:mddblog/models/about_model.dart';
import 'package:mddblog/services/about_service.dart';
import 'package:mddblog/src/widgets/about/about_avatar_container.dart';
import 'package:mddblog/src/widgets/about/about_contact_info_section.dart';
import 'package:mddblog/src/widgets/about/about_content_section.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/theme/element/app_colors.dart';

// Controller
class AboutController extends GetxController {
  final AboutService _aboutService = AboutService();

  var about = Rxn<AboutResponse>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAbout();
  }

  void fetchAbout() async {
    try {
      isLoading.value = true;
      final response = await _aboutService.getAbout();
      about.value = response;
    } finally {
      isLoading.value = false;
    }
  }
}

// Main view

class About extends GetWidget<AboutController> {
  About({super.key});

  final AboutController c = Get.put(AboutController());
  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              spacing: 32,
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),

                //  Body
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: Loading());
                  }
                  if (controller.about.value == null) {
                    return Center(child: ErrorNotification());
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Nội dung FAQ
                        Container(
                          margin: EdgeInsets.only(top: 172 / 2),
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 40,
                            right: 40,
                            bottom: 40,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: Loading());
                            }
                            if (controller.about.value == null) {
                              return Center(child: ErrorNotification());
                            }

                            final aboutData = controller.about.value!.data;
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -(172 / 2),
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: AboutAvatarContainer(
                                      imageUrl:
                                          "$baseUrlNoUrl${aboutData.authorAvt.url}",
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 100),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 16,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/AboutMDD.svg",
                                      ),

                                      // Vùng chứa nội dụng About
                                      AboutContentSection(
                                        contents: aboutData.aboutContent,
                                      ),

                                      // Vùng chứa nội dung Contact Info
                                      AboutContactInfoSection(
                                        contacts: aboutData.contact,
                                      ),

                                      // Lời chúc
                                      SizedBox(height: 16),
                                      Text(
                                        'Have a nice day! ',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                      ),

                                      Text(
                                        'my MDD diary',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        // Footer
                        Footer(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        Obx(
          () =>
              showOverlay.value
                  ? OverlayToggle(closeOverlay: toggleOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
