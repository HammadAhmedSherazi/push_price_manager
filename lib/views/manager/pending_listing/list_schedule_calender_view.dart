import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListScheduleCalenderView extends StatefulWidget {
  final Map<String, dynamic> data;
  const ListScheduleCalenderView({super.key, required this.data} );

  @override
  State<ListScheduleCalenderView> createState() => _ListScheduleCalenderViewState();
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

late  List<CalenderDataModel> calendarList;
@override
void initState() {
  calendarList = weekDays
    .map((day) => CalenderDataModel(day: day, startTime: null, endTime: null))
    .toList();
  super.initState();
  
}
selectSlot(int index){
  setState(() {
    final item = calendarList[index];
    calendarList[index] = item.copyWith(isSelect:!item.isSelect );

  });
}
Future<void> _selectTimeRange(int index) async {
  final result = await showDialog<Map<String, TimeOfDay?>>(
    context: context,
    builder: (context) => const TimeRangePickerDialog(
      title: 'Set Working Hours',
    ),
  );

  if (result != null) {
    final start = result['start'];
    final end = result['end'];
    setState(() {
      calendarList[index] = calendarList[index].copyWith(startTime:start, endTime: end);
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: (){
        // ref
        //                 .read(productProvider.notifier)
        //                 .setReview(input: data, times:  3);
        AppRouter.push(SelectProductView(isInstant: true,));
      },
      title: "Listing Schedule Calender", child: Padding(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Row(
              children: [
                Text("Listing Schedule Calender", style: context.textStyle.displayMedium,)
              ],
            ),
            ...List.generate(calendarList.length, (index) {
              final item = calendarList[index];
              return Column(
              spacing: 10.0,
              children: [
                Container(
                  height: 40.h,
                    padding: EdgeInsets.only(
                    left: 15.r
                  ),
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: AppColors.borderColor
                    )
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(item.day, style: context.textStyle.bodyMedium,)),
                       Checkbox(
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(3.r),
                  
                ),
                side: BorderSide(
                  color: AppColors.secondaryColor
                ),
                value: item.isSelect, onChanged: (v){
                selectSlot(index);
                        },activeColor: AppColors.secondaryColor, ),
                    ],
                  ),
                ),
              
                GestureDetector(
                  onTap: (){
                    _selectTimeRange(index);
                  },
                  child: Container(
                    height: 40.h,
                      padding: EdgeInsets.symmetric(
                      horizontal: 15.r
                    ),
                  
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: AppColors.borderColor
                      )
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text("${item.startTime != null ? item.startTime!.format(context) : "--"} - ${item.endTime != null ?item.endTime!.format(context) : "--"}", style: context.textStyle.bodyMedium,)),
                       
                      ],
                    ),
                  ),
                ),
              ],
            );
            })
          ],
        ),
      ),
    ));
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
    String? timeSlot,
    bool? isSelect,
    TimeOfDay? startTime,
    TimeOfDay? endTime
  }) {
    return CalenderDataModel(
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isSelect: isSelect ?? this.isSelect,
    );
  }
}