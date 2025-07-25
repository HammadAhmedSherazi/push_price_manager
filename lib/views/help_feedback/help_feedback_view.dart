import 'dart:io';
import 'dart:ui';

import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class HelpFeedbackView extends StatefulWidget {
  const HelpFeedbackView({super.key});

  @override
  State<HelpFeedbackView> createState() => _HelpFeedbackViewState();
}

class _HelpFeedbackViewState extends State<HelpFeedbackView> {
  List<File> images = [];
  void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.teal),
            20.ph,
            Text(
              "Thank You",
              style: context.textStyle.displayMedium!.copyWith(
                fontSize: 18.sp,
                color: AppColors.secondaryColor
              ),
            ),
            12.ph,
            Text(
              "Your feedback has been submitted successfully!",
              textAlign: TextAlign.center,
              style: context.textStyle.bodyMedium!.copyWith(
                color: const Color.fromARGB(255, 121, 121, 121)
              ),
            ),
            24.ph,
            CustomButtonWidget(title: "back to home", onPressed: (){
              AppRouter.customback(times: 3);
            })
          ],
        ),
      ),
    ),
  );
}
Future<void> _pickImage() async {
    final picker = ImagePicker();

    // Show choice dialog
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppTheme.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );

    // If user canceled dialog
    if (source == null) return;

    // Pick image from selected source
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      final imageFile = File(picked.path);
      setState(() {
        images.add(imageFile);
       
        
      });
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "submit",
      onButtonTap: (){
        showThankYouDialog(context);
      },
      title: "Help & Feedback", child: ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Subject",
            hintText: "Enter Subject"
          ),
        ),
        10.ph,
        TextFormField(
          maxLines: 6,
          minLines: 6,
          decoration: InputDecoration(
            labelText: "Description",
            hintText: "Type your message here...."
          ),
        ),
        20.ph,
        Wrap(
          
          runSpacing: 10.r,
          spacing: 10.r,

          children: [
            if(images.isNotEmpty)...[
               ... 
           List.generate(images.length, (index)=> Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColors.borderColor,
                
              ),
              image: DecorationImage(image: FileImage(images[index],), fit: BoxFit.cover)
            ),
          )),
            ],
          
            CustomPaint(
      painter: DottedBorderPainter(),
      child: GestureDetector(
        onTap: (){
          _pickImage();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.addPlusIcon),
              Text("Add more", style: context.textStyle.bodySmall,)
            ],
          ),
        ),
      ))
          ]
          
        )
      ],
    ));
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5;
    final double dashSpace = 3;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(16),
    );

    final Path borderPath = Path()..addRRect(rrect);
    final PathMetrics pathMetrics = borderPath.computeMetrics();

    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Path dashPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(dashPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}