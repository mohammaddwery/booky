import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_style.dart';
import 'cubit/date_picker_cubit.dart';
import 'cubit/date_picker_state.dart';

class DatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime) onChanged;
  const DatePicker({
    required this.onChanged,
    this.initialDate, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatePickerCubit()..setState(initialDate),
      child: Builder(
        builder: (context) {
          return DatePickerView(initialDate: initialDate, onChanged: (value) {
            context.read<DatePickerCubit>().setState(value);
            onChanged(value);
          },);
        }
      ),
    );
  }
}

class DatePickerView extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime) onChanged;
  const DatePickerView({
    required this.onChanged,
    this.initialDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerCubit, DatePickerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            isScrollControlled: true,
            backgroundColor: AppColors.white,
            context: context,
            builder: (context) => SizedBox(
              height: 400.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate??DateTime.now(),
                itemExtent: 66.h,
                onDateTimeChanged: (value) {
                  onChanged(value);
                },
              ),
            ),
          ),
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 16, horizontal: 16,),
            decoration: BoxDecoration(
              border: Border.all(color: state.date!=null ? AppColors.primary : AppColors.grey30),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(child: Text(
                  state.date != null ? DateFormat.yMd().format(state.date!) : 'Select a date',
                  style: AppTextStyle.style.copyWith(
                    color: AppColors.grey90.withOpacity(state.date != null ? 1.0 : .7),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                const Icon(Icons.arrow_right_rounded , color: AppColors.primary),
              ],
            ),
          ),
        );
      },
    );
  }
}

