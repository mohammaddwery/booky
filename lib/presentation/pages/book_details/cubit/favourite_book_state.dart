import 'package:equatable/equatable.dart';

class FavouriteBookState extends Equatable {
  final bool status;
  const FavouriteBookState(this.status);

  @override
  List<Object> get props => [ status ];
}