import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixabay_api_search_app/app/pixabay_search/pixabay_search_bloc.dart';
import 'package:flutter_pixabay_api_search_app/widgets/cupertino_loading_indicator.dart';
import 'package:flutter_pixabay_api_search_app/widgets/top_aligned_widget.dart';

class PixabaySearch extends StatefulWidget {
  @override
  _PixabaySearchResultsState createState() => _PixabaySearchResultsState();
}

class _PixabaySearchResultsState extends State<PixabaySearch> {
  /// business logic component (BLoC) for managing all application state
  late PixabaySearchBloc _pixabaySearchBloc;

  @override
  void initState() {
    super.initState();
    _pixabaySearchBloc = PixabaySearchBloc();
  }

  @override
  void dispose() {
    _pixabaySearchBloc.dispose();
    super.dispose();
  }

  void _clearFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    /// get style configuration properties based off theme data
    CupertinoThemeData theme = CupertinoTheme.of(context);
    Color barBackgroundColor = theme.barBackgroundColor;
    TextStyle headerStyle = theme.textTheme.navTitleTextStyle;

    return GestureDetector(
      /// ensure gestures are fired on translucent background widgets
      behavior: HitTestBehavior.translucent,
      onTap: _clearFocus,
      // onVerticalDragUpdate: (_) {
      /// ondrag gesture will not fire with embedded listview builder.
      /// https://github.com/flutter/flutter/issues/23325
      /// therefore keyboard dismissal for on drag has been assigned directly
      /// to the listview
      // },
      child: Column(
        children: [
          /// Page header
          Container(
            color: barBackgroundColor,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                /// Title
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Pixabay',
                    style: headerStyle,
                  ),
                ),

                /// Search field
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    /// fire main search method evertime search field values change
                    onChanged: _pixabaySearchBloc.getPictures,
                  ),
                ),
              ],
            ),
          ),

          /// Page content - scrollable image results
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: ImageListViewBuilder(
                pixabaySearchBloc: _pixabaySearchBloc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageListViewBuilder extends StatelessWidget {
  final PixabaySearchBloc pixabaySearchBloc;

  ImageListViewBuilder({
    required this.pixabaySearchBloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PixabaySearchResultsState>(
      stream: pixabaySearchBloc.stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          /// case 1 - awaiting connection
          return TopAlignedWidget(
            child: CupertinoLoadingIndictor(
              text: 'Loading',
            ),
          );
        } else if (snapshot.hasError) {
          /// case 2 - error in snapshot
          return TopAlignedWidget(
            child: Text('${snapshot.error.toString()}'),
          );
        } else if (!snapshot.hasData) {
          /// case 3 - no data recieved
          return TopAlignedWidget(
            child: Text('Error: No data recieved'),
          );
        } else {
          /// case 4 - all verfication checks passed
          PixabaySearchResultsState state = snapshot.data!;

          /// Build specific widget based on the state of the search results
          if (state.query == '') {
            /// case 1 - initial load of application
            return Container();
          } else if (state.isLoading == true) {
            /// case 2 - search request in process
            return TopAlignedWidget(
              child: CupertinoLoadingIndictor(
                text: 'Loading',
              ),
            );
          } else {
            /// case 3 - search request completed
            if ((state.results?.hits?.length ?? 0) < 1) {
              /// case 3.1 - no results for query string

              /// define theme based styling
              CupertinoThemeData theme = CupertinoTheme.of(context);
              TextStyle style = theme.textTheme.textStyle.copyWith(
                color: CupertinoColors.secondaryLabel,
              );
              return TopAlignedWidget(
                child: Text(
                  'No Results',
                  style: style,
                ),
              );
            }

            /// case 3.2 - results for query string
            // TODO - Step 4 - Implement UI for displaying results
            return Container(
              color: Colors.red,
              child: Center(
                child: Text('${state.results?.toMap()}'),
              ),
            );
          }
        }
      },
    );
  }
}
