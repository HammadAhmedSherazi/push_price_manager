import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListScheduleCalenderView extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isLiveListing;
  final ListingModel listData;
  const ListScheduleCalenderView({super.key, required this.data, required this.isLiveListing, required this.listData });

  @override
  State<ListScheduleCalenderView> createState() =>
      _ListScheduleCalenderViewState();
}

class _ListScheduleCalenderViewState extends State<ListScheduleCalenderView> {
  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  late List<CalenderDataModel> calendarList;
  @override
  void initState() {
    if(widget.isLiveListing && widget.listData.schedule!.isNotEmpty){
      calendarList = weekDays.map((day) {
    final schedule = widget.listData.schedule!.firstWhere(
      (item) => item.day == day.toLowerCase(),
      orElse: () => CalenderDataModel(day: day, startTime: null, endTime: null, isSelect: false),
    );
    return CalenderDataModel(
      day: day,
      startTime: schedule.startTime,
      endTime: schedule.endTime,
      isSelect: schedule.startTime != null && schedule.endTime != null
    );
  }).toList();
    }
    else{
      calendarList = weekDays
        .map(
          (day) => CalenderDataModel(day: day, startTime: null, endTime: null),
        )
        .toList();
    }
    
    super.initState();
  }

  selectSlot(int index) {
    setState(() {
      final item = calendarList[index];
      calendarList[index] = item.copyWith(isSelect: !item.isSelect);
    });
  }

  Future<void> _selectTimeRange(int index) async {
    final result = await showDialog<Map<String, TimeOfDay?>>(
      context: context,
      builder: (context) =>
           TimeRangePickerDialog(title: 'Set Timing', initialStart: calendarList[index].startTime, initialEnd:calendarList[index].endTime ,),
    );

    if (result != null) {
      final start = result['start'];
      final end = result['end'];
      setState(() {
        calendarList[index] = calendarList[index].copyWith(
          startTime: start,
          endTime: end,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      
      customBottomWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.horizontalPadding),
        child: Consumer(
          builder: (context, ref, child) {
            final isLoad =
              widget.isLiveListing? ref
                    .watch(productProvider.select((e) => e.updateApiRes))
                    .status ==
                Status.loading: ref
                    .watch(productProvider.select((e) => e.setReviewApiRes))
                    .status ==
                Status.loading  ;
            return CustomButtonWidget(
              isLoad: isLoad,
              title:widget.isLiveListing?context.tr("update"): context.tr("list_now"),
              onPressed: () {
                final list = calendarList.where((e) => e.isSelect).toList();
                if (list.isNotEmpty) {
                  if (list.any(
                    (e) => e.endTime == null || e.startTime == null,
                  )) {
                    Helper.showMessage(
                      context,
                      message:
                          "Please properly set start time and end time of selected days",
                    );
                    return;
                  }
                  Map<String, dynamic> data = widget.data;
                  final jsonOutput = {
                    for (final item in list)
                      item.day.toLowerCase(): item.toJson(),
                  };
                  data["weekly_schedule"] = jsonOutput;
                  if(widget.isLiveListing){
                    ref.read(productProvider.notifier).updateList(listingId: widget.listData.listingId, input: data, times: 2);
                  }
                  else{
                    ref
                      .read(productProvider.notifier)
                      .setReview(input: data, times: 4);
                  }
                  
                } else {
                  Helper.showMessage(
                    context,
                    message: context.tr('please_select_any_day_of_schedule'),
                  );
                }
              },
            );
          },
        ),
      ),
      onButtonTap: () {
        // AppRouter.push(SelectProductView(isInstant: true,));
      },
      title: context.tr("listing_schedule_calendar"),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  Text(
                    context.tr("listing_schedule_calendar"),
                    style: context.textStyle.displayMedium,
                  ),
                ],
              ),
              ...List.generate(calendarList.length, (index) {
                final item = calendarList[index];
                return Column(
                  spacing: 10.0,
                  children: [
                    Container(
                      height: 40.h,
                      padding: EdgeInsets.only(left: 15.r),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.day,
                              style: context.textStyle.bodyMedium,
                            ),
                          ),
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            side: BorderSide(color: AppColors.secondaryColor),
                            value: item.isSelect,
                            onChanged: (v) {
                              selectSlot(index);
                            },
                            activeColor: AppColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        _selectTimeRange(index);
                      },
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.r),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item.startTime != null ? item.startTime!.format(context) : "--"} - ${item.endTime != null ? item.endTime!.format(context) : "--"}",
                                style: context.textStyle.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CalenderDataModel {
  final String day;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  bool isSelect;

  CalenderDataModel({
    required this.day,
    this.startTime,
    this.endTime,
    this.isSelect = false,
  });

  CalenderDataModel copyWith({
    String? day,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isSelect,
  }) {
    return CalenderDataModel(
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isSelect: isSelect ?? this.isSelect,
    );
  }

  /// ✅ Parse JSON → Model
  factory CalenderDataModel.fromJson(String day, Map<String, dynamic> json) {
    return CalenderDataModel(
      day: day,
      startTime: json['start_time'] != null
          ? _parseTime(json['start_time'])
          : null,
      endTime: json['end_time'] != null ? _parseTime(json['end_time']) : null,
    );
  }

  /// ✅ Convert Model → JSON (returns time as "HH:mm:ss.SSSZ")
  Map<String, dynamic> toJson() {
    return {
      'start_time': _formatTime(startTime),
      'end_time': _formatTime(endTime),
    };
  }

  /// 🔧 Parse "17:54:07.666Z" → TimeOfDay
  static TimeOfDay? _parseTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return null;

    // Add dummy date so DateTime.parse works
    final parsed = DateTime.tryParse("1970-01-01T$timeString");
    if (parsed == null) return null;

    return TimeOfDay(hour: parsed.hour, minute: parsed.minute);
  }

  /// 🔧 Format TimeOfDay → "HH:mm:ss.SSSZ"
  static String? _formatTime(TimeOfDay? time) {
    if (time == null) return null;

    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    const seconds = '07'; // optional — can randomize or fix
    const milliseconds = '666'; // optional
    return '$hours:$minutes:$seconds.${milliseconds}Z';
  }
}
