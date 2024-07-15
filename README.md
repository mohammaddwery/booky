# Booky app

This a technical test for "Senior Flutter Developer"

## Features
- Books listing that fetched from webserver
- Search for books by keyword
- Book's details
- Mark book as favourite(stores the favourite in local storage)
- Create a new book(stores the book in memory)
- Update the created book
- Created books listing

The app uses open library as web server to serves its API requests. 
[open_library], [Search_api], [Book_api]


## Installation 

Make sure that you passed the setup process of Flutter/Dart [flutter_install_guide]

> ❗️ Note: The project built with Flutter sdk version `3.19.4`

```shell
  flutter pub get
  flutter run ./lib/main_development.dart
```


## Dependencies

```yaml
environment:
  sdk: '>=3.3.2 <4.0.0'
  flutter: '>=3.19.4'
  
dependencies:  
  auto_route: 8.1.1
  logger: ^2.3.0
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  dio: ^5.5.0+1
  pretty_dio_logger: ^1.3.1
  cached_network_image: ^3.2.3
  stream_transform: ^2.0.0
  flutter_screenutil: ^5.9.3
  get_it: ^7.2.0
  mocktail_image_network: ^1.2.0
  intl: ^0.18.0
  shared_preferences: ^2.2.3
  fluttertoast: ^8.2.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  auto_route_generator: ^8.0.0
  build_runner: ^2.4.9
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
```


## Environment

App built to support multiple environments, Please check `~/lib/main_development.dart`

## Architecture

App built with Clean architecture and Bloc state management respecting software engineering principles to be maintainable and scalable 

### Files structure

---lib
    ---core
        ---data
            --local
            --remote
        ---di
        ---utils
    ---data
        ---models
        ---repository
        ---resources
            --local
            --remote
    ---repository
    ---presentation
        ---components
        ---pages
            --feature1
                --bloc
                --view
                --widgets
        ---routes
        ---theme
    ---app.dart
    ---main_development.dart


Data flow goes from inner to outer(from data to presentation) and control flow geos from outer into inner(from presentation to data).
Core layer serves outer layer and provides infrastructure tools.

Test folder structured the same way.

## Testing
The tests are unit and widget's tests which covered Bloc unit's testing and pages widget's testing.


Run the tests:
```shell
  flutter test
```

### 1. app_test.dart:
- renders development MyApp


### 2. Book Search feature:

#### BookSearchBloc `book_search_bloc_test.dart` UNIT_TESTING
on BooksRequested scenario:
- emits [SearchStateLoading, SearchStateSuccess] when getBooks succeeds.
- emits [SearchStateLoading, SearchStateEmpty] when getBooks() returns empty results.
- emits [SearchStateLoading, SearchStateError] when getBooks() gets InternetConnectionErrorException
- emits [SearchStateLoading, SearchStateError] when getBooks() gets UnexpectedErrorException

on KeywordChanged with empty value and triggered after awaited debounce time scenario: 
- emits [SearchStateLoading, SearchStateSuccess] when books filtering get results.
- emits [SearchStateLoading, SearchStateError] with books filtering returns empty results.

on KeywordChanged with value and triggered after awaited debounce time scenario:
- emits [SearchStateLoading, SearchStateSuccess] when books filtering get results

#### BookSearchEvent `book_search_event_test.dart` UNIT_TESTING
BooksRequested
- supports value comparisons
KeywordChanged
- supports value comparisons

#### BookSearchState `book_search_state_test.dart` UNIT_TESTING
- SearchStateEmpty
- SearchStateLoading
- SearchStateError
- SearchStateSuccess

#### WIDGET_TESTING `book_search_page_test.dart` 
BookSearchPage
- renders BookSearchPage

BookSearchView
- renders BooksSearchBox
- renders BooksSearchResults

BooksSearchResults states
- renders SearchStateLoading widget
- renders SearchStateEmpty widget
- renders SearchStateSuccess widget and verifies that BooksRequested triggered
- renders SearchStateSuccess widget and verify that book\'s card rendered
- renders SearchStateError widget
- renders SearchStateError widget then clicks reload to add BooksRequested to BookSearchBloc

on KeywordChanged triggered
when booksSearchBox changes add KeywordChanged to BookSearchBloc


### 3. Book Details feature:

#### BookDetailsCubit `book_details_cubit_test.dart` UNIT_TESTING
fetchBook scenario:
- emits [BookLoading, BookSuccess] when getBook() succeeds.
- emits [BookLoading, BookError] when getBook() gets InternetConnectionErrorException
- emits [BookLoading, BookError] when getBook() gets UnexpectedErrorException

#### BookDetailsState `book_details_state_test.dart` UNIT_TESTING
supports value comparisons
- BookLoading
- BookError
- BookSuccess

#### FavouriteBookCubit `favourite_book_cubit_test.dart` UNIT_TESTING
- emits [FavouriteBookState] with true value when getFavoriteBooks() contains the same book.
- emits [FavouriteBookState] with false value when getFavoriteBooks() doesn\'t contain the same book.
- emits [FavouriteBookState] with true value after adding a new book to favourite list.
- emits [FavouriteBookState] with false value after removing a book from favourite list.

#### WIDGET_TESTING `book_details_page_test.dart`
BookDetailsPage
- renders BookDetailsPage

BookDetails states
- renders BookLoading widget
- renders BookSuccess widget and verifies that fetchBook() called
- renders BookSuccess widget and verify that book\'s cover rendered
- renders BookSuccess widget and verify that book\'s title rendered
- renders BookSuccess widget and verify that book\'s description rendered
- renders BookSuccess widget and verify that book\'s author and publish date rendered
- renders BookError widget
- renders BookError widget then clicks reload to fetchBook()

FavouriteBookButton
- renders FavouriteButton widget

### 4. Upsert Book feature:
#### UpsertBookBloc `upsert_book_bloc_test.dart` UNIT_TESTING
on Field\'s values changed scenario:
- emits [UpsertBookState] with title value when BookTitleChanged event added.
- emits [UpsertBookState] with author value when BookAuthorChanged event added.
- emits [UpsertBookState] with description value when BookDescriptionChanged event added.
- emits [UpsertBookState] with publish date value when BookPublishDateChanged event added.

on AddBookRequested scenario:
- emits [UpsertBookFailure] with validation message for title when AddBookRequested event added with invalid title value.
- emits [AddBookSuccess] when AddBookRequested event added with valid book.

on UpdateBookRequested scenario:
- emits [UpdateBookSuccess] when UpdateBookRequested event added with valid book.
- emits [UpsertBookFailure] with validation message for title when UpdateBookRequested event added with invalid title value.





<!-- Readme links -->
[flutter_install_guide]: https://docs.flutter.dev/get-started/install
[open_library]: https://openlibrary.org/developers/api
[Search_api]: https://openlibrary.org/search.json?q=the+lord+of+the+rings&limit=10
[Book_api]: https://openlibrary.org/works/OL27448W.json

