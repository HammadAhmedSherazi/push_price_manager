import 'package:push_price_manager/utils/extension.dart';

import '../../../export_all.dart';

class ListScheduleCalenderView extends StatefulWidget {
  const ListScheduleCalenderView({super.key});

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

late final List<CalenderDataModel> calendarList;
@override
void initState() {
  calendarList = weekDays
    .map((day) => CalenderDataModel(day: day, timeSlot: '9:00-18:00'))
    .toList();
  super.initState();
  
}
selectSlot(int index){
  setState(() {
    final item = calendarList[index];
    calendarList[index] = item.copyWith(isSelect:!item.isSelect );

  });
}
  @override
  Widget build(BuildContext context) {
    return CustomScreenTemplate(
      showBottomButton: true,
      bottomButtonText: "next",
      onButtonTap: (){
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
            ...List.generate(calendarList.length, (index)=> Column(
              spacing: 10.0,
              children: [
                Container(
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
                      Text(calendarList[index].day, style: context.textStyle.bodyMedium,),
                     
                    ],
                  ),
                ),
              
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
                      Expanded(child: Text(calendarList[index].timeSlot, style: context.textStyle.bodyMedium,)),
                       Checkbox(
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(3.r),
                  
                ),
                side: BorderSide(
                  color: AppColors.secondaryColor
                ),
                value: calendarList[index].isSelect, onChanged: (v){
                selectSlot(index);
                        },activeColor: AppColors.secondaryColor, ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}


class CalenderDataModel {
  final String day;
  final String timeSlot;
  bool isSelect;

  CalenderDataModel({
    required this.day,
    required this.timeSlot,
    this.isSelect = false,
  });

  CalenderDataModel copyWith({
    String? day,
    String? timeSlot,
    bool? isSelect,
  }) {
    return CalenderDataModel(
      day: day ?? this.day,
      timeSlot: timeSlot ?? this.timeSlot,
      isSelect: isSelect ?? this.isSelect,
    );
  }
}