import 'package:booky/core/utils/build_config.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../core/di/dependencies_container.dart';

List<Book> adaptBooksFromJson(List<dynamic> json) {
  return List<Book>.from(json.map((e) => Book.fromJson(e)).toList());
}

class Book extends Equatable {
  final String workId;
  final String authorName;
  final String title;
  final int? coverId;
  final String? firstSentence;
  final String? subject;
  final String? description;
  final DateTime? created;
  const Book({
    required this.workId,
    required this.authorName,
    required this.title,
    this.coverId,
    this.firstSentence,
    this.subject,
    this.description,
    this.created,
  });

  /// The backend's response is weird so I handled as it is. Sorry!
  factory Book.fromJson(Map<String, dynamic> json) {
    String? firstSentence;
    if (json['first_sentence'] is List) {
      List<String> firstSentences = List<String>.from(json['first_sentence']??[]);
      firstSentence = firstSentences.isNotEmpty ? firstSentences.first : null;
    } else {
      firstSentence = json['first_sentence']?['value'];
    }

    String? description;
    if(json['description'] is String) {
      description = json['description'];
    } else {
      description = json['description']?['value'];
    }

    List<String> subjects = List<String>.from(json['subject']??[]);
    String? subject = subjects.isNotEmpty ? subjects.first : null;

    List<String> authorNames = List<String>.from(json['author_name']??[]);
    String authorName = authorNames.isNotEmpty ? authorNames.first : '';

    final workKey = (json['key']??'').toString();
    final workId = workKey.startsWith('/') ? workKey.substring(7) : workKey;

    List<int> covers = List<int>.from(json['covers']??[]);
    int? cover = json['cover_i'];
    cover = covers.isNotEmpty ? covers.first : (cover);

    return Book(
      title: json['title']??'',
      firstSentence: firstSentence,
      subject: subject,
      coverId: cover,
      authorName: authorName,
      workId: workId,
      created: json['created']==null ? null : DateTime.tryParse(json['created']['value']),
      description: description,
    );
  }

  Book copyWith({
    String? workId,
    String? authorName,
    String? title,
    int? coverId,
    String? firstSentence,
    String? subject,
    String? description,
    DateTime? created,
  }) => Book(
      workId: workId??this.workId,
      authorName: authorName??this.authorName,
      title: title??this.title,
      coverId: coverId??this.coverId,
      firstSentence: firstSentence??this.firstSentence,
      subject: subject??this.subject,
      description: description??this.description,
      created: created??this.created,
  );

  @override
  List<Object?> get props => [
    authorName,
    workId,
    title,
    coverId,
    firstSentence,
    subject,
  ];
}

extension BookExtension on Book {
  String get cover {
    if(coverId == null) return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnFSeIfLviNlTiizgznLZEG-4vmKvvZd7OS0RNseTf3FIzsg-jNR1zKZo7qN8UUwevSnc&usqp=CAU';
    return '${getIt.get<BuildConfig>().coverImageBaseUrl}id/$coverId-M.jpg';
  }

  String get formattedPublishDate => DateFormat('yyyy-MM-dd').format(created??DateTime.now());
}

extension BooksExtension on List<Book> {
  List<Book> filterBooksByAuthorAndTitle(String keyword) => List<Book>.from(where((element) => element.title.toLowerCase().contains(keyword.toLowerCase())
      || element.authorName.toLowerCase().contains(keyword.toLowerCase())));
}