import 'package:equatable/equatable.dart';

class DatePickerState extends Equatable {
  final DateTime? date;
  const DatePickerState(this.date);

  @override
  List<Object?> get props => [date];
}