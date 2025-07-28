
import '../export_all.dart';

class CustomDateSelectWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final Widget? suffixIcon;

  const CustomDateSelectWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectedDate,
    this.suffixIcon,
  });

  @override
  State<CustomDateSelectWidget> createState() => _CustomDateSelectWidgetState();
}

class _CustomDateSelectWidgetState extends State<CustomDateSelectWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: Helper.selectDateFormat(widget.selectedDate),
    );
  }

  @override
  void didUpdateWidget(covariant CustomDateSelectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _controller.text = Helper.selectDateFormat(widget.selectedDate);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime(now.year - 13),
      firstDate: widget.firstDate ?? DateTime(now.year - 100),
      lastDate: widget.lastDate ?? now,
    );
    if (picked != null) {
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        //  labelText: widget.label,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon ??
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondaryColor,
              ),
      ),
         
          controller: _controller,
          readOnly: true,
          
          onTap: _pickDate,
        );
  }
}