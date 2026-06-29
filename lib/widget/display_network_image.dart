import '../export_all.dart';

class DisplayNetworkImage extends StatelessWidget {
  final String imageUrl;
  final num? width;
  final num? height;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const DisplayNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.errorWidget,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final scaledWidth = width?.iw;
    final scaledHeight = height?.ih;

    if (imageUrl.trim().isEmpty) {
      return _buildPlaceholder(scaledWidth, scaledHeight);
    }

    return CachedNetworkImage(
      width: scaledWidth,
      height: scaledHeight,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) =>
          errorWidget ?? _buildPlaceholder(scaledWidth, scaledHeight),
      placeholder: (context, url) =>
          loadingWidget ?? _buildPlaceholder(scaledWidth, scaledHeight),
    );
  }

  Widget _buildPlaceholder(double? w, double? h) {
    return SizedBox(
      width: w,
      height: h,
      child: Image.asset(
        Assets.placeholderImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
