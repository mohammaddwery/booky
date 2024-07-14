import 'package:equatable/equatable.dart';

class UserBook extends Equatable {
  final String author;
  final String title;
  final String description;
  final DateTime publish;
  const UserBook({
    required this.author,
    required this.title,
    required this.description,
    required this.publish,
  });

  @override
  List<Object?> get props => [
    author,
    title,
    description,
    publish,
  ];
}