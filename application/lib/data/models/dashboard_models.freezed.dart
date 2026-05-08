// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) {
  return _DashboardStats.fromJson(json);
}

/// @nodoc
mixin _$DashboardStats {
  @JsonKey(name: 'total_threats')
  int get totalThreats => throw _privateConstructorUsedError;
  @JsonKey(name: 'phishing_attempts')
  int get phishingAttempts => throw _privateConstructorUsedError;
  @JsonKey(name: 'high_risk_alerts')
  int get highRiskAlerts => throw _privateConstructorUsedError;
  @JsonKey(name: 'critical_alerts')
  int get criticalAlerts => throw _privateConstructorUsedError;
  @JsonKey(name: 'threats_today')
  int get threatsToday => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_risk_score')
  double get avgRiskScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'unacknowledged_alerts')
  int get unacknowledgedAlerts => throw _privateConstructorUsedError;

  /// Serializes this DashboardStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStatsCopyWith<DashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsCopyWith<$Res> {
  factory $DashboardStatsCopyWith(
          DashboardStats value, $Res Function(DashboardStats) then) =
      _$DashboardStatsCopyWithImpl<$Res, DashboardStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_threats') int totalThreats,
      @JsonKey(name: 'phishing_attempts') int phishingAttempts,
      @JsonKey(name: 'high_risk_alerts') int highRiskAlerts,
      @JsonKey(name: 'critical_alerts') int criticalAlerts,
      @JsonKey(name: 'threats_today') int threatsToday,
      @JsonKey(name: 'avg_risk_score') double avgRiskScore,
      @JsonKey(name: 'unacknowledged_alerts') int unacknowledgedAlerts});
}

/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res, $Val extends DashboardStats>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalThreats = null,
    Object? phishingAttempts = null,
    Object? highRiskAlerts = null,
    Object? criticalAlerts = null,
    Object? threatsToday = null,
    Object? avgRiskScore = null,
    Object? unacknowledgedAlerts = null,
  }) {
    return _then(_value.copyWith(
      totalThreats: null == totalThreats
          ? _value.totalThreats
          : totalThreats // ignore: cast_nullable_to_non_nullable
              as int,
      phishingAttempts: null == phishingAttempts
          ? _value.phishingAttempts
          : phishingAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      highRiskAlerts: null == highRiskAlerts
          ? _value.highRiskAlerts
          : highRiskAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      criticalAlerts: null == criticalAlerts
          ? _value.criticalAlerts
          : criticalAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      threatsToday: null == threatsToday
          ? _value.threatsToday
          : threatsToday // ignore: cast_nullable_to_non_nullable
              as int,
      avgRiskScore: null == avgRiskScore
          ? _value.avgRiskScore
          : avgRiskScore // ignore: cast_nullable_to_non_nullable
              as double,
      unacknowledgedAlerts: null == unacknowledgedAlerts
          ? _value.unacknowledgedAlerts
          : unacknowledgedAlerts // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStatsImplCopyWith<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  factory _$$DashboardStatsImplCopyWith(_$DashboardStatsImpl value,
          $Res Function(_$DashboardStatsImpl) then) =
      __$$DashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_threats') int totalThreats,
      @JsonKey(name: 'phishing_attempts') int phishingAttempts,
      @JsonKey(name: 'high_risk_alerts') int highRiskAlerts,
      @JsonKey(name: 'critical_alerts') int criticalAlerts,
      @JsonKey(name: 'threats_today') int threatsToday,
      @JsonKey(name: 'avg_risk_score') double avgRiskScore,
      @JsonKey(name: 'unacknowledged_alerts') int unacknowledgedAlerts});
}

/// @nodoc
class __$$DashboardStatsImplCopyWithImpl<$Res>
    extends _$DashboardStatsCopyWithImpl<$Res, _$DashboardStatsImpl>
    implements _$$DashboardStatsImplCopyWith<$Res> {
  __$$DashboardStatsImplCopyWithImpl(
      _$DashboardStatsImpl _value, $Res Function(_$DashboardStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalThreats = null,
    Object? phishingAttempts = null,
    Object? highRiskAlerts = null,
    Object? criticalAlerts = null,
    Object? threatsToday = null,
    Object? avgRiskScore = null,
    Object? unacknowledgedAlerts = null,
  }) {
    return _then(_$DashboardStatsImpl(
      totalThreats: null == totalThreats
          ? _value.totalThreats
          : totalThreats // ignore: cast_nullable_to_non_nullable
              as int,
      phishingAttempts: null == phishingAttempts
          ? _value.phishingAttempts
          : phishingAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      highRiskAlerts: null == highRiskAlerts
          ? _value.highRiskAlerts
          : highRiskAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      criticalAlerts: null == criticalAlerts
          ? _value.criticalAlerts
          : criticalAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      threatsToday: null == threatsToday
          ? _value.threatsToday
          : threatsToday // ignore: cast_nullable_to_non_nullable
              as int,
      avgRiskScore: null == avgRiskScore
          ? _value.avgRiskScore
          : avgRiskScore // ignore: cast_nullable_to_non_nullable
              as double,
      unacknowledgedAlerts: null == unacknowledgedAlerts
          ? _value.unacknowledgedAlerts
          : unacknowledgedAlerts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardStatsImpl implements _DashboardStats {
  const _$DashboardStatsImpl(
      {@JsonKey(name: 'total_threats') required this.totalThreats,
      @JsonKey(name: 'phishing_attempts') required this.phishingAttempts,
      @JsonKey(name: 'high_risk_alerts') required this.highRiskAlerts,
      @JsonKey(name: 'critical_alerts') required this.criticalAlerts,
      @JsonKey(name: 'threats_today') required this.threatsToday,
      @JsonKey(name: 'avg_risk_score') required this.avgRiskScore,
      @JsonKey(name: 'unacknowledged_alerts')
      required this.unacknowledgedAlerts});

  factory _$DashboardStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_threats')
  final int totalThreats;
  @override
  @JsonKey(name: 'phishing_attempts')
  final int phishingAttempts;
  @override
  @JsonKey(name: 'high_risk_alerts')
  final int highRiskAlerts;
  @override
  @JsonKey(name: 'critical_alerts')
  final int criticalAlerts;
  @override
  @JsonKey(name: 'threats_today')
  final int threatsToday;
  @override
  @JsonKey(name: 'avg_risk_score')
  final double avgRiskScore;
  @override
  @JsonKey(name: 'unacknowledged_alerts')
  final int unacknowledgedAlerts;

  @override
  String toString() {
    return 'DashboardStats(totalThreats: $totalThreats, phishingAttempts: $phishingAttempts, highRiskAlerts: $highRiskAlerts, criticalAlerts: $criticalAlerts, threatsToday: $threatsToday, avgRiskScore: $avgRiskScore, unacknowledgedAlerts: $unacknowledgedAlerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsImpl &&
            (identical(other.totalThreats, totalThreats) ||
                other.totalThreats == totalThreats) &&
            (identical(other.phishingAttempts, phishingAttempts) ||
                other.phishingAttempts == phishingAttempts) &&
            (identical(other.highRiskAlerts, highRiskAlerts) ||
                other.highRiskAlerts == highRiskAlerts) &&
            (identical(other.criticalAlerts, criticalAlerts) ||
                other.criticalAlerts == criticalAlerts) &&
            (identical(other.threatsToday, threatsToday) ||
                other.threatsToday == threatsToday) &&
            (identical(other.avgRiskScore, avgRiskScore) ||
                other.avgRiskScore == avgRiskScore) &&
            (identical(other.unacknowledgedAlerts, unacknowledgedAlerts) ||
                other.unacknowledgedAlerts == unacknowledgedAlerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalThreats,
      phishingAttempts,
      highRiskAlerts,
      criticalAlerts,
      threatsToday,
      avgRiskScore,
      unacknowledgedAlerts);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      __$$DashboardStatsImplCopyWithImpl<_$DashboardStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardStatsImplToJson(
      this,
    );
  }
}

abstract class _DashboardStats implements DashboardStats {
  const factory _DashboardStats(
      {@JsonKey(name: 'total_threats') required final int totalThreats,
      @JsonKey(name: 'phishing_attempts') required final int phishingAttempts,
      @JsonKey(name: 'high_risk_alerts') required final int highRiskAlerts,
      @JsonKey(name: 'critical_alerts') required final int criticalAlerts,
      @JsonKey(name: 'threats_today') required final int threatsToday,
      @JsonKey(name: 'avg_risk_score') required final double avgRiskScore,
      @JsonKey(name: 'unacknowledged_alerts')
      required final int unacknowledgedAlerts}) = _$DashboardStatsImpl;

  factory _DashboardStats.fromJson(Map<String, dynamic> json) =
      _$DashboardStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_threats')
  int get totalThreats;
  @override
  @JsonKey(name: 'phishing_attempts')
  int get phishingAttempts;
  @override
  @JsonKey(name: 'high_risk_alerts')
  int get highRiskAlerts;
  @override
  @JsonKey(name: 'critical_alerts')
  int get criticalAlerts;
  @override
  @JsonKey(name: 'threats_today')
  int get threatsToday;
  @override
  @JsonKey(name: 'avg_risk_score')
  double get avgRiskScore;
  @override
  @JsonKey(name: 'unacknowledged_alerts')
  int get unacknowledgedAlerts;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThreatTrend _$ThreatTrendFromJson(Map<String, dynamic> json) {
  return _ThreatTrend.fromJson(json);
}

/// @nodoc
mixin _$ThreatTrend {
  String get date => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_risk_score')
  double get avgRiskScore => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;

  /// Serializes this ThreatTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreatTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreatTrendCopyWith<ThreatTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreatTrendCopyWith<$Res> {
  factory $ThreatTrendCopyWith(
          ThreatTrend value, $Res Function(ThreatTrend) then) =
      _$ThreatTrendCopyWithImpl<$Res, ThreatTrend>;
  @useResult
  $Res call(
      {String date,
      int count,
      @JsonKey(name: 'avg_risk_score') double avgRiskScore,
      String channel});
}

/// @nodoc
class _$ThreatTrendCopyWithImpl<$Res, $Val extends ThreatTrend>
    implements $ThreatTrendCopyWith<$Res> {
  _$ThreatTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreatTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
    Object? avgRiskScore = null,
    Object? channel = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      avgRiskScore: null == avgRiskScore
          ? _value.avgRiskScore
          : avgRiskScore // ignore: cast_nullable_to_non_nullable
              as double,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreatTrendImplCopyWith<$Res>
    implements $ThreatTrendCopyWith<$Res> {
  factory _$$ThreatTrendImplCopyWith(
          _$ThreatTrendImpl value, $Res Function(_$ThreatTrendImpl) then) =
      __$$ThreatTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      int count,
      @JsonKey(name: 'avg_risk_score') double avgRiskScore,
      String channel});
}

/// @nodoc
class __$$ThreatTrendImplCopyWithImpl<$Res>
    extends _$ThreatTrendCopyWithImpl<$Res, _$ThreatTrendImpl>
    implements _$$ThreatTrendImplCopyWith<$Res> {
  __$$ThreatTrendImplCopyWithImpl(
      _$ThreatTrendImpl _value, $Res Function(_$ThreatTrendImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreatTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
    Object? avgRiskScore = null,
    Object? channel = null,
  }) {
    return _then(_$ThreatTrendImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      avgRiskScore: null == avgRiskScore
          ? _value.avgRiskScore
          : avgRiskScore // ignore: cast_nullable_to_non_nullable
              as double,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreatTrendImpl implements _ThreatTrend {
  const _$ThreatTrendImpl(
      {required this.date,
      required this.count,
      @JsonKey(name: 'avg_risk_score') required this.avgRiskScore,
      required this.channel});

  factory _$ThreatTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatTrendImplFromJson(json);

  @override
  final String date;
  @override
  final int count;
  @override
  @JsonKey(name: 'avg_risk_score')
  final double avgRiskScore;
  @override
  final String channel;

  @override
  String toString() {
    return 'ThreatTrend(date: $date, count: $count, avgRiskScore: $avgRiskScore, channel: $channel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatTrendImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avgRiskScore, avgRiskScore) ||
                other.avgRiskScore == avgRiskScore) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, count, avgRiskScore, channel);

  /// Create a copy of ThreatTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreatTrendImplCopyWith<_$ThreatTrendImpl> get copyWith =>
      __$$ThreatTrendImplCopyWithImpl<_$ThreatTrendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatTrendImplToJson(
      this,
    );
  }
}

abstract class _ThreatTrend implements ThreatTrend {
  const factory _ThreatTrend(
      {required final String date,
      required final int count,
      @JsonKey(name: 'avg_risk_score') required final double avgRiskScore,
      required final String channel}) = _$ThreatTrendImpl;

  factory _ThreatTrend.fromJson(Map<String, dynamic> json) =
      _$ThreatTrendImpl.fromJson;

  @override
  String get date;
  @override
  int get count;
  @override
  @JsonKey(name: 'avg_risk_score')
  double get avgRiskScore;
  @override
  String get channel;

  /// Create a copy of ThreatTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreatTrendImplCopyWith<_$ThreatTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardTrends _$DashboardTrendsFromJson(Map<String, dynamic> json) {
  return _DashboardTrends.fromJson(json);
}

/// @nodoc
mixin _$DashboardTrends {
  List<ThreatTrend> get trends => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_days')
  int get periodDays => throw _privateConstructorUsedError;

  /// Serializes this DashboardTrends to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardTrendsCopyWith<DashboardTrends> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardTrendsCopyWith<$Res> {
  factory $DashboardTrendsCopyWith(
          DashboardTrends value, $Res Function(DashboardTrends) then) =
      _$DashboardTrendsCopyWithImpl<$Res, DashboardTrends>;
  @useResult
  $Res call(
      {List<ThreatTrend> trends, @JsonKey(name: 'period_days') int periodDays});
}

/// @nodoc
class _$DashboardTrendsCopyWithImpl<$Res, $Val extends DashboardTrends>
    implements $DashboardTrendsCopyWith<$Res> {
  _$DashboardTrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trends = null,
    Object? periodDays = null,
  }) {
    return _then(_value.copyWith(
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ThreatTrend>,
      periodDays: null == periodDays
          ? _value.periodDays
          : periodDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardTrendsImplCopyWith<$Res>
    implements $DashboardTrendsCopyWith<$Res> {
  factory _$$DashboardTrendsImplCopyWith(_$DashboardTrendsImpl value,
          $Res Function(_$DashboardTrendsImpl) then) =
      __$$DashboardTrendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ThreatTrend> trends, @JsonKey(name: 'period_days') int periodDays});
}

/// @nodoc
class __$$DashboardTrendsImplCopyWithImpl<$Res>
    extends _$DashboardTrendsCopyWithImpl<$Res, _$DashboardTrendsImpl>
    implements _$$DashboardTrendsImplCopyWith<$Res> {
  __$$DashboardTrendsImplCopyWithImpl(
      _$DashboardTrendsImpl _value, $Res Function(_$DashboardTrendsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trends = null,
    Object? periodDays = null,
  }) {
    return _then(_$DashboardTrendsImpl(
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ThreatTrend>,
      periodDays: null == periodDays
          ? _value.periodDays
          : periodDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardTrendsImpl implements _DashboardTrends {
  const _$DashboardTrendsImpl(
      {required final List<ThreatTrend> trends,
      @JsonKey(name: 'period_days') required this.periodDays})
      : _trends = trends;

  factory _$DashboardTrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardTrendsImplFromJson(json);

  final List<ThreatTrend> _trends;
  @override
  List<ThreatTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  @override
  @JsonKey(name: 'period_days')
  final int periodDays;

  @override
  String toString() {
    return 'DashboardTrends(trends: $trends, periodDays: $periodDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardTrendsImpl &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.periodDays, periodDays) ||
                other.periodDays == periodDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_trends), periodDays);

  /// Create a copy of DashboardTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardTrendsImplCopyWith<_$DashboardTrendsImpl> get copyWith =>
      __$$DashboardTrendsImplCopyWithImpl<_$DashboardTrendsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardTrendsImplToJson(
      this,
    );
  }
}

abstract class _DashboardTrends implements DashboardTrends {
  const factory _DashboardTrends(
          {required final List<ThreatTrend> trends,
          @JsonKey(name: 'period_days') required final int periodDays}) =
      _$DashboardTrendsImpl;

  factory _DashboardTrends.fromJson(Map<String, dynamic> json) =
      _$DashboardTrendsImpl.fromJson;

  @override
  List<ThreatTrend> get trends;
  @override
  @JsonKey(name: 'period_days')
  int get periodDays;

  /// Create a copy of DashboardTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardTrendsImplCopyWith<_$DashboardTrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineQueueItem _$OfflineQueueItemFromJson(Map<String, dynamic> json) {
  return _OfflineQueueItem.fromJson(json);
}

/// @nodoc
mixin _$OfflineQueueItem {
  String get id => throw _privateConstructorUsedError;
  String get endpoint => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;

  /// Serializes this OfflineQueueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfflineQueueItemCopyWith<OfflineQueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineQueueItemCopyWith<$Res> {
  factory $OfflineQueueItemCopyWith(
          OfflineQueueItem value, $Res Function(OfflineQueueItem) then) =
      _$OfflineQueueItemCopyWithImpl<$Res, OfflineQueueItem>;
  @useResult
  $Res call(
      {String id,
      String endpoint,
      Map<String, dynamic> payload,
      DateTime createdAt,
      int retryCount});
}

/// @nodoc
class _$OfflineQueueItemCopyWithImpl<$Res, $Val extends OfflineQueueItem>
    implements $OfflineQueueItemCopyWith<$Res> {
  _$OfflineQueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? endpoint = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? retryCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineQueueItemImplCopyWith<$Res>
    implements $OfflineQueueItemCopyWith<$Res> {
  factory _$$OfflineQueueItemImplCopyWith(_$OfflineQueueItemImpl value,
          $Res Function(_$OfflineQueueItemImpl) then) =
      __$$OfflineQueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String endpoint,
      Map<String, dynamic> payload,
      DateTime createdAt,
      int retryCount});
}

/// @nodoc
class __$$OfflineQueueItemImplCopyWithImpl<$Res>
    extends _$OfflineQueueItemCopyWithImpl<$Res, _$OfflineQueueItemImpl>
    implements _$$OfflineQueueItemImplCopyWith<$Res> {
  __$$OfflineQueueItemImplCopyWithImpl(_$OfflineQueueItemImpl _value,
      $Res Function(_$OfflineQueueItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? endpoint = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? retryCount = null,
  }) {
    return _then(_$OfflineQueueItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineQueueItemImpl implements _OfflineQueueItem {
  const _$OfflineQueueItemImpl(
      {required this.id,
      required this.endpoint,
      required final Map<String, dynamic> payload,
      required this.createdAt,
      this.retryCount = 0})
      : _payload = payload;

  factory _$OfflineQueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineQueueItemImplFromJson(json);

  @override
  final String id;
  @override
  final String endpoint;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int retryCount;

  @override
  String toString() {
    return 'OfflineQueueItem(id: $id, endpoint: $endpoint, payload: $payload, createdAt: $createdAt, retryCount: $retryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineQueueItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, endpoint,
      const DeepCollectionEquality().hash(_payload), createdAt, retryCount);

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      __$$OfflineQueueItemImplCopyWithImpl<_$OfflineQueueItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineQueueItemImplToJson(
      this,
    );
  }
}

abstract class _OfflineQueueItem implements OfflineQueueItem {
  const factory _OfflineQueueItem(
      {required final String id,
      required final String endpoint,
      required final Map<String, dynamic> payload,
      required final DateTime createdAt,
      final int retryCount}) = _$OfflineQueueItemImpl;

  factory _OfflineQueueItem.fromJson(Map<String, dynamic> json) =
      _$OfflineQueueItemImpl.fromJson;

  @override
  String get id;
  @override
  String get endpoint;
  @override
  Map<String, dynamic> get payload;
  @override
  DateTime get createdAt;
  @override
  int get retryCount;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
