import 'package:equatable/equatable.dart';
import '../../../../repository/user_book.dart';

class MyBooksState extends Equatable {
  final List<UserBook> books;
  const MyBooksState(this.books);

  @override
  List<Object?> get props => [ books ];
}