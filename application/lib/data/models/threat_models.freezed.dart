// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'threat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThreatAnalysisResponse _$ThreatAnalysisResponseFromJson(
    Map<String, dynamic> json) {
  return _ThreatAnalysisResponse.fromJson(json);
}

/// @nodoc
mixin _$ThreatAnalysisResponse {
  @JsonKey(name: 'threat_id')
  String? get threatId => throw _privateConstructorUsedError;
  @JsonKey(name: 'threat_detected')
  bool get threatDetected => throw _privateConstructorUsedError;
  @JsonKey(name: 'risk_score')
  double get riskScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'threat_level')
  String get threatLevel => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  @JsonKey(name: 'classification_label')
  String get classificationLabel => throw _privateConstructorUsedError;
  List<String> get reasons => throw _privateConstructorUsedError;
  @JsonKey(name: 'extracted_urls')
  List<String> get extractedUrls => throw _privateConstructorUsedError;
  @JsonKey(name: 'nlp_score')
  double get nlpScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'behavior_score')
  double get behaviorScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'url_score')
  double get urlScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'reputation_score')
  double get reputationScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'processing_mode')
  String get processingMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_id')
  String? get taskId => throw _privateConstructorUsedError;

  /// Serializes this ThreatAnalysisResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreatAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreatAnalysisResponseCopyWith<ThreatAnalysisResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreatAnalysisResponseCopyWith<$Res> {
  factory $ThreatAnalysisResponseCopyWith(ThreatAnalysisResponse value,
          $Res Function(ThreatAnalysisResponse) then) =
      _$ThreatAnalysisResponseCopyWithImpl<$Res, ThreatAnalysisResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'threat_id') String? threatId,
      @JsonKey(name: 'threat_detected') bool threatDetected,
      @JsonKey(name: 'risk_score') double riskScore,
      @JsonKey(name: 'threat_level') String threatLevel,
      double confidence,
      @JsonKey(name: 'classification_label') String classificationLabel,
      List<String> reasons,
      @JsonKey(name: 'extracted_urls') List<String> extractedUrls,
      @JsonKey(name: 'nlp_score') double nlpScore,
      @JsonKey(name: 'behavior_score') double behaviorScore,
      @JsonKey(name: 'url_score') double urlScore,
      @JsonKey(name: 'reputation_score') double reputationScore,
      @JsonKey(name: 'processing_mode') String processingMode,
      @JsonKey(name: 'task_id') String? taskId});
}

/// @nodoc
class _$ThreatAnalysisResponseCopyWithImpl<$Res,
        $Val extends ThreatAnalysisResponse>
    implements $ThreatAnalysisResponseCopyWith<$Res> {
  _$ThreatAnalysisResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreatAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threatId = freezed,
    Object? threatDetected = null,
    Object? riskScore = null,
    Object? threatLevel = null,
    Object? confidence = null,
    Object? classificationLabel = null,
    Object? reasons = null,
    Object? extractedUrls = null,
    Object? nlpScore = null,
    Object? behaviorScore = null,
    Object? urlScore = null,
    Object? reputationScore = null,
    Object? processingMode = null,
    Object? taskId = freezed,
  }) {
    return _then(_value.copyWith(
      threatId: freezed == threatId
          ? _value.threatId
          : threatId // ignore: cast_nullable_to_non_nullable
              as String?,
      threatDetected: null == threatDetected
          ? _value.threatDetected
          : threatDetected // ignore: cast_nullable_to_non_nullable
              as bool,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      classificationLabel: null == classificationLabel
          ? _value.classificationLabel
          : classificationLabel // ignore: cast_nullable_to_non_nullable
              as String,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      extractedUrls: null == extractedUrls
          ? _value.extractedUrls
          : extractedUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nlpScore: null == nlpScore
          ? _value.nlpScore
          : nlpScore // ignore: cast_nullable_to_non_nullable
              as double,
      behaviorScore: null == behaviorScore
          ? _value.behaviorScore
          : behaviorScore // ignore: cast_nullable_to_non_nullable
              as double,
      urlScore: null == urlScore
          ? _value.urlScore
          : urlScore // ignore: cast_nullable_to_non_nullable
              as double,
      reputationScore: null == reputationScore
          ? _value.reputationScore
          : reputationScore // ignore: cast_nullable_to_non_nullable
              as double,
      processingMode: null == processingMode
          ? _value.processingMode
          : processingMode // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreatAnalysisResponseImplCopyWith<$Res>
    implements $ThreatAnalysisResponseCopyWith<$Res> {
  factory _$$ThreatAnalysisResponseImplCopyWith(
          _$ThreatAnalysisResponseImpl value,
          $Res Function(_$ThreatAnalysisResponseImpl) then) =
      __$$ThreatAnalysisResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'threat_id') String? threatId,
      @JsonKey(name: 'threat_detected') bool threatDetected,
      @JsonKey(name: 'risk_score') double riskScore,
      @JsonKey(name: 'threat_level') String threatLevel,
      double confidence,
      @JsonKey(name: 'classification_label') String classificationLabel,
      List<String> reasons,
      @JsonKey(name: 'extracted_urls') List<String> extractedUrls,
      @JsonKey(name: 'nlp_score') double nlpScore,
      @JsonKey(name: 'behavior_score') double behaviorScore,
      @JsonKey(name: 'url_score') double urlScore,
      @JsonKey(name: 'reputation_score') double reputationScore,
      @JsonKey(name: 'processing_mode') String processingMode,
      @JsonKey(name: 'task_id') String? taskId});
}

/// @nodoc
class __$$ThreatAnalysisResponseImplCopyWithImpl<$Res>
    extends _$ThreatAnalysisResponseCopyWithImpl<$Res,
        _$ThreatAnalysisResponseImpl>
    implements _$$ThreatAnalysisResponseImplCopyWith<$Res> {
  __$$ThreatAnalysisResponseImplCopyWithImpl(
      _$ThreatAnalysisResponseImpl _value,
      $Res Function(_$ThreatAnalysisResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreatAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threatId = freezed,
    Object? threatDetected = null,
    Object? riskScore = null,
    Object? threatLevel = null,
    Object? confidence = null,
    Object? classificationLabel = null,
    Object? reasons = null,
    Object? extractedUrls = null,
    Object? nlpScore = null,
    Object? behaviorScore = null,
    Object? urlScore = null,
    Object? reputationScore = null,
    Object? processingMode = null,
    Object? taskId = freezed,
  }) {
    return _then(_$ThreatAnalysisResponseImpl(
      threatId: freezed == threatId
          ? _value.threatId
          : threatId // ignore: cast_nullable_to_non_nullable
              as String?,
      threatDetected: null == threatDetected
          ? _value.threatDetected
          : threatDetected // ignore: cast_nullable_to_non_nullable
              as bool,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      classificationLabel: null == classificationLabel
          ? _value.classificationLabel
          : classificationLabel // ignore: cast_nullable_to_non_nullable
              as String,
      reasons: null == reasons
          ? _value._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      extractedUrls: null == extractedUrls
          ? _value._extractedUrls
          : extractedUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nlpScore: null == nlpScore
          ? _value.nlpScore
          : nlpScore // ignore: cast_nullable_to_non_nullable
              as double,
      behaviorScore: null == behaviorScore
          ? _value.behaviorScore
          : behaviorScore // ignore: cast_nullable_to_non_nullable
              as double,
      urlScore: null == urlScore
          ? _value.urlScore
          : urlScore // ignore: cast_nullable_to_non_nullable
              as double,
      reputationScore: null == reputationScore
          ? _value.reputationScore
          : reputationScore // ignore: cast_nullable_to_non_nullable
              as double,
      processingMode: null == processingMode
          ? _value.processingMode
          : processingMode // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreatAnalysisResponseImpl implements _ThreatAnalysisResponse {
  const _$ThreatAnalysisResponseImpl(
      {@JsonKey(name: 'threat_id') this.threatId,
      @JsonKey(name: 'threat_detected') required this.threatDetected,
      @JsonKey(name: 'risk_score') required this.riskScore,
      @JsonKey(name: 'threat_level') required this.threatLevel,
      required this.confidence,
      @JsonKey(name: 'classification_label') required this.classificationLabel,
      required final List<String> reasons,
      @JsonKey(name: 'extracted_urls')
      final List<String> extractedUrls = const [],
      @JsonKey(name: 'nlp_score') required this.nlpScore,
      @JsonKey(name: 'behavior_score') required this.behaviorScore,
      @JsonKey(name: 'url_score') required this.urlScore,
      @JsonKey(name: 'reputation_score') required this.reputationScore,
      @JsonKey(name: 'processing_mode') this.processingMode = 'sync',
      @JsonKey(name: 'task_id') this.taskId})
      : _reasons = reasons,
        _extractedUrls = extractedUrls;

  factory _$ThreatAnalysisResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatAnalysisResponseImplFromJson(json);

  @override
  @JsonKey(name: 'threat_id')
  final String? threatId;
  @override
  @JsonKey(name: 'threat_detected')
  final bool threatDetected;
  @override
  @JsonKey(name: 'risk_score')
  final double riskScore;
  @override
  @JsonKey(name: 'threat_level')
  final String threatLevel;
  @override
  final double confidence;
  @override
  @JsonKey(name: 'classification_label')
  final String classificationLabel;
  final List<String> _reasons;
  @override
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  final List<String> _extractedUrls;
  @override
  @JsonKey(name: 'extracted_urls')
  List<String> get extractedUrls {
    if (_extractedUrls is EqualUnmodifiableListView) return _extractedUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extractedUrls);
  }

  @override
  @JsonKey(name: 'nlp_score')
  final double nlpScore;
  @override
  @JsonKey(name: 'behavior_score')
  final double behaviorScore;
  @override
  @JsonKey(name: 'url_score')
  final double urlScore;
  @override
  @JsonKey(name: 'reputation_score')
  final double reputationScore;
  @override
  @JsonKey(name: 'processing_mode')
  final String processingMode;
  @override
  @JsonKey(name: 'task_id')
  final String? taskId;

  @override
  String toString() {
    return 'ThreatAnalysisResponse(threatId: $threatId, threatDetected: $threatDetected, riskScore: $riskScore, threatLevel: $threatLevel, confidence: $confidence, classificationLabel: $classificationLabel, reasons: $reasons, extractedUrls: $extractedUrls, nlpScore: $nlpScore, behaviorScore: $behaviorScore, urlScore: $urlScore, reputationScore: $reputationScore, processingMode: $processingMode, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatAnalysisResponseImpl &&
            (identical(other.threatId, threatId) ||
                other.threatId == threatId) &&
            (identical(other.threatDetected, threatDetected) ||
                other.threatDetected == threatDetected) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.threatLevel, threatLevel) ||
                other.threatLevel == threatLevel) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.classificationLabel, classificationLabel) ||
                other.classificationLabel == classificationLabel) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons) &&
            const DeepCollectionEquality()
                .equals(other._extractedUrls, _extractedUrls) &&
            (identical(other.nlpScore, nlpScore) ||
                other.nlpScore == nlpScore) &&
            (identical(other.behaviorScore, behaviorScore) ||
                other.behaviorScore == behaviorScore) &&
            (identical(other.urlScore, urlScore) ||
                other.urlScore == urlScore) &&
            (identical(other.reputationScore, reputationScore) ||
                other.reputationScore == reputationScore) &&
            (identical(other.processingMode, processingMode) ||
                other.processingMode == processingMode) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      threatId,
      threatDetected,
      riskScore,
      threatLevel,
      confidence,
      classificationLabel,
      const DeepCollectionEquality().hash(_reasons),
      const DeepCollectionEquality().hash(_extractedUrls),
      nlpScore,
      behaviorScore,
      urlScore,
      reputationScore,
      processingMode,
      taskId);

  /// Create a copy of ThreatAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreatAnalysisResponseImplCopyWith<_$ThreatAnalysisResponseImpl>
      get copyWith => __$$ThreatAnalysisResponseImplCopyWithImpl<
          _$ThreatAnalysisResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatAnalysisResponseImplToJson(
      this,
    );
  }
}

abstract class _ThreatAnalysisResponse implements ThreatAnalysisResponse {
  const factory _ThreatAnalysisResponse(
      {@JsonKey(name: 'threat_id') final String? threatId,
      @JsonKey(name: 'threat_detected') required final bool threatDetected,
      @JsonKey(name: 'risk_score') required final double riskScore,
      @JsonKey(name: 'threat_level') required final String threatLevel,
      required final double confidence,
      @JsonKey(name: 'classification_label')
      required final String classificationLabel,
      required final List<String> reasons,
      @JsonKey(name: 'extracted_urls') final List<String> extractedUrls,
      @JsonKey(name: 'nlp_score') required final double nlpScore,
      @JsonKey(name: 'behavior_score') required final double behaviorScore,
      @JsonKey(name: 'url_score') required final double urlScore,
      @JsonKey(name: 'reputation_score') required final double reputationScore,
      @JsonKey(name: 'processing_mode') final String processingMode,
      @JsonKey(name: 'task_id')
      final String? taskId}) = _$ThreatAnalysisResponseImpl;

  factory _ThreatAnalysisResponse.fromJson(Map<String, dynamic> json) =
      _$ThreatAnalysisResponseImpl.fromJson;

  @override
  @JsonKey(name: 'threat_id')
  String? get threatId;
  @override
  @JsonKey(name: 'threat_detected')
  bool get threatDetected;
  @override
  @JsonKey(name: 'risk_score')
  double get riskScore;
  @override
  @JsonKey(name: 'threat_level')
  String get threatLevel;
  @override
  double get confidence;
  @override
  @JsonKey(name: 'classification_label')
  String get classificationLabel;
  @override
  List<String> get reasons;
  @override
  @JsonKey(name: 'extracted_urls')
  List<String> get extractedUrls;
  @override
  @JsonKey(name: 'nlp_score')
  double get nlpScore;
  @override
  @JsonKey(name: 'behavior_score')
  double get behaviorScore;
  @override
  @JsonKey(name: 'url_score')
  double get urlScore;
  @override
  @JsonKey(name: 'reputation_score')
  double get reputationScore;
  @override
  @JsonKey(name: 'processing_mode')
  String get processingMode;
  @override
  @JsonKey(name: 'task_id')
  String? get taskId;

  /// Create a copy of ThreatAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreatAnalysisResponseImplCopyWith<_$ThreatAnalysisResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ThreatSummary _$ThreatSummaryFromJson(Map<String, dynamic> json) {
  return _ThreatSummary.fromJson(json);
}

/// @nodoc
mixin _$ThreatSummary {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'risk_score')
  double get riskScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'threat_level')
  String get threatLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'threat_detected')
  bool get threatDetected => throw _privateConstructorUsedError;
  String? get sender => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ThreatSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreatSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreatSummaryCopyWith<ThreatSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreatSummaryCopyWith<$Res> {
  factory $ThreatSummaryCopyWith(
          ThreatSummary value, $Res Function(ThreatSummary) then) =
      _$ThreatSummaryCopyWithImpl<$Res, ThreatSummary>;
  @useResult
  $Res call(
      {String id,
      String type,
      String channel,
      @JsonKey(name: 'risk_score') double riskScore,
      @JsonKey(name: 'threat_level') String threatLevel,
      @JsonKey(name: 'threat_detected') bool threatDetected,
      String? sender,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$ThreatSummaryCopyWithImpl<$Res, $Val extends ThreatSummary>
    implements $ThreatSummaryCopyWith<$Res> {
  _$ThreatSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreatSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? channel = null,
    Object? riskScore = null,
    Object? threatLevel = null,
    Object? threatDetected = null,
    Object? sender = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as String,
      threatDetected: null == threatDetected
          ? _value.threatDetected
          : threatDetected // ignore: cast_nullable_to_non_nullable
              as bool,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreatSummaryImplCopyWith<$Res>
    implements $ThreatSummaryCopyWith<$Res> {
  factory _$$ThreatSummaryImplCopyWith(
          _$ThreatSummaryImpl value, $Res Function(_$ThreatSummaryImpl) then) =
      __$$ThreatSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String channel,
      @JsonKey(name: 'risk_score') double riskScore,
      @JsonKey(name: 'threat_level') String threatLevel,
      @JsonKey(name: 'threat_detected') bool threatDetected,
      String? sender,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$ThreatSummaryImplCopyWithImpl<$Res>
    extends _$ThreatSummaryCopyWithImpl<$Res, _$ThreatSummaryImpl>
    implements _$$ThreatSummaryImplCopyWith<$Res> {
  __$$ThreatSummaryImplCopyWithImpl(
      _$ThreatSummaryImpl _value, $Res Function(_$ThreatSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreatSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? channel = null,
    Object? riskScore = null,
    Object? threatLevel = null,
    Object? threatDetected = null,
    Object? sender = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$ThreatSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as String,
      threatDetected: null == threatDetected
          ? _value.threatDetected
          : threatDetected // ignore: cast_nullable_to_non_nullable
              as bool,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreatSummaryImpl implements _ThreatSummary {
  const _$ThreatSummaryImpl(
      {required this.id,
      required this.type,
      required this.channel,
      @JsonKey(name: 'risk_score') required this.riskScore,
      @JsonKey(name: 'threat_level') required this.threatLevel,
      @JsonKey(name: 'threat_detected') required this.threatDetected,
      this.sender,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$ThreatSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String channel;
  @override
  @JsonKey(name: 'risk_score')
  final double riskScore;
  @override
  @JsonKey(name: 'threat_level')
  final String threatLevel;
  @override
  @JsonKey(name: 'threat_detected')
  final bool threatDetected;
  @override
  final String? sender;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'ThreatSummary(id: $id, type: $type, channel: $channel, riskScore: $riskScore, threatLevel: $threatLevel, threatDetected: $threatDetected, sender: $sender, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.threatLevel, threatLevel) ||
                other.threatLevel == threatLevel) &&
            (identical(other.threatDetected, threatDetected) ||
                other.threatDetected == threatDetected) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, channel, riskScore,
      threatLevel, threatDetected, sender, createdAt);

  /// Create a copy of ThreatSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreatSummaryImplCopyWith<_$ThreatSummaryImpl> get copyWith =>
      __$$ThreatSummaryImplCopyWithImpl<_$ThreatSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatSummaryImplToJson(
      this,
    );
  }
}

abstract class _ThreatSummary implements ThreatSummary {
  const factory _ThreatSummary(
          {required final String id,
          required final String type,
          required final String channel,
          @JsonKey(name: 'risk_score') required final double riskScore,
          @JsonKey(name: 'threat_level') required final String threatLevel,
          @JsonKey(name: 'threat_detected') required final bool threatDetected,
          final String? sender,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$ThreatSummaryImpl;

  factory _ThreatSummary.fromJson(Map<String, dynamic> json) =
      _$ThreatSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get channel;
  @override
  @JsonKey(name: 'risk_score')
  double get riskScore;
  @override
  @JsonKey(name: 'threat_level')
  String get threatLevel;
  @override
  @JsonKey(name: 'threat_detected')
  bool get threatDetected;
  @override
  String? get sender;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ThreatSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreatSummaryImplCopyWith<_$ThreatSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThreatListResponse _$ThreatListResponseFromJson(Map<String, dynamic> json) {
  return _ThreatListResponse.fromJson(json);
}

/// @nodoc
mixin _$ThreatListResponse {
  int get total => throw _privateConstructorUsedError;
  List<ThreatSummary> get threats => throw _privateConstructorUsedError;

  /// Serializes this ThreatListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreatListResponseCopyWith<ThreatListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreatListResponseCopyWith<$Res> {
  factory $ThreatListResponseCopyWith(
          ThreatListResponse value, $Res Function(ThreatListResponse) then) =
      _$ThreatListResponseCopyWithImpl<$Res, ThreatListResponse>;
  @useResult
  $Res call({int total, List<ThreatSummary> threats});
}

/// @nodoc
class _$ThreatListResponseCopyWithImpl<$Res, $Val extends ThreatListResponse>
    implements $ThreatListResponseCopyWith<$Res> {
  _$ThreatListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? threats = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      threats: null == threats
          ? _value.threats
          : threats // ignore: cast_nullable_to_non_nullable
              as List<ThreatSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreatListResponseImplCopyWith<$Res>
    implements $ThreatListResponseCopyWith<$Res> {
  factory _$$ThreatListResponseImplCopyWith(_$ThreatListResponseImpl value,
          $Res Function(_$ThreatListResponseImpl) then) =
      __$$ThreatListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, List<ThreatSummary> threats});
}

/// @nodoc
class __$$ThreatListResponseImplCopyWithImpl<$Res>
    extends _$ThreatListResponseCopyWithImpl<$Res, _$ThreatListResponseImpl>
    implements _$$ThreatListResponseImplCopyWith<$Res> {
  __$$ThreatListResponseImplCopyWithImpl(_$ThreatListResponseImpl _value,
      $Res Function(_$ThreatListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? threats = null,
  }) {
    return _then(_$ThreatListResponseImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      threats: null == threats
          ? _value._threats
          : threats // ignore: cast_nullable_to_non_nullable
              as List<ThreatSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreatListResponseImpl implements _ThreatListResponse {
  const _$ThreatListResponseImpl(
      {required this.total, required final List<ThreatSummary> threats})
      : _threats = threats;

  factory _$ThreatListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreatListResponseImplFromJson(json);

  @override
  final int total;
  final List<ThreatSummary> _threats;
  @override
  List<ThreatSummary> get threats {
    if (_threats is EqualUnmodifiableListView) return _threats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threats);
  }

  @override
  String toString() {
    return 'ThreatListResponse(total: $total, threats: $threats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreatListResponseImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._threats, _threats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_threats));

  /// Create a copy of ThreatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreatListResponseImplCopyWith<_$ThreatListResponseImpl> get copyWith =>
      __$$ThreatListResponseImplCopyWithImpl<_$ThreatListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreatListResponseImplToJson(
      this,
    );
  }
}

abstract class _ThreatListResponse implements ThreatListResponse {
  const factory _ThreatListResponse(
      {required final int total,
      required final List<ThreatSummary> threats}) = _$ThreatListResponseImpl;

  factory _ThreatListResponse.fromJson(Map<String, dynamic> json) =
      _$ThreatListResponseImpl.fromJson;

  @override
  int get total;
  @override
  List<ThreatSummary> get threats;

  /// Create a copy of ThreatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreatListResponseImplCopyWith<_$ThreatListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmsAnalysisRequest _$SmsAnalysisRequestFromJson(Map<String, dynamic> json) {
  return _SmsAnalysisRequest.fromJson(json);
}

/// @nodoc
mixin _$SmsAnalysisRequest {
  String get sender => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'async_processing')
  bool get asyncProcessing => throw _privateConstructorUsedError;

  /// Serializes this SmsAnalysisRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsAnalysisRequestCopyWith<SmsAnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsAnalysisRequestCopyWith<$Res> {
  factory $SmsAnalysisRequestCopyWith(
          SmsAnalysisRequest value, $Res Function(SmsAnalysisRequest) then) =
      _$SmsAnalysisRequestCopyWithImpl<$Res, SmsAnalysisRequest>;
  @useResult
  $Res call(
      {String sender,
      String message,
      @JsonKey(name: 'async_processing') bool asyncProcessing});
}

/// @nodoc
class _$SmsAnalysisRequestCopyWithImpl<$Res, $Val extends SmsAnalysisRequest>
    implements $SmsAnalysisRequestCopyWith<$Res> {
  _$SmsAnalysisRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? message = null,
    Object? asyncProcessing = null,
  }) {
    return _then(_value.copyWith(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      asyncProcessing: null == asyncProcessing
          ? _value.asyncProcessing
          : asyncProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsAnalysisRequestImplCopyWith<$Res>
    implements $SmsAnalysisRequestCopyWith<$Res> {
  factory _$$SmsAnalysisRequestImplCopyWith(_$SmsAnalysisRequestImpl value,
          $Res Function(_$SmsAnalysisRequestImpl) then) =
      __$$SmsAnalysisRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sender,
      String message,
      @JsonKey(name: 'async_processing') bool asyncProcessing});
}

/// @nodoc
class __$$SmsAnalysisRequestImplCopyWithImpl<$Res>
    extends _$SmsAnalysisRequestCopyWithImpl<$Res, _$SmsAnalysisRequestImpl>
    implements _$$SmsAnalysisRequestImplCopyWith<$Res> {
  __$$SmsAnalysisRequestImplCopyWithImpl(_$SmsAnalysisRequestImpl _value,
      $Res Function(_$SmsAnalysisRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? message = null,
    Object? asyncProcessing = null,
  }) {
    return _then(_$SmsAnalysisRequestImpl(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      asyncProcessing: null == asyncProcessing
          ? _value.asyncProcessing
          : asyncProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsAnalysisRequestImpl implements _SmsAnalysisRequest {
  const _$SmsAnalysisRequestImpl(
      {required this.sender,
      required this.message,
      @JsonKey(name: 'async_processing') this.asyncProcessing = false});

  factory _$SmsAnalysisRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsAnalysisRequestImplFromJson(json);

  @override
  final String sender;
  @override
  final String message;
  @override
  @JsonKey(name: 'async_processing')
  final bool asyncProcessing;

  @override
  String toString() {
    return 'SmsAnalysisRequest(sender: $sender, message: $message, asyncProcessing: $asyncProcessing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsAnalysisRequestImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.asyncProcessing, asyncProcessing) ||
                other.asyncProcessing == asyncProcessing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sender, message, asyncProcessing);

  /// Create a copy of SmsAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsAnalysisRequestImplCopyWith<_$SmsAnalysisRequestImpl> get copyWith =>
      __$$SmsAnalysisRequestImplCopyWithImpl<_$SmsAnalysisRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsAnalysisRequestImplToJson(
      this,
    );
  }
}

abstract class _SmsAnalysisRequest implements SmsAnalysisRequest {
  const factory _SmsAnalysisRequest(
          {required final String sender,
          required final String message,
          @JsonKey(name: 'async_processing') final bool asyncProcessing}) =
      _$SmsAnalysisRequestImpl;

  factory _SmsAnalysisRequest.fromJson(Map<String, dynamic> json) =
      _$SmsAnalysisRequestImpl.fromJson;

  @override
  String get sender;
  @override
  String get message;
  @override
  @JsonKey(name: 'async_processing')
  bool get asyncProcessing;

  /// Create a copy of SmsAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsAnalysisRequestImplCopyWith<_$SmsAnalysisRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallAnalysisRequest _$CallAnalysisRequestFromJson(Map<String, dynamic> json) {
  return _CallAnalysisRequest.fromJson(json);
}

/// @nodoc
mixin _$CallAnalysisRequest {
  String get transcript => throw _privateConstructorUsedError;
  @JsonKey(name: 'caller_id')
  String? get callerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_seconds')
  int? get durationSeconds => throw _privateConstructorUsedError;

  /// Serializes this CallAnalysisRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallAnalysisRequestCopyWith<CallAnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallAnalysisRequestCopyWith<$Res> {
  factory $CallAnalysisRequestCopyWith(
          CallAnalysisRequest value, $Res Function(CallAnalysisRequest) then) =
      _$CallAnalysisRequestCopyWithImpl<$Res, CallAnalysisRequest>;
  @useResult
  $Res call(
      {String transcript,
      @JsonKey(name: 'caller_id') String? callerId,
      @JsonKey(name: 'duration_seconds') int? durationSeconds});
}

/// @nodoc
class _$CallAnalysisRequestCopyWithImpl<$Res, $Val extends CallAnalysisRequest>
    implements $CallAnalysisRequestCopyWith<$Res> {
  _$CallAnalysisRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transcript = null,
    Object? callerId = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(_value.copyWith(
      transcript: null == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String,
      callerId: freezed == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallAnalysisRequestImplCopyWith<$Res>
    implements $CallAnalysisRequestCopyWith<$Res> {
  factory _$$CallAnalysisRequestImplCopyWith(_$CallAnalysisRequestImpl value,
          $Res Function(_$CallAnalysisRequestImpl) then) =
      __$$CallAnalysisRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transcript,
      @JsonKey(name: 'caller_id') String? callerId,
      @JsonKey(name: 'duration_seconds') int? durationSeconds});
}

/// @nodoc
class __$$CallAnalysisRequestImplCopyWithImpl<$Res>
    extends _$CallAnalysisRequestCopyWithImpl<$Res, _$CallAnalysisRequestImpl>
    implements _$$CallAnalysisRequestImplCopyWith<$Res> {
  __$$CallAnalysisRequestImplCopyWithImpl(_$CallAnalysisRequestImpl _value,
      $Res Function(_$CallAnalysisRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transcript = null,
    Object? callerId = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(_$CallAnalysisRequestImpl(
      transcript: null == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String,
      callerId: freezed == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallAnalysisRequestImpl implements _CallAnalysisRequest {
  const _$CallAnalysisRequestImpl(
      {required this.transcript,
      @JsonKey(name: 'caller_id') this.callerId,
      @JsonKey(name: 'duration_seconds') this.durationSeconds});

  factory _$CallAnalysisRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallAnalysisRequestImplFromJson(json);

  @override
  final String transcript;
  @override
  @JsonKey(name: 'caller_id')
  final String? callerId;
  @override
  @JsonKey(name: 'duration_seconds')
  final int? durationSeconds;

  @override
  String toString() {
    return 'CallAnalysisRequest(transcript: $transcript, callerId: $callerId, durationSeconds: $durationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallAnalysisRequestImpl &&
            (identical(other.transcript, transcript) ||
                other.transcript == transcript) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transcript, callerId, durationSeconds);

  /// Create a copy of CallAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallAnalysisRequestImplCopyWith<_$CallAnalysisRequestImpl> get copyWith =>
      __$$CallAnalysisRequestImplCopyWithImpl<_$CallAnalysisRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallAnalysisRequestImplToJson(
      this,
    );
  }
}

abstract class _CallAnalysisRequest implements CallAnalysisRequest {
  const factory _CallAnalysisRequest(
          {required final String transcript,
          @JsonKey(name: 'caller_id') final String? callerId,
          @JsonKey(name: 'duration_seconds') final int? durationSeconds}) =
      _$CallAnalysisRequestImpl;

  factory _CallAnalysisRequest.fromJson(Map<String, dynamic> json) =
      _$CallAnalysisRequestImpl.fromJson;

  @override
  String get transcript;
  @override
  @JsonKey(name: 'caller_id')
  String? get callerId;
  @override
  @JsonKey(name: 'duration_seconds')
  int? get durationSeconds;

  /// Create a copy of CallAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallAnalysisRequestImplCopyWith<_$CallAnalysisRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailAnalysisRequest _$EmailAnalysisRequestFromJson(Map<String, dynamic> json) {
  return _EmailAnalysisRequest.fromJson(json);
}

/// @nodoc
mixin _$EmailAnalysisRequest {
  String get sender => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'async_processing')
  bool get asyncProcessing => throw _privateConstructorUsedError;

  /// Serializes this EmailAnalysisRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailAnalysisRequestCopyWith<EmailAnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailAnalysisRequestCopyWith<$Res> {
  factory $EmailAnalysisRequestCopyWith(EmailAnalysisRequest value,
          $Res Function(EmailAnalysisRequest) then) =
      _$EmailAnalysisRequestCopyWithImpl<$Res, EmailAnalysisRequest>;
  @useResult
  $Res call(
      {String sender,
      String subject,
      String body,
      List<String> attachments,
      @JsonKey(name: 'async_processing') bool asyncProcessing});
}

/// @nodoc
class _$EmailAnalysisRequestCopyWithImpl<$Res,
        $Val extends EmailAnalysisRequest>
    implements $EmailAnalysisRequestCopyWith<$Res> {
  _$EmailAnalysisRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? subject = null,
    Object? body = null,
    Object? attachments = null,
    Object? asyncProcessing = null,
  }) {
    return _then(_value.copyWith(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      asyncProcessing: null == asyncProcessing
          ? _value.asyncProcessing
          : asyncProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailAnalysisRequestImplCopyWith<$Res>
    implements $EmailAnalysisRequestCopyWith<$Res> {
  factory _$$EmailAnalysisRequestImplCopyWith(_$EmailAnalysisRequestImpl value,
          $Res Function(_$EmailAnalysisRequestImpl) then) =
      __$$EmailAnalysisRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sender,
      String subject,
      String body,
      List<String> attachments,
      @JsonKey(name: 'async_processing') bool asyncProcessing});
}

/// @nodoc
class __$$EmailAnalysisRequestImplCopyWithImpl<$Res>
    extends _$EmailAnalysisRequestCopyWithImpl<$Res, _$EmailAnalysisRequestImpl>
    implements _$$EmailAnalysisRequestImplCopyWith<$Res> {
  __$$EmailAnalysisRequestImplCopyWithImpl(_$EmailAnalysisRequestImpl _value,
      $Res Function(_$EmailAnalysisRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? subject = null,
    Object? body = null,
    Object? attachments = null,
    Object? asyncProcessing = null,
  }) {
    return _then(_$EmailAnalysisRequestImpl(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      asyncProcessing: null == asyncProcessing
          ? _value.asyncProcessing
          : asyncProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailAnalysisRequestImpl implements _EmailAnalysisRequest {
  const _$EmailAnalysisRequestImpl(
      {required this.sender,
      required this.subject,
      required this.body,
      final List<String> attachments = const [],
      @JsonKey(name: 'async_processing') this.asyncProcessing = false})
      : _attachments = attachments;

  factory _$EmailAnalysisRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailAnalysisRequestImplFromJson(json);

  @override
  final String sender;
  @override
  final String subject;
  @override
  final String body;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey(name: 'async_processing')
  final bool asyncProcessing;

  @override
  String toString() {
    return 'EmailAnalysisRequest(sender: $sender, subject: $subject, body: $body, attachments: $attachments, asyncProcessing: $asyncProcessing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailAnalysisRequestImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.asyncProcessing, asyncProcessing) ||
                other.asyncProcessing == asyncProcessing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, subject, body,
      const DeepCollectionEquality().hash(_attachments), asyncProcessing);

  /// Create a copy of EmailAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailAnalysisRequestImplCopyWith<_$EmailAnalysisRequestImpl>
      get copyWith =>
          __$$EmailAnalysisRequestImplCopyWithImpl<_$EmailAnalysisRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailAnalysisRequestImplToJson(
      this,
    );
  }
}

abstract class _EmailAnalysisRequest implements EmailAnalysisRequest {
  const factory _EmailAnalysisRequest(
          {required final String sender,
          required final String subject,
          required final String body,
          final List<String> attachments,
          @JsonKey(name: 'async_processing') final bool asyncProcessing}) =
      _$EmailAnalysisRequestImpl;

  factory _EmailAnalysisRequest.fromJson(Map<String, dynamic> json) =
      _$EmailAnalysisRequestImpl.fromJson;

  @override
  String get sender;
  @override
  String get subject;
  @override
  String get body;
  @override
  List<String> get attachments;
  @override
  @JsonKey(name: 'async_processing')
  bool get asyncProcessing;

  /// Create a copy of EmailAnalysisRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailAnalysisRequestImplCopyWith<_$EmailAnalysisRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SmsEvent _$SmsEventFromJson(Map<String, dynamic> json) {
  return _SmsEvent.fromJson(json);
}

/// @nodoc
mixin _$SmsEvent {
  String get id => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get sentToBackend => throw _privateConstructorUsedError;
  ThreatAnalysisResponse? get analysisResult =>
      throw _privateConstructorUsedError;

  /// Serializes this SmsEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsEventCopyWith<SmsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsEventCopyWith<$Res> {
  factory $SmsEventCopyWith(SmsEvent value, $Res Function(SmsEvent) then) =
      _$SmsEventCopyWithImpl<$Res, SmsEvent>;
  @useResult
  $Res call(
      {String id,
      String sender,
      String message,
      DateTime timestamp,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class _$SmsEventCopyWithImpl<$Res, $Val extends SmsEvent>
    implements $SmsEventCopyWith<$Res> {
  _$SmsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? message = null,
    Object? timestamp = null,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ) as $Val);
  }

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult {
    if (_value.analysisResult == null) {
      return null;
    }

    return $ThreatAnalysisResponseCopyWith<$Res>(_value.analysisResult!,
        (value) {
      return _then(_value.copyWith(analysisResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SmsEventImplCopyWith<$Res>
    implements $SmsEventCopyWith<$Res> {
  factory _$$SmsEventImplCopyWith(
          _$SmsEventImpl value, $Res Function(_$SmsEventImpl) then) =
      __$$SmsEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sender,
      String message,
      DateTime timestamp,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  @override
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class __$$SmsEventImplCopyWithImpl<$Res>
    extends _$SmsEventCopyWithImpl<$Res, _$SmsEventImpl>
    implements _$$SmsEventImplCopyWith<$Res> {
  __$$SmsEventImplCopyWithImpl(
      _$SmsEventImpl _value, $Res Function(_$SmsEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? message = null,
    Object? timestamp = null,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_$SmsEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsEventImpl implements _SmsEvent {
  const _$SmsEventImpl(
      {required this.id,
      required this.sender,
      required this.message,
      required this.timestamp,
      this.sentToBackend = false,
      this.analysisResult});

  factory _$SmsEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsEventImplFromJson(json);

  @override
  final String id;
  @override
  final String sender;
  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool sentToBackend;
  @override
  final ThreatAnalysisResponse? analysisResult;

  @override
  String toString() {
    return 'SmsEvent(id: $id, sender: $sender, message: $message, timestamp: $timestamp, sentToBackend: $sentToBackend, analysisResult: $analysisResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sentToBackend, sentToBackend) ||
                other.sentToBackend == sentToBackend) &&
            (identical(other.analysisResult, analysisResult) ||
                other.analysisResult == analysisResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sender, message, timestamp,
      sentToBackend, analysisResult);

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsEventImplCopyWith<_$SmsEventImpl> get copyWith =>
      __$$SmsEventImplCopyWithImpl<_$SmsEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsEventImplToJson(
      this,
    );
  }
}

abstract class _SmsEvent implements SmsEvent {
  const factory _SmsEvent(
      {required final String id,
      required final String sender,
      required final String message,
      required final DateTime timestamp,
      final bool sentToBackend,
      final ThreatAnalysisResponse? analysisResult}) = _$SmsEventImpl;

  factory _SmsEvent.fromJson(Map<String, dynamic> json) =
      _$SmsEventImpl.fromJson;

  @override
  String get id;
  @override
  String get sender;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  bool get sentToBackend;
  @override
  ThreatAnalysisResponse? get analysisResult;

  /// Create a copy of SmsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsEventImplCopyWith<_$SmsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallEvent _$CallEventFromJson(Map<String, dynamic> json) {
  return _CallEvent.fromJson(json);
}

/// @nodoc
mixin _$CallEvent {
  String get id => throw _privateConstructorUsedError;
  String get callerId => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;
  String? get transcript => throw _privateConstructorUsedError;
  bool get sentToBackend => throw _privateConstructorUsedError;
  ThreatAnalysisResponse? get analysisResult =>
      throw _privateConstructorUsedError;

  /// Serializes this CallEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallEventCopyWith<CallEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEventCopyWith<$Res> {
  factory $CallEventCopyWith(CallEvent value, $Res Function(CallEvent) then) =
      _$CallEventCopyWithImpl<$Res, CallEvent>;
  @useResult
  $Res call(
      {String id,
      String callerId,
      String state,
      DateTime timestamp,
      int? durationSeconds,
      String? transcript,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class _$CallEventCopyWithImpl<$Res, $Val extends CallEvent>
    implements $CallEventCopyWith<$Res> {
  _$CallEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? callerId = null,
    Object? state = null,
    Object? timestamp = null,
    Object? durationSeconds = freezed,
    Object? transcript = freezed,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      transcript: freezed == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String?,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ) as $Val);
  }

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult {
    if (_value.analysisResult == null) {
      return null;
    }

    return $ThreatAnalysisResponseCopyWith<$Res>(_value.analysisResult!,
        (value) {
      return _then(_value.copyWith(analysisResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallEventImplCopyWith<$Res>
    implements $CallEventCopyWith<$Res> {
  factory _$$CallEventImplCopyWith(
          _$CallEventImpl value, $Res Function(_$CallEventImpl) then) =
      __$$CallEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String callerId,
      String state,
      DateTime timestamp,
      int? durationSeconds,
      String? transcript,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  @override
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class __$$CallEventImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallEventImpl>
    implements _$$CallEventImplCopyWith<$Res> {
  __$$CallEventImplCopyWithImpl(
      _$CallEventImpl _value, $Res Function(_$CallEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? callerId = null,
    Object? state = null,
    Object? timestamp = null,
    Object? durationSeconds = freezed,
    Object? transcript = freezed,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_$CallEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      transcript: freezed == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String?,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallEventImpl implements _CallEvent {
  const _$CallEventImpl(
      {required this.id,
      required this.callerId,
      required this.state,
      required this.timestamp,
      this.durationSeconds,
      this.transcript,
      this.sentToBackend = false,
      this.analysisResult});

  factory _$CallEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallEventImplFromJson(json);

  @override
  final String id;
  @override
  final String callerId;
  @override
  final String state;
  @override
  final DateTime timestamp;
  @override
  final int? durationSeconds;
  @override
  final String? transcript;
  @override
  @JsonKey()
  final bool sentToBackend;
  @override
  final ThreatAnalysisResponse? analysisResult;

  @override
  String toString() {
    return 'CallEvent(id: $id, callerId: $callerId, state: $state, timestamp: $timestamp, durationSeconds: $durationSeconds, transcript: $transcript, sentToBackend: $sentToBackend, analysisResult: $analysisResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.transcript, transcript) ||
                other.transcript == transcript) &&
            (identical(other.sentToBackend, sentToBackend) ||
                other.sentToBackend == sentToBackend) &&
            (identical(other.analysisResult, analysisResult) ||
                other.analysisResult == analysisResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, callerId, state, timestamp,
      durationSeconds, transcript, sentToBackend, analysisResult);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallEventImplCopyWith<_$CallEventImpl> get copyWith =>
      __$$CallEventImplCopyWithImpl<_$CallEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallEventImplToJson(
      this,
    );
  }
}

abstract class _CallEvent implements CallEvent {
  const factory _CallEvent(
      {required final String id,
      required final String callerId,
      required final String state,
      required final DateTime timestamp,
      final int? durationSeconds,
      final String? transcript,
      final bool sentToBackend,
      final ThreatAnalysisResponse? analysisResult}) = _$CallEventImpl;

  factory _CallEvent.fromJson(Map<String, dynamic> json) =
      _$CallEventImpl.fromJson;

  @override
  String get id;
  @override
  String get callerId;
  @override
  String get state;
  @override
  DateTime get timestamp;
  @override
  int? get durationSeconds;
  @override
  String? get transcript;
  @override
  bool get sentToBackend;
  @override
  ThreatAnalysisResponse? get analysisResult;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallEventImplCopyWith<_$CallEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationEvent _$NotificationEventFromJson(Map<String, dynamic> json) {
  return _NotificationEvent.fromJson(json);
}

/// @nodoc
mixin _$NotificationEvent {
  String get id => throw _privateConstructorUsedError;
  String get packageName => throw _privateConstructorUsedError;
  String get appName => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get sentToBackend => throw _privateConstructorUsedError;
  ThreatAnalysisResponse? get analysisResult =>
      throw _privateConstructorUsedError;

  /// Serializes this NotificationEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationEventCopyWith<NotificationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEventCopyWith<$Res> {
  factory $NotificationEventCopyWith(
          NotificationEvent value, $Res Function(NotificationEvent) then) =
      _$NotificationEventCopyWithImpl<$Res, NotificationEvent>;
  @useResult
  $Res call(
      {String id,
      String packageName,
      String appName,
      String? title,
      String? body,
      DateTime timestamp,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class _$NotificationEventCopyWithImpl<$Res, $Val extends NotificationEvent>
    implements $NotificationEventCopyWith<$Res> {
  _$NotificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packageName = null,
    Object? appName = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? timestamp = null,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ) as $Val);
  }

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult {
    if (_value.analysisResult == null) {
      return null;
    }

    return $ThreatAnalysisResponseCopyWith<$Res>(_value.analysisResult!,
        (value) {
      return _then(_value.copyWith(analysisResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationEventImplCopyWith<$Res>
    implements $NotificationEventCopyWith<$Res> {
  factory _$$NotificationEventImplCopyWith(_$NotificationEventImpl value,
          $Res Function(_$NotificationEventImpl) then) =
      __$$NotificationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String packageName,
      String appName,
      String? title,
      String? body,
      DateTime timestamp,
      bool sentToBackend,
      ThreatAnalysisResponse? analysisResult});

  @override
  $ThreatAnalysisResponseCopyWith<$Res>? get analysisResult;
}

/// @nodoc
class __$$NotificationEventImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$NotificationEventImpl>
    implements _$$NotificationEventImplCopyWith<$Res> {
  __$$NotificationEventImplCopyWithImpl(_$NotificationEventImpl _value,
      $Res Function(_$NotificationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packageName = null,
    Object? appName = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? timestamp = null,
    Object? sentToBackend = null,
    Object? analysisResult = freezed,
  }) {
    return _then(_$NotificationEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sentToBackend: null == sentToBackend
          ? _value.sentToBackend
          : sentToBackend // ignore: cast_nullable_to_non_nullable
              as bool,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as ThreatAnalysisResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationEventImpl implements _NotificationEvent {
  const _$NotificationEventImpl(
      {required this.id,
      required this.packageName,
      required this.appName,
      this.title,
      this.body,
      required this.timestamp,
      this.sentToBackend = false,
      this.analysisResult});

  factory _$NotificationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationEventImplFromJson(json);

  @override
  final String id;
  @override
  final String packageName;
  @override
  final String appName;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool sentToBackend;
  @override
  final ThreatAnalysisResponse? analysisResult;

  @override
  String toString() {
    return 'NotificationEvent(id: $id, packageName: $packageName, appName: $appName, title: $title, body: $body, timestamp: $timestamp, sentToBackend: $sentToBackend, analysisResult: $analysisResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sentToBackend, sentToBackend) ||
                other.sentToBackend == sentToBackend) &&
            (identical(other.analysisResult, analysisResult) ||
                other.analysisResult == analysisResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, packageName, appName, title,
      body, timestamp, sentToBackend, analysisResult);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationEventImplCopyWith<_$NotificationEventImpl> get copyWith =>
      __$$NotificationEventImplCopyWithImpl<_$NotificationEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationEventImplToJson(
      this,
    );
  }
}

abstract class _NotificationEvent implements NotificationEvent {
  const factory _NotificationEvent(
      {required final String id,
      required final String packageName,
      required final String appName,
      final String? title,
      final String? body,
      required final DateTime timestamp,
      final bool sentToBackend,
      final ThreatAnalysisResponse? analysisResult}) = _$NotificationEventImpl;

  factory _NotificationEvent.fromJson(Map<String, dynamic> json) =
      _$NotificationEventImpl.fromJson;

  @override
  String get id;
  @override
  String get packageName;
  @override
  String get appName;
  @override
  String? get title;
  @override
  String? get body;
  @override
  DateTime get timestamp;
  @override
  bool get sentToBackend;
  @override
  ThreatAnalysisResponse? get analysisResult;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationEventImplCopyWith<_$NotificationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
