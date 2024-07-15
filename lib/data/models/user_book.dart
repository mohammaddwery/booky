import 'package:equatable/equatable.dart';

class UserBook extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final DateTime? publish;
  final int id;
  const UserBook({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.publish,
  });

  @override
  List<Object?> get props => [
    id,
    author,
    title,
    description,
    publish,
  ];
}