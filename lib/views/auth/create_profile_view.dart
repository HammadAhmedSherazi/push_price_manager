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
  late final TextEditingController addressTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController emailTextController;

  @override
  void initState() {
    nameTextController = TextEditingController(text: widget.isEdit! ?"John Smith" : null);
    addressTextController = TextEditingController( text: widget.isEdit! ?"Abc street, Lorem Ipsum" : null);
    phoneTextController = TextEditingController(text: widget.isEdit! ?"00000000" : null);
    emailTextController = TextEditingController(text: widget.isEdit! ?"Abc@domain.com" : null);
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
        AppRouter.push(SubscriptionPlanView(isPro: true,));

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
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter Name"
          ),
        ),
        10.ph,
        TextFormField(
          controller: addressTextController,
          decoration: InputDecoration(
            labelText: "Address",
            hintText: "Address (can add multiple addresses)"
          ),
        ),
        10.ph,
        TextFormField(
          controller: phoneTextController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            
            labelText: "Phone Number",
            hintText: "Enter Phone Number"
          ),
        ),
        10.ph,
        TextFormField(
          controller: emailTextController,
          decoration: InputDecoration(
            labelText: "Email Address",
            hintText: "Enter Email"
          ),
        ),
       
      ],
      
    ),);
  }
}