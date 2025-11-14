import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/controllers/overlay-controller.dart';
import 'package:mddblog/models/about-model.dart';
import 'package:mddblog/services/about-service.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/about/about-avatar-container.dart';
import 'package:mddblog/src/widgets/about/about-contact-info-section.dart';
import 'package:mddblog/src/widgets/about/about-content-section.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/theme/element/app-colors.dart';
import 'package:mddblog/utils/enum/status.dart';

// Controller
class AboutController extends GetxController {
  final AboutService _aboutService = AboutService();

  var about = Rxn<AboutResponse>();
  var status = Rx<Status>(Status.loading);

  @override
  void onInit() {
    super.onInit();
    fetchAbout();
  }

  void fetchAbout() async {
    status.value = Status.loading;

    try {
      final response = await _aboutService.getAbout();
      about.value = response;

      status.value = Status.success;
    } catch (error) {
      status.value = Status.error;
    }
  }
}

// Main view

class About extends GetWidget<AboutController> {
  About({super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: BannerSection()),
          //  Body
          Obx(() {
            switch (controller.status.value) {
              case Status.loading:
                return SliverFillRemaining(child: Center(child: Loading()));
              case Status.error:
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: ErrorNotification()),
                );
              case Status.success:
                final aboutData = controller.about.value!.data;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 172 / 2),
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 40,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Stack(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        "assets/svg/AboutMDD.svg",
                                      ),
                                    ),

                                    // Vùng chứa nội dụng About
                                    AboutContentSection(
                                      content: aboutData.aboutContent,
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
                                    SizedBox(height: 8),
                                    Text(
                                      'my MDD diary',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return SizedBox.shrink();
            }
          }),
          SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }
}
