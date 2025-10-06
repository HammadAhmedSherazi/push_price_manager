import '../../../export_all.dart';

class ShowEmptyItemDisplayWidget extends StatelessWidget {
  final String message;
  final String? lottie;
  final double? width;
  const ShowEmptyItemDisplayWidget(
      {super.key, required this.message, this.lottie, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
         
          Text( 
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}