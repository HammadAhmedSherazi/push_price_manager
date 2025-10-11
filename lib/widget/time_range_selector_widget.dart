import '../export_all.dart';

class TimeRangePickerDialog extends StatefulWidget {
  final String? title; // optional title
  final TimeOfDay? initialStart;
  final TimeOfDay? initialEnd;

  const TimeRangePickerDialog({
    Key? key,
    this.title,
    this.initialStart,
    this.initialEnd,
  }) : super(key: key);

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
              Helper.showMessage(context, message: "Please selete a time range");
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
