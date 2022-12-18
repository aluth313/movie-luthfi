import 'package:series/presentation/pages/search_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/search_movies_page.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Movies',
                ),
                Tab(
                  text: 'TV Series',
                ),
              ],
            ),
            title: const Text('Search'),
          ),
          body: const TabBarView(
            children: [
              SearchMoviesPage(),
              SearchSeriesPage(),
            ],
          ),
        ));
  }
}
