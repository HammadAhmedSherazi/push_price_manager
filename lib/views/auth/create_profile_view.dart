import 'package:push_price_manager/utils/extension.dart';


import '../../export_all.dart';

class CreateProfileView extends StatefulWidget {
  final bool? isEdit;
  const CreateProfileView({super.key, this.isEdit = false});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  late final TextEditingController nameTextController;
  late final TextEditingController employeeIdTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController emailTextController;

  @override
  void initState() {
    nameTextController = TextEditingController(text: widget.isEdit! ?"John Smith" : null);
    employeeIdTextController = TextEditingController( text: widget.isEdit! ?"123 456 789" : null);
    phoneTextController = TextEditingController(text: widget.isEdit! ?"00000000" : null);
    emailTextController = TextEditingController(text: widget.isEdit! ?"Abc@gmail.com" : null);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      onButtonTap: (){
        if(widget.isEdit!){
          AppRouter.back();
        }
        else{
        
          AppRouter.pushAndRemoveUntil(NavigationView());
        }
      },
      title: widget.isEdit!? "Edit Profile": "Create Profile", showBottomButton: true, bottomButtonText: widget.isEdit!?"save" :"continue", child: ListView(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.horizontalPadding
      ),
      children: [
        Center(
          child: ProfileImageChanger(
            profileUrl: Assets.userImage ,
          ),
        ),
        20.ph,
        TextFormField(
          controller: nameTextController,
          onTapOutside: (event) {
 FocusScope.of(context).unfocus();
},
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter Name"
          ),
        ),
        10.ph,
       TextFormField(
          readOnly: widget.isEdit ?? false,
          onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
          controller: emailTextController,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter Email",
            suffixIcon: Icon(Icons.check_circle_rounded, color: AppColors.secondaryColor,)
          ),
        ),
        10.ph,
        // TextFormField(
//           controller: phoneTextController,
//           onTapOutside: (event) {
//   FocusScope.of(context).unfocus();
// },
//           keyboardType: TextInputType.phone,
//           decoration: InputDecoration(
            
//             labelText: "Phone Number",
//             hintText: "Enter Phone Number"
//           ),
//         ),
CustomPhoneTextfieldWidget(phoneNumberController: phoneTextController, initialCountryCode: "US", onCountryChanged: (phone){}),
        10.ph,
        TextFormField(
          controller: employeeIdTextController,
          onTapOutside: (event) {
  AppRouter.closeKeyboard();
},
          decoration: InputDecoration(
            labelText: "Employee ID",
            hintText: "Enter Employee ID"
          ),
        ),
        if(AppConstant.userType == UserType.employee)...[
          10.ph,
            TextFormField(
          controller: employeeIdTextController,
          onTapOutside: (event) {
 AppRouter.closeKeyboard();
},
          decoration: InputDecoration(
            labelText: "Store Branch Code/ Name",
            hintText: "Enter Store Branch Code/Name"
          ),
        ),
        10.ph,
            TextFormField(
          controller: employeeIdTextController,
          onTapOutside: (event) {
   AppRouter.closeKeyboard();
},
          decoration: InputDecoration(
            labelText: "Store Address",
            hintText: "Enter Store Address"
          ),
        ),
        10.ph,
            TextFormField(
          controller: employeeIdTextController,
          onTapOutside: (event) {
  AppRouter.closeKeyboard();
},
          decoration: InputDecoration(
            labelText: "Operational Hours",
            hintText: "Enter Operational Hours"
          ),
        ),
        ]
        
       
      ],
      
    ),);
  }
}