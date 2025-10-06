import '../export_all.dart';

class GenericPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  const GenericPasswordTextField({
    super.key,
    required this.controller,
    this.label = "Password",
    this.hint = "Enter Password",
    this.validator
  });

  @override
  State<GenericPasswordTextField> createState() => _GenericPasswordTextFieldState();
}

class _GenericPasswordTextFieldState extends State<GenericPasswordTextField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: showPass,
      validator: widget.validator,
      onTapOutside: (event) {
  FocusScope.of(context).unfocus();
},
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: AppColors.secondaryColor),
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPass = !showPass;
            });
          },
          icon: Icon(
            !showPass ? Icons.visibility : Icons.visibility_off,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}