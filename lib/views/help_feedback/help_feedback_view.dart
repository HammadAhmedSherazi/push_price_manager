import 'dart:io';
import 'dart:ui';

import 'package:push_price_manager/utils/extension.dart';

import '../../export_all.dart';

class HelpFeedbackView extends ConsumerStatefulWidget {
  const HelpFeedbackView({super.key});

  @override
  ConsumerState<HelpFeedbackView> createState() => _HelpFeedbackViewState();
}

class _HelpFeedbackViewState extends ConsumerState<HelpFeedbackView> {
  List<File> images = [];
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
              const Icon(Icons.check_circle, size: 80, color: Colors.teal),
              20.ph,
              Text(
                context.tr("thankyou"),
                style: context.textStyle.displayMedium!.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
              12.ph,
              Text(
                context.tr("your_feedback_has_been_submitted_successfully"),
                textAlign: TextAlign.center,
                style: context.textStyle.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 121, 121, 121),
                ),
              ),
              24.ph,
              CustomButtonWidget(
                title: context.tr("back_to_home"),
                onPressed: () {
                  AppRouter.customback(times: 3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

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
                  title: Text(context.tr('take_a_photo')),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(context.tr('choose_from_gallery')),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

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
    final authState = ref.watch(authProvider);
    final isLoading =
        authState.submitFeedbackApiResponse.status == Status.loading;

    ref.listen(authProvider, (previous, next) {
      if (next.submitFeedbackApiResponse.status == Status.completed) {
        showThankYouDialog(context);
        ref.read(authProvider.notifier).resetSubmitFeedbackResponse();
      }
    });

    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: context.tr("submit"),
      customBottomWidget: isLoading
          ? Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
              child: CustomButtonWidget(
                title: context.tr("submit"),
                isLoad: true,
                onPressed: () {},
              ),
            )
          : null,
      onButtonTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          ref.read(authProvider.notifier).submitFeedback(
                subject: _subjectController.text.trim(),
                description: _descriptionController.text.trim(),
                images: images,
              );
        }
      },
      title: context.tr("help_and_feedback"),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppTheme.horizontalPadding),
          children: [
            TextFormField(
              controller: _subjectController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.tr("please_enter_subject");
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: context.tr("subject"),
                hintText: context.tr("subject"),
              ),
            ),
            10.ph,
            TextFormField(
              controller: _descriptionController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              maxLines: 6,
              minLines: 6,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.tr("please_enter_description");
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: context.tr("description"),
                hintText: context.tr("type_your_message_here"),
              ),
            ),
            20.ph,
            Wrap(
              runSpacing: 10.r,
              spacing: 10.r,
              children: [
                if (images.isNotEmpty)
                  ...List.generate(
                    images.length,
                    (index) => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100.r,
                          height: 100.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.borderColor,
                            ),
                            image: DecorationImage(
                              image: FileImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -6.r,
                          right: -6.r,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                            child: Icon(
                              Icons.cancel,
                              size: 24.r,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: GestureDetector(
                    onTap: () {
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
                          Text(
                            context.tr("add_more"),
                            style: context.textStyle.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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