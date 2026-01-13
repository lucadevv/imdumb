// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PopularMoviesTableTable extends PopularMoviesTable
    with TableInfo<$PopularMoviesTableTable, PopularMoviesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PopularMoviesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
    'adult',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adult" IN (0, 1))',
    ),
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreIdsMeta = const VerificationMeta(
    'genreIds',
  );
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
    'genre_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalLanguageMeta = const VerificationMeta(
    'originalLanguage',
  );
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
    'original_language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
    'popularity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
    'video',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("video" IN (0, 1))',
    ),
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'popular_movies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PopularMoviesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('adult')) {
      context.handle(
        _adultMeta,
        adult.isAcceptableOrUnknown(data['adult']!, _adultMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('genre_ids')) {
      context.handle(
        _genreIdsMeta,
        genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta),
      );
    }
    if (data.containsKey('original_language')) {
      context.handle(
        _originalLanguageMeta,
        originalLanguage.isAcceptableOrUnknown(
          data['original_language']!,
          _originalLanguageMeta,
        ),
      );
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('video')) {
      context.handle(
        _videoMeta,
        video.isAcceptableOrUnknown(data['video']!, _videoMeta),
      );
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PopularMoviesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PopularMoviesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      adult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adult'],
      ),
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      ),
      genreIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre_ids'],
      ),
      originalLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_language'],
      ),
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      ),
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity'],
      ),
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      video: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}video'],
      ),
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      ),
      voteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vote_count'],
      ),
    );
  }

  @override
  $PopularMoviesTableTable createAlias(String alias) {
    return $PopularMoviesTableTable(attachedDatabase, alias);
  }
}

class PopularMoviesTableData extends DataClass
    implements Insertable<PopularMoviesTableData> {
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  const PopularMoviesTableData({
    required this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || adult != null) {
      map['adult'] = Variable<bool>(adult);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || genreIds != null) {
      map['genre_ids'] = Variable<String>(genreIds);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<bool>(video);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double>(voteAverage);
    }
    if (!nullToAbsent || voteCount != null) {
      map['vote_count'] = Variable<int>(voteCount);
    }
    return map;
  }

  PopularMoviesTableCompanion toCompanion(bool nullToAbsent) {
    return PopularMoviesTableCompanion(
      id: Value(id),
      adult: adult == null && nullToAbsent
          ? const Value.absent()
          : Value(adult),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      genreIds: genreIds == null && nullToAbsent
          ? const Value.absent()
          : Value(genreIds),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      video: video == null && nullToAbsent
          ? const Value.absent()
          : Value(video),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      voteCount: voteCount == null && nullToAbsent
          ? const Value.absent()
          : Value(voteCount),
    );
  }

  factory PopularMoviesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PopularMoviesTableData(
      id: serializer.fromJson<int>(json['id']),
      adult: serializer.fromJson<bool?>(json['adult']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      genreIds: serializer.fromJson<String?>(json['genreIds']),
      originalLanguage: serializer.fromJson<String?>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      overview: serializer.fromJson<String?>(json['overview']),
      popularity: serializer.fromJson<double?>(json['popularity']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      title: serializer.fromJson<String?>(json['title']),
      video: serializer.fromJson<bool?>(json['video']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      voteCount: serializer.fromJson<int?>(json['voteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'adult': serializer.toJson<bool?>(adult),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'genreIds': serializer.toJson<String?>(genreIds),
      'originalLanguage': serializer.toJson<String?>(originalLanguage),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'overview': serializer.toJson<String?>(overview),
      'popularity': serializer.toJson<double?>(popularity),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'title': serializer.toJson<String?>(title),
      'video': serializer.toJson<bool?>(video),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'voteCount': serializer.toJson<int?>(voteCount),
    };
  }

  PopularMoviesTableData copyWith({
    int? id,
    Value<bool?> adult = const Value.absent(),
    Value<String?> backdropPath = const Value.absent(),
    Value<String?> genreIds = const Value.absent(),
    Value<String?> originalLanguage = const Value.absent(),
    Value<String?> originalTitle = const Value.absent(),
    Value<String?> overview = const Value.absent(),
    Value<double?> popularity = const Value.absent(),
    Value<String?> posterPath = const Value.absent(),
    Value<String?> releaseDate = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<bool?> video = const Value.absent(),
    Value<double?> voteAverage = const Value.absent(),
    Value<int?> voteCount = const Value.absent(),
  }) => PopularMoviesTableData(
    id: id ?? this.id,
    adult: adult.present ? adult.value : this.adult,
    backdropPath: backdropPath.present ? backdropPath.value : this.backdropPath,
    genreIds: genreIds.present ? genreIds.value : this.genreIds,
    originalLanguage: originalLanguage.present
        ? originalLanguage.value
        : this.originalLanguage,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    overview: overview.present ? overview.value : this.overview,
    popularity: popularity.present ? popularity.value : this.popularity,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    title: title.present ? title.value : this.title,
    video: video.present ? video.value : this.video,
    voteAverage: voteAverage.present ? voteAverage.value : this.voteAverage,
    voteCount: voteCount.present ? voteCount.value : this.voteCount,
  );
  PopularMoviesTableData copyWithCompanion(PopularMoviesTableCompanion data) {
    return PopularMoviesTableData(
      id: data.id.present ? data.id.value : this.id,
      adult: data.adult.present ? data.adult.value : this.adult,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      overview: data.overview.present ? data.overview.value : this.overview,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      title: data.title.present ? data.title.value : this.title,
      video: data.video.present ? data.video.value : this.video,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PopularMoviesTableData(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PopularMoviesTableData &&
          other.id == this.id &&
          other.adult == this.adult &&
          other.backdropPath == this.backdropPath &&
          other.genreIds == this.genreIds &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.video == this.video &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount);
}

class PopularMoviesTableCompanion
    extends UpdateCompanion<PopularMoviesTableData> {
  final Value<int> id;
  final Value<bool?> adult;
  final Value<String?> backdropPath;
  final Value<String?> genreIds;
  final Value<String?> originalLanguage;
  final Value<String?> originalTitle;
  final Value<String?> overview;
  final Value<double?> popularity;
  final Value<String?> posterPath;
  final Value<String?> releaseDate;
  final Value<String?> title;
  final Value<bool?> video;
  final Value<double?> voteAverage;
  final Value<int?> voteCount;
  const PopularMoviesTableCompanion({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  PopularMoviesTableCompanion.insert({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  static Insertable<PopularMoviesTableData> custom({
    Expression<int>? id,
    Expression<bool>? adult,
    Expression<String>? backdropPath,
    Expression<String>? genreIds,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<double>? popularity,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<String>? title,
    Expression<bool>? video,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (adult != null) 'adult': adult,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (genreIds != null) 'genre_ids': genreIds,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (video != null) 'video': video,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
    });
  }

  PopularMoviesTableCompanion copyWith({
    Value<int>? id,
    Value<bool?>? adult,
    Value<String?>? backdropPath,
    Value<String?>? genreIds,
    Value<String?>? originalLanguage,
    Value<String?>? originalTitle,
    Value<String?>? overview,
    Value<double?>? popularity,
    Value<String?>? posterPath,
    Value<String?>? releaseDate,
    Value<String?>? title,
    Value<bool?>? video,
    Value<double?>? voteAverage,
    Value<int?>? voteCount,
  }) {
    return PopularMoviesTableCompanion(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PopularMoviesTableCompanion(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }
}

class $NowPlayingMoviesTableTable extends NowPlayingMoviesTable
    with TableInfo<$NowPlayingMoviesTableTable, NowPlayingMoviesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NowPlayingMoviesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
    'adult',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adult" IN (0, 1))',
    ),
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreIdsMeta = const VerificationMeta(
    'genreIds',
  );
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
    'genre_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalLanguageMeta = const VerificationMeta(
    'originalLanguage',
  );
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
    'original_language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
    'popularity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
    'video',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("video" IN (0, 1))',
    ),
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'now_playing_movies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NowPlayingMoviesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('adult')) {
      context.handle(
        _adultMeta,
        adult.isAcceptableOrUnknown(data['adult']!, _adultMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('genre_ids')) {
      context.handle(
        _genreIdsMeta,
        genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta),
      );
    }
    if (data.containsKey('original_language')) {
      context.handle(
        _originalLanguageMeta,
        originalLanguage.isAcceptableOrUnknown(
          data['original_language']!,
          _originalLanguageMeta,
        ),
      );
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('video')) {
      context.handle(
        _videoMeta,
        video.isAcceptableOrUnknown(data['video']!, _videoMeta),
      );
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NowPlayingMoviesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NowPlayingMoviesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      adult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adult'],
      ),
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      ),
      genreIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre_ids'],
      ),
      originalLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_language'],
      ),
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      ),
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity'],
      ),
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      video: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}video'],
      ),
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      ),
      voteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vote_count'],
      ),
    );
  }

  @override
  $NowPlayingMoviesTableTable createAlias(String alias) {
    return $NowPlayingMoviesTableTable(attachedDatabase, alias);
  }
}

class NowPlayingMoviesTableData extends DataClass
    implements Insertable<NowPlayingMoviesTableData> {
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  const NowPlayingMoviesTableData({
    required this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || adult != null) {
      map['adult'] = Variable<bool>(adult);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || genreIds != null) {
      map['genre_ids'] = Variable<String>(genreIds);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<bool>(video);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double>(voteAverage);
    }
    if (!nullToAbsent || voteCount != null) {
      map['vote_count'] = Variable<int>(voteCount);
    }
    return map;
  }

  NowPlayingMoviesTableCompanion toCompanion(bool nullToAbsent) {
    return NowPlayingMoviesTableCompanion(
      id: Value(id),
      adult: adult == null && nullToAbsent
          ? const Value.absent()
          : Value(adult),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      genreIds: genreIds == null && nullToAbsent
          ? const Value.absent()
          : Value(genreIds),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      video: video == null && nullToAbsent
          ? const Value.absent()
          : Value(video),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      voteCount: voteCount == null && nullToAbsent
          ? const Value.absent()
          : Value(voteCount),
    );
  }

  factory NowPlayingMoviesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NowPlayingMoviesTableData(
      id: serializer.fromJson<int>(json['id']),
      adult: serializer.fromJson<bool?>(json['adult']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      genreIds: serializer.fromJson<String?>(json['genreIds']),
      originalLanguage: serializer.fromJson<String?>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      overview: serializer.fromJson<String?>(json['overview']),
      popularity: serializer.fromJson<double?>(json['popularity']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      title: serializer.fromJson<String?>(json['title']),
      video: serializer.fromJson<bool?>(json['video']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      voteCount: serializer.fromJson<int?>(json['voteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'adult': serializer.toJson<bool?>(adult),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'genreIds': serializer.toJson<String?>(genreIds),
      'originalLanguage': serializer.toJson<String?>(originalLanguage),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'overview': serializer.toJson<String?>(overview),
      'popularity': serializer.toJson<double?>(popularity),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'title': serializer.toJson<String?>(title),
      'video': serializer.toJson<bool?>(video),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'voteCount': serializer.toJson<int?>(voteCount),
    };
  }

  NowPlayingMoviesTableData copyWith({
    int? id,
    Value<bool?> adult = const Value.absent(),
    Value<String?> backdropPath = const Value.absent(),
    Value<String?> genreIds = const Value.absent(),
    Value<String?> originalLanguage = const Value.absent(),
    Value<String?> originalTitle = const Value.absent(),
    Value<String?> overview = const Value.absent(),
    Value<double?> popularity = const Value.absent(),
    Value<String?> posterPath = const Value.absent(),
    Value<String?> releaseDate = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<bool?> video = const Value.absent(),
    Value<double?> voteAverage = const Value.absent(),
    Value<int?> voteCount = const Value.absent(),
  }) => NowPlayingMoviesTableData(
    id: id ?? this.id,
    adult: adult.present ? adult.value : this.adult,
    backdropPath: backdropPath.present ? backdropPath.value : this.backdropPath,
    genreIds: genreIds.present ? genreIds.value : this.genreIds,
    originalLanguage: originalLanguage.present
        ? originalLanguage.value
        : this.originalLanguage,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    overview: overview.present ? overview.value : this.overview,
    popularity: popularity.present ? popularity.value : this.popularity,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    title: title.present ? title.value : this.title,
    video: video.present ? video.value : this.video,
    voteAverage: voteAverage.present ? voteAverage.value : this.voteAverage,
    voteCount: voteCount.present ? voteCount.value : this.voteCount,
  );
  NowPlayingMoviesTableData copyWithCompanion(
    NowPlayingMoviesTableCompanion data,
  ) {
    return NowPlayingMoviesTableData(
      id: data.id.present ? data.id.value : this.id,
      adult: data.adult.present ? data.adult.value : this.adult,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      overview: data.overview.present ? data.overview.value : this.overview,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      title: data.title.present ? data.title.value : this.title,
      video: data.video.present ? data.video.value : this.video,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NowPlayingMoviesTableData(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NowPlayingMoviesTableData &&
          other.id == this.id &&
          other.adult == this.adult &&
          other.backdropPath == this.backdropPath &&
          other.genreIds == this.genreIds &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.video == this.video &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount);
}

class NowPlayingMoviesTableCompanion
    extends UpdateCompanion<NowPlayingMoviesTableData> {
  final Value<int> id;
  final Value<bool?> adult;
  final Value<String?> backdropPath;
  final Value<String?> genreIds;
  final Value<String?> originalLanguage;
  final Value<String?> originalTitle;
  final Value<String?> overview;
  final Value<double?> popularity;
  final Value<String?> posterPath;
  final Value<String?> releaseDate;
  final Value<String?> title;
  final Value<bool?> video;
  final Value<double?> voteAverage;
  final Value<int?> voteCount;
  const NowPlayingMoviesTableCompanion({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  NowPlayingMoviesTableCompanion.insert({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  static Insertable<NowPlayingMoviesTableData> custom({
    Expression<int>? id,
    Expression<bool>? adult,
    Expression<String>? backdropPath,
    Expression<String>? genreIds,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<double>? popularity,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<String>? title,
    Expression<bool>? video,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (adult != null) 'adult': adult,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (genreIds != null) 'genre_ids': genreIds,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (video != null) 'video': video,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
    });
  }

  NowPlayingMoviesTableCompanion copyWith({
    Value<int>? id,
    Value<bool?>? adult,
    Value<String?>? backdropPath,
    Value<String?>? genreIds,
    Value<String?>? originalLanguage,
    Value<String?>? originalTitle,
    Value<String?>? overview,
    Value<double?>? popularity,
    Value<String?>? posterPath,
    Value<String?>? releaseDate,
    Value<String?>? title,
    Value<bool?>? video,
    Value<double?>? voteAverage,
    Value<int?>? voteCount,
  }) {
    return NowPlayingMoviesTableCompanion(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NowPlayingMoviesTableCompanion(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }
}

class $TopRatedMoviesTableTable extends TopRatedMoviesTable
    with TableInfo<$TopRatedMoviesTableTable, TopRatedMoviesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopRatedMoviesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
    'adult',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adult" IN (0, 1))',
    ),
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreIdsMeta = const VerificationMeta(
    'genreIds',
  );
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
    'genre_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalLanguageMeta = const VerificationMeta(
    'originalLanguage',
  );
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
    'original_language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
    'popularity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
    'video',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("video" IN (0, 1))',
    ),
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'top_rated_movies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopRatedMoviesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('adult')) {
      context.handle(
        _adultMeta,
        adult.isAcceptableOrUnknown(data['adult']!, _adultMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('genre_ids')) {
      context.handle(
        _genreIdsMeta,
        genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta),
      );
    }
    if (data.containsKey('original_language')) {
      context.handle(
        _originalLanguageMeta,
        originalLanguage.isAcceptableOrUnknown(
          data['original_language']!,
          _originalLanguageMeta,
        ),
      );
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('video')) {
      context.handle(
        _videoMeta,
        video.isAcceptableOrUnknown(data['video']!, _videoMeta),
      );
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopRatedMoviesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopRatedMoviesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      adult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adult'],
      ),
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      ),
      genreIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre_ids'],
      ),
      originalLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_language'],
      ),
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      ),
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity'],
      ),
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      video: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}video'],
      ),
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      ),
      voteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vote_count'],
      ),
    );
  }

  @override
  $TopRatedMoviesTableTable createAlias(String alias) {
    return $TopRatedMoviesTableTable(attachedDatabase, alias);
  }
}

class TopRatedMoviesTableData extends DataClass
    implements Insertable<TopRatedMoviesTableData> {
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  const TopRatedMoviesTableData({
    required this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || adult != null) {
      map['adult'] = Variable<bool>(adult);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || genreIds != null) {
      map['genre_ids'] = Variable<String>(genreIds);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<bool>(video);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double>(voteAverage);
    }
    if (!nullToAbsent || voteCount != null) {
      map['vote_count'] = Variable<int>(voteCount);
    }
    return map;
  }

  TopRatedMoviesTableCompanion toCompanion(bool nullToAbsent) {
    return TopRatedMoviesTableCompanion(
      id: Value(id),
      adult: adult == null && nullToAbsent
          ? const Value.absent()
          : Value(adult),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      genreIds: genreIds == null && nullToAbsent
          ? const Value.absent()
          : Value(genreIds),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      video: video == null && nullToAbsent
          ? const Value.absent()
          : Value(video),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      voteCount: voteCount == null && nullToAbsent
          ? const Value.absent()
          : Value(voteCount),
    );
  }

  factory TopRatedMoviesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopRatedMoviesTableData(
      id: serializer.fromJson<int>(json['id']),
      adult: serializer.fromJson<bool?>(json['adult']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      genreIds: serializer.fromJson<String?>(json['genreIds']),
      originalLanguage: serializer.fromJson<String?>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      overview: serializer.fromJson<String?>(json['overview']),
      popularity: serializer.fromJson<double?>(json['popularity']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      title: serializer.fromJson<String?>(json['title']),
      video: serializer.fromJson<bool?>(json['video']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      voteCount: serializer.fromJson<int?>(json['voteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'adult': serializer.toJson<bool?>(adult),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'genreIds': serializer.toJson<String?>(genreIds),
      'originalLanguage': serializer.toJson<String?>(originalLanguage),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'overview': serializer.toJson<String?>(overview),
      'popularity': serializer.toJson<double?>(popularity),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'title': serializer.toJson<String?>(title),
      'video': serializer.toJson<bool?>(video),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'voteCount': serializer.toJson<int?>(voteCount),
    };
  }

  TopRatedMoviesTableData copyWith({
    int? id,
    Value<bool?> adult = const Value.absent(),
    Value<String?> backdropPath = const Value.absent(),
    Value<String?> genreIds = const Value.absent(),
    Value<String?> originalLanguage = const Value.absent(),
    Value<String?> originalTitle = const Value.absent(),
    Value<String?> overview = const Value.absent(),
    Value<double?> popularity = const Value.absent(),
    Value<String?> posterPath = const Value.absent(),
    Value<String?> releaseDate = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<bool?> video = const Value.absent(),
    Value<double?> voteAverage = const Value.absent(),
    Value<int?> voteCount = const Value.absent(),
  }) => TopRatedMoviesTableData(
    id: id ?? this.id,
    adult: adult.present ? adult.value : this.adult,
    backdropPath: backdropPath.present ? backdropPath.value : this.backdropPath,
    genreIds: genreIds.present ? genreIds.value : this.genreIds,
    originalLanguage: originalLanguage.present
        ? originalLanguage.value
        : this.originalLanguage,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    overview: overview.present ? overview.value : this.overview,
    popularity: popularity.present ? popularity.value : this.popularity,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    title: title.present ? title.value : this.title,
    video: video.present ? video.value : this.video,
    voteAverage: voteAverage.present ? voteAverage.value : this.voteAverage,
    voteCount: voteCount.present ? voteCount.value : this.voteCount,
  );
  TopRatedMoviesTableData copyWithCompanion(TopRatedMoviesTableCompanion data) {
    return TopRatedMoviesTableData(
      id: data.id.present ? data.id.value : this.id,
      adult: data.adult.present ? data.adult.value : this.adult,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      overview: data.overview.present ? data.overview.value : this.overview,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      title: data.title.present ? data.title.value : this.title,
      video: data.video.present ? data.video.value : this.video,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopRatedMoviesTableData(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopRatedMoviesTableData &&
          other.id == this.id &&
          other.adult == this.adult &&
          other.backdropPath == this.backdropPath &&
          other.genreIds == this.genreIds &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.video == this.video &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount);
}

class TopRatedMoviesTableCompanion
    extends UpdateCompanion<TopRatedMoviesTableData> {
  final Value<int> id;
  final Value<bool?> adult;
  final Value<String?> backdropPath;
  final Value<String?> genreIds;
  final Value<String?> originalLanguage;
  final Value<String?> originalTitle;
  final Value<String?> overview;
  final Value<double?> popularity;
  final Value<String?> posterPath;
  final Value<String?> releaseDate;
  final Value<String?> title;
  final Value<bool?> video;
  final Value<double?> voteAverage;
  final Value<int?> voteCount;
  const TopRatedMoviesTableCompanion({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  TopRatedMoviesTableCompanion.insert({
    this.id = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
  });
  static Insertable<TopRatedMoviesTableData> custom({
    Expression<int>? id,
    Expression<bool>? adult,
    Expression<String>? backdropPath,
    Expression<String>? genreIds,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<double>? popularity,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<String>? title,
    Expression<bool>? video,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (adult != null) 'adult': adult,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (genreIds != null) 'genre_ids': genreIds,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (video != null) 'video': video,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
    });
  }

  TopRatedMoviesTableCompanion copyWith({
    Value<int>? id,
    Value<bool?>? adult,
    Value<String?>? backdropPath,
    Value<String?>? genreIds,
    Value<String?>? originalLanguage,
    Value<String?>? originalTitle,
    Value<String?>? overview,
    Value<double?>? popularity,
    Value<String?>? posterPath,
    Value<String?>? releaseDate,
    Value<String?>? title,
    Value<bool?>? video,
    Value<double?>? voteAverage,
    Value<int?>? voteCount,
  }) {
    return TopRatedMoviesTableCompanion(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopRatedMoviesTableCompanion(')
          ..write('id: $id, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }
}

class $GenresTableTable extends GenresTable
    with TableInfo<$GenresTableTable, GenresTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenresTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genres_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GenresTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GenresTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenresTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
    );
  }

  @override
  $GenresTableTable createAlias(String alias) {
    return $GenresTableTable(attachedDatabase, alias);
  }
}

class GenresTableData extends DataClass implements Insertable<GenresTableData> {
  final int id;
  final String? name;
  const GenresTableData({required this.id, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  GenresTableCompanion toCompanion(bool nullToAbsent) {
    return GenresTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory GenresTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenresTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
    };
  }

  GenresTableData copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
  }) => GenresTableData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
  );
  GenresTableData copyWithCompanion(GenresTableCompanion data) {
    return GenresTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GenresTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenresTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class GenresTableCompanion extends UpdateCompanion<GenresTableData> {
  final Value<int> id;
  final Value<String?> name;
  const GenresTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  GenresTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<GenresTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  GenresTableCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return GenresTableCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenresTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $MoviesByGenreTableTable extends MoviesByGenreTable
    with TableInfo<$MoviesByGenreTableTable, MoviesByGenreTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesByGenreTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _genreIdMeta = const VerificationMeta(
    'genreId',
  );
  @override
  late final GeneratedColumn<int> genreId = GeneratedColumn<int>(
    'genre_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movieIdMeta = const VerificationMeta(
    'movieId',
  );
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
    'movie_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
    'adult',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adult" IN (0, 1))',
    ),
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genreIdsMeta = const VerificationMeta(
    'genreIds',
  );
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
    'genre_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalLanguageMeta = const VerificationMeta(
    'originalLanguage',
  );
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
    'original_language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
    'popularity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<bool> video = GeneratedColumn<bool>(
    'video',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("video" IN (0, 1))',
    ),
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    genreId,
    movieId,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies_by_genre_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoviesByGenreTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('genre_id')) {
      context.handle(
        _genreIdMeta,
        genreId.isAcceptableOrUnknown(data['genre_id']!, _genreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_genreIdMeta);
    }
    if (data.containsKey('movie_id')) {
      context.handle(
        _movieIdMeta,
        movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta),
      );
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    if (data.containsKey('adult')) {
      context.handle(
        _adultMeta,
        adult.isAcceptableOrUnknown(data['adult']!, _adultMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('genre_ids')) {
      context.handle(
        _genreIdsMeta,
        genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta),
      );
    }
    if (data.containsKey('original_language')) {
      context.handle(
        _originalLanguageMeta,
        originalLanguage.isAcceptableOrUnknown(
          data['original_language']!,
          _originalLanguageMeta,
        ),
      );
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('video')) {
      context.handle(
        _videoMeta,
        video.isAcceptableOrUnknown(data['video']!, _videoMeta),
      );
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {genreId, movieId};
  @override
  MoviesByGenreTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoviesByGenreTableData(
      genreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}genre_id'],
      )!,
      movieId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}movie_id'],
      )!,
      adult: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adult'],
      ),
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      ),
      genreIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre_ids'],
      ),
      originalLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_language'],
      ),
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      ),
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity'],
      ),
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      video: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}video'],
      ),
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      ),
      voteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vote_count'],
      ),
    );
  }

  @override
  $MoviesByGenreTableTable createAlias(String alias) {
    return $MoviesByGenreTableTable(attachedDatabase, alias);
  }
}

class MoviesByGenreTableData extends DataClass
    implements Insertable<MoviesByGenreTableData> {
  final int genreId;
  final int movieId;
  final bool? adult;
  final String? backdropPath;
  final String? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  const MoviesByGenreTableData({
    required this.genreId,
    required this.movieId,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['genre_id'] = Variable<int>(genreId);
    map['movie_id'] = Variable<int>(movieId);
    if (!nullToAbsent || adult != null) {
      map['adult'] = Variable<bool>(adult);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || genreIds != null) {
      map['genre_ids'] = Variable<String>(genreIds);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<bool>(video);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double>(voteAverage);
    }
    if (!nullToAbsent || voteCount != null) {
      map['vote_count'] = Variable<int>(voteCount);
    }
    return map;
  }

  MoviesByGenreTableCompanion toCompanion(bool nullToAbsent) {
    return MoviesByGenreTableCompanion(
      genreId: Value(genreId),
      movieId: Value(movieId),
      adult: adult == null && nullToAbsent
          ? const Value.absent()
          : Value(adult),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      genreIds: genreIds == null && nullToAbsent
          ? const Value.absent()
          : Value(genreIds),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      video: video == null && nullToAbsent
          ? const Value.absent()
          : Value(video),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      voteCount: voteCount == null && nullToAbsent
          ? const Value.absent()
          : Value(voteCount),
    );
  }

  factory MoviesByGenreTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoviesByGenreTableData(
      genreId: serializer.fromJson<int>(json['genreId']),
      movieId: serializer.fromJson<int>(json['movieId']),
      adult: serializer.fromJson<bool?>(json['adult']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      genreIds: serializer.fromJson<String?>(json['genreIds']),
      originalLanguage: serializer.fromJson<String?>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      overview: serializer.fromJson<String?>(json['overview']),
      popularity: serializer.fromJson<double?>(json['popularity']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      title: serializer.fromJson<String?>(json['title']),
      video: serializer.fromJson<bool?>(json['video']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      voteCount: serializer.fromJson<int?>(json['voteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'genreId': serializer.toJson<int>(genreId),
      'movieId': serializer.toJson<int>(movieId),
      'adult': serializer.toJson<bool?>(adult),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'genreIds': serializer.toJson<String?>(genreIds),
      'originalLanguage': serializer.toJson<String?>(originalLanguage),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'overview': serializer.toJson<String?>(overview),
      'popularity': serializer.toJson<double?>(popularity),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'title': serializer.toJson<String?>(title),
      'video': serializer.toJson<bool?>(video),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'voteCount': serializer.toJson<int?>(voteCount),
    };
  }

  MoviesByGenreTableData copyWith({
    int? genreId,
    int? movieId,
    Value<bool?> adult = const Value.absent(),
    Value<String?> backdropPath = const Value.absent(),
    Value<String?> genreIds = const Value.absent(),
    Value<String?> originalLanguage = const Value.absent(),
    Value<String?> originalTitle = const Value.absent(),
    Value<String?> overview = const Value.absent(),
    Value<double?> popularity = const Value.absent(),
    Value<String?> posterPath = const Value.absent(),
    Value<String?> releaseDate = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<bool?> video = const Value.absent(),
    Value<double?> voteAverage = const Value.absent(),
    Value<int?> voteCount = const Value.absent(),
  }) => MoviesByGenreTableData(
    genreId: genreId ?? this.genreId,
    movieId: movieId ?? this.movieId,
    adult: adult.present ? adult.value : this.adult,
    backdropPath: backdropPath.present ? backdropPath.value : this.backdropPath,
    genreIds: genreIds.present ? genreIds.value : this.genreIds,
    originalLanguage: originalLanguage.present
        ? originalLanguage.value
        : this.originalLanguage,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    overview: overview.present ? overview.value : this.overview,
    popularity: popularity.present ? popularity.value : this.popularity,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    title: title.present ? title.value : this.title,
    video: video.present ? video.value : this.video,
    voteAverage: voteAverage.present ? voteAverage.value : this.voteAverage,
    voteCount: voteCount.present ? voteCount.value : this.voteCount,
  );
  MoviesByGenreTableData copyWithCompanion(MoviesByGenreTableCompanion data) {
    return MoviesByGenreTableData(
      genreId: data.genreId.present ? data.genreId.value : this.genreId,
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      adult: data.adult.present ? data.adult.value : this.adult,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      overview: data.overview.present ? data.overview.value : this.overview,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      title: data.title.present ? data.title.value : this.title,
      video: data.video.present ? data.video.value : this.video,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoviesByGenreTableData(')
          ..write('genreId: $genreId, ')
          ..write('movieId: $movieId, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    genreId,
    movieId,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoviesByGenreTableData &&
          other.genreId == this.genreId &&
          other.movieId == this.movieId &&
          other.adult == this.adult &&
          other.backdropPath == this.backdropPath &&
          other.genreIds == this.genreIds &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.video == this.video &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount);
}

class MoviesByGenreTableCompanion
    extends UpdateCompanion<MoviesByGenreTableData> {
  final Value<int> genreId;
  final Value<int> movieId;
  final Value<bool?> adult;
  final Value<String?> backdropPath;
  final Value<String?> genreIds;
  final Value<String?> originalLanguage;
  final Value<String?> originalTitle;
  final Value<String?> overview;
  final Value<double?> popularity;
  final Value<String?> posterPath;
  final Value<String?> releaseDate;
  final Value<String?> title;
  final Value<bool?> video;
  final Value<double?> voteAverage;
  final Value<int?> voteCount;
  final Value<int> rowid;
  const MoviesByGenreTableCompanion({
    this.genreId = const Value.absent(),
    this.movieId = const Value.absent(),
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MoviesByGenreTableCompanion.insert({
    required int genreId,
    required int movieId,
    this.adult = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : genreId = Value(genreId),
       movieId = Value(movieId);
  static Insertable<MoviesByGenreTableData> custom({
    Expression<int>? genreId,
    Expression<int>? movieId,
    Expression<bool>? adult,
    Expression<String>? backdropPath,
    Expression<String>? genreIds,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<double>? popularity,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<String>? title,
    Expression<bool>? video,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (genreId != null) 'genre_id': genreId,
      if (movieId != null) 'movie_id': movieId,
      if (adult != null) 'adult': adult,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (genreIds != null) 'genre_ids': genreIds,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (video != null) 'video': video,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MoviesByGenreTableCompanion copyWith({
    Value<int>? genreId,
    Value<int>? movieId,
    Value<bool?>? adult,
    Value<String?>? backdropPath,
    Value<String?>? genreIds,
    Value<String?>? originalLanguage,
    Value<String?>? originalTitle,
    Value<String?>? overview,
    Value<double?>? popularity,
    Value<String?>? posterPath,
    Value<String?>? releaseDate,
    Value<String?>? title,
    Value<bool?>? video,
    Value<double?>? voteAverage,
    Value<int?>? voteCount,
    Value<int>? rowid,
  }) {
    return MoviesByGenreTableCompanion(
      genreId: genreId ?? this.genreId,
      movieId: movieId ?? this.movieId,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (genreId.present) {
      map['genre_id'] = Variable<int>(genreId.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesByGenreTableCompanion(')
          ..write('genreId: $genreId, ')
          ..write('movieId: $movieId, ')
          ..write('adult: $adult, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genreIds: $genreIds, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PopularMoviesTableTable popularMoviesTable =
      $PopularMoviesTableTable(this);
  late final $NowPlayingMoviesTableTable nowPlayingMoviesTable =
      $NowPlayingMoviesTableTable(this);
  late final $TopRatedMoviesTableTable topRatedMoviesTable =
      $TopRatedMoviesTableTable(this);
  late final $GenresTableTable genresTable = $GenresTableTable(this);
  late final $MoviesByGenreTableTable moviesByGenreTable =
      $MoviesByGenreTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    popularMoviesTable,
    nowPlayingMoviesTable,
    topRatedMoviesTable,
    genresTable,
    moviesByGenreTable,
  ];
}

typedef $$PopularMoviesTableTableCreateCompanionBuilder =
    PopularMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });
typedef $$PopularMoviesTableTableUpdateCompanionBuilder =
    PopularMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });

class $$PopularMoviesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PopularMoviesTableTable> {
  $$PopularMoviesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PopularMoviesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PopularMoviesTableTable> {
  $$PopularMoviesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PopularMoviesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PopularMoviesTableTable> {
  $$PopularMoviesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);
}

class $$PopularMoviesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PopularMoviesTableTable,
          PopularMoviesTableData,
          $$PopularMoviesTableTableFilterComposer,
          $$PopularMoviesTableTableOrderingComposer,
          $$PopularMoviesTableTableAnnotationComposer,
          $$PopularMoviesTableTableCreateCompanionBuilder,
          $$PopularMoviesTableTableUpdateCompanionBuilder,
          (
            PopularMoviesTableData,
            BaseReferences<
              _$AppDatabase,
              $PopularMoviesTableTable,
              PopularMoviesTableData
            >,
          ),
          PopularMoviesTableData,
          PrefetchHooks Function()
        > {
  $$PopularMoviesTableTableTableManager(
    _$AppDatabase db,
    $PopularMoviesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PopularMoviesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PopularMoviesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PopularMoviesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => PopularMoviesTableCompanion(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => PopularMoviesTableCompanion.insert(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PopularMoviesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PopularMoviesTableTable,
      PopularMoviesTableData,
      $$PopularMoviesTableTableFilterComposer,
      $$PopularMoviesTableTableOrderingComposer,
      $$PopularMoviesTableTableAnnotationComposer,
      $$PopularMoviesTableTableCreateCompanionBuilder,
      $$PopularMoviesTableTableUpdateCompanionBuilder,
      (
        PopularMoviesTableData,
        BaseReferences<
          _$AppDatabase,
          $PopularMoviesTableTable,
          PopularMoviesTableData
        >,
      ),
      PopularMoviesTableData,
      PrefetchHooks Function()
    >;
typedef $$NowPlayingMoviesTableTableCreateCompanionBuilder =
    NowPlayingMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });
typedef $$NowPlayingMoviesTableTableUpdateCompanionBuilder =
    NowPlayingMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });

class $$NowPlayingMoviesTableTableFilterComposer
    extends Composer<_$AppDatabase, $NowPlayingMoviesTableTable> {
  $$NowPlayingMoviesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NowPlayingMoviesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NowPlayingMoviesTableTable> {
  $$NowPlayingMoviesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NowPlayingMoviesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NowPlayingMoviesTableTable> {
  $$NowPlayingMoviesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);
}

class $$NowPlayingMoviesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NowPlayingMoviesTableTable,
          NowPlayingMoviesTableData,
          $$NowPlayingMoviesTableTableFilterComposer,
          $$NowPlayingMoviesTableTableOrderingComposer,
          $$NowPlayingMoviesTableTableAnnotationComposer,
          $$NowPlayingMoviesTableTableCreateCompanionBuilder,
          $$NowPlayingMoviesTableTableUpdateCompanionBuilder,
          (
            NowPlayingMoviesTableData,
            BaseReferences<
              _$AppDatabase,
              $NowPlayingMoviesTableTable,
              NowPlayingMoviesTableData
            >,
          ),
          NowPlayingMoviesTableData,
          PrefetchHooks Function()
        > {
  $$NowPlayingMoviesTableTableTableManager(
    _$AppDatabase db,
    $NowPlayingMoviesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NowPlayingMoviesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NowPlayingMoviesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NowPlayingMoviesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => NowPlayingMoviesTableCompanion(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => NowPlayingMoviesTableCompanion.insert(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NowPlayingMoviesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NowPlayingMoviesTableTable,
      NowPlayingMoviesTableData,
      $$NowPlayingMoviesTableTableFilterComposer,
      $$NowPlayingMoviesTableTableOrderingComposer,
      $$NowPlayingMoviesTableTableAnnotationComposer,
      $$NowPlayingMoviesTableTableCreateCompanionBuilder,
      $$NowPlayingMoviesTableTableUpdateCompanionBuilder,
      (
        NowPlayingMoviesTableData,
        BaseReferences<
          _$AppDatabase,
          $NowPlayingMoviesTableTable,
          NowPlayingMoviesTableData
        >,
      ),
      NowPlayingMoviesTableData,
      PrefetchHooks Function()
    >;
typedef $$TopRatedMoviesTableTableCreateCompanionBuilder =
    TopRatedMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });
typedef $$TopRatedMoviesTableTableUpdateCompanionBuilder =
    TopRatedMoviesTableCompanion Function({
      Value<int> id,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
    });

class $$TopRatedMoviesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TopRatedMoviesTableTable> {
  $$TopRatedMoviesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TopRatedMoviesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TopRatedMoviesTableTable> {
  $$TopRatedMoviesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopRatedMoviesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopRatedMoviesTableTable> {
  $$TopRatedMoviesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);
}

class $$TopRatedMoviesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopRatedMoviesTableTable,
          TopRatedMoviesTableData,
          $$TopRatedMoviesTableTableFilterComposer,
          $$TopRatedMoviesTableTableOrderingComposer,
          $$TopRatedMoviesTableTableAnnotationComposer,
          $$TopRatedMoviesTableTableCreateCompanionBuilder,
          $$TopRatedMoviesTableTableUpdateCompanionBuilder,
          (
            TopRatedMoviesTableData,
            BaseReferences<
              _$AppDatabase,
              $TopRatedMoviesTableTable,
              TopRatedMoviesTableData
            >,
          ),
          TopRatedMoviesTableData,
          PrefetchHooks Function()
        > {
  $$TopRatedMoviesTableTableTableManager(
    _$AppDatabase db,
    $TopRatedMoviesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopRatedMoviesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopRatedMoviesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TopRatedMoviesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => TopRatedMoviesTableCompanion(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
              }) => TopRatedMoviesTableCompanion.insert(
                id: id,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TopRatedMoviesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopRatedMoviesTableTable,
      TopRatedMoviesTableData,
      $$TopRatedMoviesTableTableFilterComposer,
      $$TopRatedMoviesTableTableOrderingComposer,
      $$TopRatedMoviesTableTableAnnotationComposer,
      $$TopRatedMoviesTableTableCreateCompanionBuilder,
      $$TopRatedMoviesTableTableUpdateCompanionBuilder,
      (
        TopRatedMoviesTableData,
        BaseReferences<
          _$AppDatabase,
          $TopRatedMoviesTableTable,
          TopRatedMoviesTableData
        >,
      ),
      TopRatedMoviesTableData,
      PrefetchHooks Function()
    >;
typedef $$GenresTableTableCreateCompanionBuilder =
    GenresTableCompanion Function({Value<int> id, Value<String?> name});
typedef $$GenresTableTableUpdateCompanionBuilder =
    GenresTableCompanion Function({Value<int> id, Value<String?> name});

class $$GenresTableTableFilterComposer
    extends Composer<_$AppDatabase, $GenresTableTable> {
  $$GenresTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GenresTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GenresTableTable> {
  $$GenresTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GenresTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenresTableTable> {
  $$GenresTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$GenresTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GenresTableTable,
          GenresTableData,
          $$GenresTableTableFilterComposer,
          $$GenresTableTableOrderingComposer,
          $$GenresTableTableAnnotationComposer,
          $$GenresTableTableCreateCompanionBuilder,
          $$GenresTableTableUpdateCompanionBuilder,
          (
            GenresTableData,
            BaseReferences<_$AppDatabase, $GenresTableTable, GenresTableData>,
          ),
          GenresTableData,
          PrefetchHooks Function()
        > {
  $$GenresTableTableTableManager(_$AppDatabase db, $GenresTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenresTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenresTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenresTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
              }) => GenresTableCompanion(id: id, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
              }) => GenresTableCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GenresTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GenresTableTable,
      GenresTableData,
      $$GenresTableTableFilterComposer,
      $$GenresTableTableOrderingComposer,
      $$GenresTableTableAnnotationComposer,
      $$GenresTableTableCreateCompanionBuilder,
      $$GenresTableTableUpdateCompanionBuilder,
      (
        GenresTableData,
        BaseReferences<_$AppDatabase, $GenresTableTable, GenresTableData>,
      ),
      GenresTableData,
      PrefetchHooks Function()
    >;
typedef $$MoviesByGenreTableTableCreateCompanionBuilder =
    MoviesByGenreTableCompanion Function({
      required int genreId,
      required int movieId,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
      Value<int> rowid,
    });
typedef $$MoviesByGenreTableTableUpdateCompanionBuilder =
    MoviesByGenreTableCompanion Function({
      Value<int> genreId,
      Value<int> movieId,
      Value<bool?> adult,
      Value<String?> backdropPath,
      Value<String?> genreIds,
      Value<String?> originalLanguage,
      Value<String?> originalTitle,
      Value<String?> overview,
      Value<double?> popularity,
      Value<String?> posterPath,
      Value<String?> releaseDate,
      Value<String?> title,
      Value<bool?> video,
      Value<double?> voteAverage,
      Value<int?> voteCount,
      Value<int> rowid,
    });

class $$MoviesByGenreTableTableFilterComposer
    extends Composer<_$AppDatabase, $MoviesByGenreTableTable> {
  $$MoviesByGenreTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get genreId => $composableBuilder(
    column: $table.genreId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MoviesByGenreTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MoviesByGenreTableTable> {
  $$MoviesByGenreTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get genreId => $composableBuilder(
    column: $table.genreId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adult => $composableBuilder(
    column: $table.adult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genreIds => $composableBuilder(
    column: $table.genreIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get video => $composableBuilder(
    column: $table.video,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoviesByGenreTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoviesByGenreTableTable> {
  $$MoviesByGenreTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get genreId =>
      $composableBuilder(column: $table.genreId, builder: (column) => column);

  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
    column: $table.originalLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);
}

class $$MoviesByGenreTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MoviesByGenreTableTable,
          MoviesByGenreTableData,
          $$MoviesByGenreTableTableFilterComposer,
          $$MoviesByGenreTableTableOrderingComposer,
          $$MoviesByGenreTableTableAnnotationComposer,
          $$MoviesByGenreTableTableCreateCompanionBuilder,
          $$MoviesByGenreTableTableUpdateCompanionBuilder,
          (
            MoviesByGenreTableData,
            BaseReferences<
              _$AppDatabase,
              $MoviesByGenreTableTable,
              MoviesByGenreTableData
            >,
          ),
          MoviesByGenreTableData,
          PrefetchHooks Function()
        > {
  $$MoviesByGenreTableTableTableManager(
    _$AppDatabase db,
    $MoviesByGenreTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoviesByGenreTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoviesByGenreTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoviesByGenreTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> genreId = const Value.absent(),
                Value<int> movieId = const Value.absent(),
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MoviesByGenreTableCompanion(
                genreId: genreId,
                movieId: movieId,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int genreId,
                required int movieId,
                Value<bool?> adult = const Value.absent(),
                Value<String?> backdropPath = const Value.absent(),
                Value<String?> genreIds = const Value.absent(),
                Value<String?> originalLanguage = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<String?> overview = const Value.absent(),
                Value<double?> popularity = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool?> video = const Value.absent(),
                Value<double?> voteAverage = const Value.absent(),
                Value<int?> voteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MoviesByGenreTableCompanion.insert(
                genreId: genreId,
                movieId: movieId,
                adult: adult,
                backdropPath: backdropPath,
                genreIds: genreIds,
                originalLanguage: originalLanguage,
                originalTitle: originalTitle,
                overview: overview,
                popularity: popularity,
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                video: video,
                voteAverage: voteAverage,
                voteCount: voteCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoviesByGenreTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MoviesByGenreTableTable,
      MoviesByGenreTableData,
      $$MoviesByGenreTableTableFilterComposer,
      $$MoviesByGenreTableTableOrderingComposer,
      $$MoviesByGenreTableTableAnnotationComposer,
      $$MoviesByGenreTableTableCreateCompanionBuilder,
      $$MoviesByGenreTableTableUpdateCompanionBuilder,
      (
        MoviesByGenreTableData,
        BaseReferences<
          _$AppDatabase,
          $MoviesByGenreTableTable,
          MoviesByGenreTableData
        >,
      ),
      MoviesByGenreTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PopularMoviesTableTableTableManager get popularMoviesTable =>
      $$PopularMoviesTableTableTableManager(_db, _db.popularMoviesTable);
  $$NowPlayingMoviesTableTableTableManager get nowPlayingMoviesTable =>
      $$NowPlayingMoviesTableTableTableManager(_db, _db.nowPlayingMoviesTable);
  $$TopRatedMoviesTableTableTableManager get topRatedMoviesTable =>
      $$TopRatedMoviesTableTableTableManager(_db, _db.topRatedMoviesTable);
  $$GenresTableTableTableManager get genresTable =>
      $$GenresTableTableTableManager(_db, _db.genresTable);
  $$MoviesByGenreTableTableTableManager get moviesByGenreTable =>
      $$MoviesByGenreTableTableTableManager(_db, _db.moviesByGenreTable);
}
