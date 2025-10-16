import '../export_all.dart';

class TimeRangePickerDialog extends StatefulWidget {
  final String? title; // optional title
  final TimeOfDay? initialStart;
  final TimeOfDay? initialEnd;

  const TimeRangePickerDialog({
    super.key,
    this.title,
    this.initialStart,
    this.initialEnd,
  });

  @override
  State<TimeRangePickerDialog> createState() => _TimeRangePickerDialogState();
}

class _TimeRangePickerDialogState extends State<TimeRangePickerDialog> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStart;
    endTime = widget.initialEnd;
  }

  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => startTime = time);
  }

  Future<void> _pickEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => endTime = time);
  }
  bool _isAfter(TimeOfDay a, TimeOfDay b) {
    return a.hour > b.hour || (a.hour == b.hour && a.minute > b.minute);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? 'Select Time Range'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Start Time'),
            trailing: Text(startTime == null
                ? '--:--'
                : startTime!.format(context)),
            onTap: _pickStartTime,
          ),
          ListTile(
            title: const Text('End Time'),
            trailing:
                Text(endTime == null ? '--:--' : endTime!.format(context)),
            onTap: _pickEndTime,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if(startTime == null || endTime == null){
              Helper.showMessage(context, message: context.tr("please_select_a_time_range"));
              return;
            }
            if (startTime != null && !_isAfter(endTime!, startTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(context.tr("end_time_must_be_after_start_time")),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
            Navigator.pop(context, {
              'start': startTime,
              'end': endTime,
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
