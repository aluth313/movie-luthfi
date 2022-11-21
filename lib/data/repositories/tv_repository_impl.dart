import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getAiringTodaySeries() async {
    try {
      final result = await remoteDataSource.getAiringTodaySeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Episodes>> getEpisodesBySessionNumber(
      int tvId, int sesionNumber) async {
    try {
      final result =
          await remoteDataSource.getEpisodesBySessionNumber(tvId, sesionNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // @override
  // Future<Either<Failure, List<Movie>>> getPopularMovies() async {
  //   try {
  //     final result = await remoteDataSource.getPopularMovies();
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // @override
  // Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
  //   try {
  //     final result = await remoteDataSource.searchMovies(query);
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail series) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail series) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistSeries() async {
    final result = await localDataSource.getWatchlistSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
