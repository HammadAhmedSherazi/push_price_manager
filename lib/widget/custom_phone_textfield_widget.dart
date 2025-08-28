import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../export_all.dart';

class CustomPhoneTextfieldWidget extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final String initialCountryCode;
  final PhoneNumber? initialValue;
  final void Function(Country country)? onCountryChanged;

  const CustomPhoneTextfieldWidget({super.key, required this.phoneNumberController, required this.initialCountryCode, required this.onCountryChanged, this.initialValue });

  @override
  State<CustomPhoneTextfieldWidget> createState() => _CustomPhoneTextfieldWidgetState();
}

class _CustomPhoneTextfieldWidgetState extends State<CustomPhoneTextfieldWidget> {
  

  @override
Widget build(BuildContext context) {
  return InternationalPhoneNumberInput(
    
    onInputChanged: (PhoneNumber number) {
      // print(number.phoneNumber);
    },
    onInputValidated: (bool value) {
      // print(value);
    },
  
    selectorConfig: SelectorConfig(
      // selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      useBottomSheetSafeArea: true,
      trailingSpace: false,
      
      setSelectorButtonAsPrefixIcon: true, // 👈 Key line here
    ),
    
    ignoreBlank: true,
    
    autoValidateMode: AutovalidateMode.disabled,
    selectorTextStyle: TextStyle(color: Colors.black),
    initialValue: widget.initialValue,
    textFieldController: widget.phoneNumberController,
    formatInput: true,
    // inputDecoration: InputDecoration(
    //   label: Text("Phone")
    // ),
   
    
    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
    inputBorder: OutlineInputBorder(
      
    ),
    onSaved: (PhoneNumber number) {
      // print('On Saved: $number');
    },
  );
}

}