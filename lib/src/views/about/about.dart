import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mddblog/src/models/about_model.dart';
import 'package:mddblog/src/services/about_service.dart';
import 'package:mddblog/src/widgets/about/aboutAvatarContainer.dart';
import 'package:mddblog/src/widgets/about/aboutContactInfoSection.dart';
import 'package:mddblog/src/widgets/about/aboutContentSection.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

final String baseUrl = dotenv.env['BASE_URL_WITHOUT_API'] ?? "";

class _AboutState extends State<About> {
  final AboutService _aboutService = AboutService();
  late Future<AboutResponse> _about;

  @override
  void initState() {
    super.initState();
    _about = _aboutService.getAbout();
  }

  bool showOverlay = false;

  void toggleOverlay() {
    setState(() {
      showOverlay = !showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onSearchTap: () => {}, onMenuTap: toggleOverlay),
                SizedBox(height: 32),

                //  Body
                Padding(
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
                          color: AppColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: FutureBuilder(
                          future: _about,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData) {
                              return const Center(child: Text("No FAQs found"));
                            } else {
                              // Khai báo data từ api
                              final aboutList =
                                  snapshot.data!.data.aboutContent;
                              final avatar = snapshot.data!.data.authorAvt;
                              final contactList = snapshot.data!.data.contact;

                              // Gán vào UI
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: -(172 / 2),
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: AboutAvatarContainer(
                                        imageUrl: "$baseUrl${avatar.url}",
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 100),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/AboutMDD.svg",
                                        ),

                                        // Vùng chứa nội dụng About
                                        AboutContentSection(
                                          contents: aboutList,
                                        ),

                                        // Vùng chứa nội dung Contact Info
                                        AboutContactInfoSection(
                                          contacts: contactList,
                                        ),

                                        // Lời chúc
                                        SizedBox(height: 32),
                                        Text(
                                          'Have a nice day! ',
                                          style: AppTextStyles.h4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'my MDD diary',
                                          style: AppTextStyles.body1.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer
                Footer(),
              ],
            ),
          ),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        if (showOverlay) OverlayToggle(closeOverlay: toggleOverlay),
      ],
    );
  }
}
