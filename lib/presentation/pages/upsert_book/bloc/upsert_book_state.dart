import 'package:equatable/equatable.dart';

class UpsertBookState extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final DateTime? publish;

  const UpsertBookState({
    this.author,
    this.title,
    this.description,
    this.publish,
  });

  @override
  List<Object?> get props => [
        author,
        title,
        description,
        publish,
      ];
}

final class UpdateBookSuccess extends UpsertBookState {
final int updatedbookId;
const UpdateBookSuccess(this.updatedbookId,);
@override
List<Object?> get props => [
updatedbookId,
];
}

final class AddBookSuccess extends UpsertBookState {
@override
List<Object?> get props => [];
}

final class UpsertBookFailure extends UpsertBookState {
  final String message;
  final int _now;
  const UpsertBookFailure(
    this.message,
    this._now,
    String? title,
    String? author,
    String? description,
    DateTime? publish,
  ) : super(
          title: title,
          author: author,
          description: description,
          publish: publish,
        );

  @override
  List<Object?> get props => [
    message,
    _now,
    title,
    author,
    description,
    publish,
];
}
