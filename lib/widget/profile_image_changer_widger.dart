import 'dart:io';

import '../export_all.dart';

class ProfileImageChanger extends StatefulWidget {
   String? profileUrl;
  final void Function(File file)? onImageSelected;

  ProfileImageChanger({super.key, this.onImageSelected, this.profileUrl});

  @override
  State<ProfileImageChanger> createState() => _ProfileImageChangerState();
}

class _ProfileImageChangerState extends State<ProfileImageChanger> {
  File? _selectedImage;

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final picked = await picker.pickImage(source: ImageSource.gallery);

  //   if (picked != null) {
  //     final imageFile = File(picked.path);
  //     setState(() {
  //       _selectedImage = imageFile;
  //     });
  //     widget.onImageSelected?.call(imageFile);
  //   }
  // }
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
        _selectedImage = imageFile;
        widget.profileUrl = null;
      });
      widget.onImageSelected?.call(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

      widget.profileUrl == null ?  Container(
          height: 108.r,
          width: 108.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 5,
              color: AppColors.borderColor,
            ),
            color: AppColors.secondaryColor,
            image:  DecorationImage(
              fit: BoxFit.cover,
              
              image: _selectedImage != null? FileImage(_selectedImage!) as ImageProvider : AssetImage(Assets.userAvatar)
                     ,
            ) ,
          ),
          
        ) : UserProfileWidget(radius: 50.r, imageUrl: widget.profileUrl ?? ""),
        
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
              width: 2,
              color: AppColors.borderColor,
            ),
              ),
              
              child:  Icon(Icons.camera_alt, color: AppColors.secondaryColor, size: 25.r,),
            ),
          ),
        ),
      ],
    );
  }
}
