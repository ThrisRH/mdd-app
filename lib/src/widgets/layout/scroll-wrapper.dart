import 'package:flutter/widgets.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';

class ScrollViewWrapper extends StatelessWidget {
  final List<Widget> children;
  const ScrollViewWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(spacing: 16, children: [...children, Footer()]),
    );
  }
}
