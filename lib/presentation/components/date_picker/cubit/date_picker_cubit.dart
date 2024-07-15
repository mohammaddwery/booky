import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit(): super(const DatePickerState(null));

  setState(DateTime? dateTime) {
    emit(DatePickerState(dateTime));
  }
}