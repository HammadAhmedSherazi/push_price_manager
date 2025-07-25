import '../export_all.dart';

class GenericPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const GenericPasswordTextField({
    super.key,
    required this.controller,
    this.label = "Password",
    this.hint = "Enter Password",
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
            showPass ? Icons.visibility : Icons.visibility_off,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}