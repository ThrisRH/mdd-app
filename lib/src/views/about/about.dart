import 'package:flutter/material.dart';
import 'package:mddblog/src/models/about_model.dart';
import 'package:mddblog/src/services/about_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/post/headerLine.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

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
                      Text("Câu hỏi thường gặp", style: AppTextStyles.h0),
                      SizedBox(height: 32),

                      // Thanh ngang
                      HeaderLine(
                        child: Row(
                          children: List.generate(8, (index) {
                            return Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 32),

                      // Nội dung FAQ
                      Container(
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
                              final aboutList =
                                  snapshot.data!.data.aboutContent;
                              print("Length: ${aboutList.length}");
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: aboutList.length,
                                itemBuilder: (context, index) {
                                  final about = aboutList[index];
                                  return Text(about.type);
                                },
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
