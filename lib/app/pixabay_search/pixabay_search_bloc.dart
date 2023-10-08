import 'dart:async';
import 'package:flutter_pixabay_api_search_app/models/pixabay_data_model.dart';
import 'package:flutter_pixabay_api_search_app/services/pixabay_api_service.dart';

class PixabaySearchResultsState {
  /// current query specified by user
  final String query;

  /// processed search results recieved from pixabay api
  PixabayResultsModel? results;

  /// whether or not the result request is still being processed
  bool isLoading;

  PixabaySearchResultsState({
    required this.query,
    this.results,
    this.isLoading = true,
  });
}

class PixabaySearchBloc {
  /// current query issued by user
  String? _currentQuery;

  /// temporary storage of all queries and search results
  Map<String, PixabaySearchResultsState> _cache =
      Map<String, PixabaySearchResultsState>();

  /// create stream controller with one listener expected
  StreamController<PixabaySearchResultsState> _streamController =
      StreamController<PixabaySearchResultsState>();

  /// expose stream
  Stream<PixabaySearchResultsState> get stream {
    return _streamController.stream;
  }

  /// service for managing requests to the pixabay API
  PixabayApiService _pixabayApiService = PixabayApiService();

  PixabaySearchBloc() {
    /// initialise with empty value so listeners can update to suit
    initialise();
  }

  void initialise() {
    PixabaySearchResultsState initialState = PixabaySearchResultsState(
      query: '',
      results: null,
      isLoading: false,
    );
    _streamController.sink.add(initialState);
  }

  /// [getPictures] is the main BLoC method for controlling when requests are
  /// sent to the pixabay api or fetched from cache and updating the stream
  void getPictures(String query) {
    /// pixabay searches are case insensitive, therefore all operations,
    /// especially cache should also be set using case insensitivity. This
    /// prevents results being fetched for wine and Wine as an example
    query = query.toLowerCase();

    /// Check for search request cases
    if (query.length > 2 && query.length <= 100) {
      /// set current query
      _currentQuery = query;

      /// case 1 - query greater than or equal to 4 characters
      if (_cache[query] != null) {
        /// case 1.1 - results already in cache
        _streamController.sink.add(_cache[query]!);
      } else {
        /// case 1.2 - no results in cache
        /// define state for new search query
        PixabaySearchResultsState state = PixabaySearchResultsState(
          query: query,
          results: null,
          isLoading: true,
        );

        /// add state to cache for future requests
        _cache[query] = state;

        /// execute new query on pixabay api
        Future<PixabayResultsModel> request =
            _pixabayApiService.requestPictures(query: query);

        /// add callback to request for updating state and releasing results
        request.then((response) {
          /// update state
          state.isLoading = false;
          state.results = response;

          if (_currentQuery == state.query) {
            /// only release processed request on stream if user is still
            /// has the same search term in the text input... prevents the wrong
            /// results being displayed if the user is quickly changing search
            /// terms
            _streamController.sink.add(state);
          }
        }).catchError((error) {
          /// error in processing pixabay request... release error on stream
          _streamController.sink.addError(error);
        });

        /// release new event on stream so that ui can rebuild while request is
        /// processing
        _streamController.sink.add(state);
      }
    }

    /// case 2 - search criteria not met
    /// dont release new stream events so last results are still displayed
    /// when user clears search results
  }

  /// [dispose] ensure all resources are destroyed when the bloc is cleaned
  /// up preventing memory leaks within the application
  void dispose() {
    _streamController.close();
  }
}
