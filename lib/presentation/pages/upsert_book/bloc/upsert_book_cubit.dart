import 'package:booky/repository/user_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/di/dependencies_container.dart';
import '../../../../repository/books_repository.dart';
import '../../../routes/app_router.dart';
import '../../../theme/app_colors.dart';
import 'upsert_book_state.dart';

class UpsertBookCubit extends Cubit<UpsertBookState> {
  final BooksRepository _booksRepository;
  UpsertBookCubit(this._booksRepository): super(UpsertBookState());
  
  String? _title;
  String? _description;
  String? _author;
  DateTime? _publish;

  onTitleChanged(String? value) {
    _title = value;
  }
  onAuthorChanged(String? value) {
    _author = value;
  }
  onDescriptionChanged(String? value) {
    _description = value;
  }
  onPublishChanged(DateTime? value) {
    _publish = value;
  }


  void addBook() {
    String? validationMessage = _validateInputs();
    if(validationMessage!=null) {
      Fluttertoast.showToast(
          msg: validationMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
        ,
          backgroundColor: AppColors.error,
          textColor: AppColors.accent,
          fontSize: 14.sp,
      );
      return;
    }

    _booksRepository.addUserBook(UserBook(
        author: _author!, 
        title: _title!,
        description: _description!, 
        publish: _publish!,
    ),);
    getIt.get<AppRouter>().push(const MyBooksRoute());
  }

  _validateInputs() {
    /// Title's validation
    if (_title?.isEmpty ?? true) {
      return 'Please enter your book\'s title';
    }

    if (_title!.length < 10 || _title!.length > 120) {
      return 'Please keep your book\'s title between 10 and 120 characters';
    }

    /// Author's validation
    if (_author?.isEmpty ?? true) {
      return 'Please enter your book\'s author name';
    }

    if (_author!.length < 10 || _author!.length > 32) {
      return 'Please keep your book\'s author name between 10 and 32 characters';
    }

    /// Description's validation
    if (_description?.isEmpty ?? true) {
      return 'Please enter your book\'s description';
    }

    if (_description!.length < 20 || _description!.length > 400) {
      return 'Please keep your book\'s description between 20 and 200 characters';
    }

    /// Publish date validation
    if (_publish == null) {
      return 'Please enter your book\'s publish date';
    }

    if (_publish!.isBefore(DateTime(2000))) {
      return 'Sorry your book has to beb published after 2000';
    }

    return null;
  }
}