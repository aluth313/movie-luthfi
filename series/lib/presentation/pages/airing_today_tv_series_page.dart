import 'package:series/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/bloc/airing_today_tv_series_bloc.dart';

class AiringTodayTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-series';

  @override
  _AiringTodayTvSeriesPageState createState() =>
      _AiringTodayTvSeriesPageState();
}

class _AiringTodayTvSeriesPageState extends State<AiringTodayTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AiringTodayTvSeriesBloc>().add(
          FetchAiringTodaySeries(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
          builder: (context, state) {
            if (state is AiringTodayTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvSeriesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = result[index];
                  return TvSeriesCard(series);
                },
                itemCount: result.length,
              );
            } else if (state is AiringTodayTvSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
