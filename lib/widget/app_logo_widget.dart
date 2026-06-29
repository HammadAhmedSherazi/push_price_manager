import '../export_all.dart';

class AppLogoWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const AppLogoWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.logo,
      width: width ?? 185.iw,
      height: height ?? 95.ih,
      fit: BoxFit.contain,
    );
  }
}
