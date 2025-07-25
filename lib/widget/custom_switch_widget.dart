import '../export_all.dart';

class CustomSwitchWidget extends StatefulWidget {
  final double scale;
  final bool value;
  final void Function(bool)? onChanged;
  const CustomSwitchWidget({super.key, required this.scale, required this.value, required this.onChanged});

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
            scale: widget.scale,
            child: Switch.adaptive(
              padding: EdgeInsets.zero,
              activeColor: AppColors.secondaryColor,
              
              value: widget.value , onChanged: widget.onChanged),
          );
  }
}