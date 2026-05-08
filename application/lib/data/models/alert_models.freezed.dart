// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) {
  return _AlertModel.fromJson(json);
}

/// @nodoc
mixin _$AlertModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'threat_id')
  String get threatId => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  @JsonKey(name: 'acknowledged_at')
  DateTime? get acknowledgedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AlertModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertModelCopyWith<AlertModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertModelCopyWith<$Res> {
  factory $AlertModelCopyWith(
          AlertModel value, $Res Function(AlertModel) then) =
      _$AlertModelCopyWithImpl<$Res, AlertModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'threat_id') String threatId,
      String severity,
      String title,
      String? description,
      bool acknowledged,
      @JsonKey(name: 'acknowledged_at') DateTime? acknowledgedAt,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$AlertModelCopyWithImpl<$Res, $Val extends AlertModel>
    implements $AlertModelCopyWith<$Res> {
  _$AlertModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threatId = null,
    Object? severity = null,
    Object? title = null,
    Object? description = freezed,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      threatId: null == threatId
          ? _value.threatId
          : threatId // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertModelImplCopyWith<$Res>
    implements $AlertModelCopyWith<$Res> {
  factory _$$AlertModelImplCopyWith(
          _$AlertModelImpl value, $Res Function(_$AlertModelImpl) then) =
      __$$AlertModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'threat_id') String threatId,
      String severity,
      String title,
      String? description,
      bool acknowledged,
      @JsonKey(name: 'acknowledged_at') DateTime? acknowledgedAt,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$AlertModelImplCopyWithImpl<$Res>
    extends _$AlertModelCopyWithImpl<$Res, _$AlertModelImpl>
    implements _$$AlertModelImplCopyWith<$Res> {
  __$$AlertModelImplCopyWithImpl(
      _$AlertModelImpl _value, $Res Function(_$AlertModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlertModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threatId = null,
    Object? severity = null,
    Object? title = null,
    Object? description = freezed,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$AlertModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      threatId: null == threatId
          ? _value.threatId
          : threatId // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertModelImpl implements _AlertModel {
  const _$AlertModelImpl(
      {required this.id,
      @JsonKey(name: 'threat_id') required this.threatId,
      required this.severity,
      required this.title,
      this.description,
      this.acknowledged = false,
      @JsonKey(name: 'acknowledged_at') this.acknowledgedAt,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$AlertModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'threat_id')
  final String threatId;
  @override
  final String severity;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool acknowledged;
  @override
  @JsonKey(name: 'acknowledged_at')
  final DateTime? acknowledgedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'AlertModel(id: $id, threatId: $threatId, severity: $severity, title: $title, description: $description, acknowledged: $acknowledged, acknowledgedAt: $acknowledgedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threatId, threatId) ||
                other.threatId == threatId) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, threatId, severity, title,
      description, acknowledged, acknowledgedAt, createdAt);

  /// Create a copy of AlertModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertModelImplCopyWith<_$AlertModelImpl> get copyWith =>
      __$$AlertModelImplCopyWithImpl<_$AlertModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertModelImplToJson(
      this,
    );
  }
}

abstract class _AlertModel implements AlertModel {
  const factory _AlertModel(
          {required final String id,
          @JsonKey(name: 'threat_id') required final String threatId,
          required final String severity,
          required final String title,
          final String? description,
          final bool acknowledged,
          @JsonKey(name: 'acknowledged_at') final DateTime? acknowledgedAt,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$AlertModelImpl;

  factory _AlertModel.fromJson(Map<String, dynamic> json) =
      _$AlertModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'threat_id')
  String get threatId;
  @override
  String get severity;
  @override
  String get title;
  @override
  String? get description;
  @override
  bool get acknowledged;
  @override
  @JsonKey(name: 'acknowledged_at')
  DateTime? get acknowledgedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of AlertModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertModelImplCopyWith<_$AlertModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertListResponse _$AlertListResponseFromJson(Map<String, dynamic> json) {
  return _AlertListResponse.fromJson(json);
}

/// @nodoc
mixin _$AlertListResponse {
  int get total => throw _privateConstructorUsedError;
  List<AlertModel> get alerts => throw _privateConstructorUsedError;

  /// Serializes this AlertListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertListResponseCopyWith<AlertListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertListResponseCopyWith<$Res> {
  factory $AlertListResponseCopyWith(
          AlertListResponse value, $Res Function(AlertListResponse) then) =
      _$AlertListResponseCopyWithImpl<$Res, AlertListResponse>;
  @useResult
  $Res call({int total, List<AlertModel> alerts});
}

/// @nodoc
class _$AlertListResponseCopyWithImpl<$Res, $Val extends AlertListResponse>
    implements $AlertListResponseCopyWith<$Res> {
  _$AlertListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? alerts = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<AlertModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertListResponseImplCopyWith<$Res>
    implements $AlertListResponseCopyWith<$Res> {
  factory _$$AlertListResponseImplCopyWith(_$AlertListResponseImpl value,
          $Res Function(_$AlertListResponseImpl) then) =
      __$$AlertListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, List<AlertModel> alerts});
}

/// @nodoc
class __$$AlertListResponseImplCopyWithImpl<$Res>
    extends _$AlertListResponseCopyWithImpl<$Res, _$AlertListResponseImpl>
    implements _$$AlertListResponseImplCopyWith<$Res> {
  __$$AlertListResponseImplCopyWithImpl(_$AlertListResponseImpl _value,
      $Res Function(_$AlertListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlertListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? alerts = null,
  }) {
    return _then(_$AlertListResponseImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      alerts: null == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<AlertModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertListResponseImpl implements _AlertListResponse {
  const _$AlertListResponseImpl(
      {required this.total, required final List<AlertModel> alerts})
      : _alerts = alerts;

  factory _$AlertListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertListResponseImplFromJson(json);

  @override
  final int total;
  final List<AlertModel> _alerts;
  @override
  List<AlertModel> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  String toString() {
    return 'AlertListResponse(total: $total, alerts: $alerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertListResponseImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_alerts));

  /// Create a copy of AlertListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertListResponseImplCopyWith<_$AlertListResponseImpl> get copyWith =>
      __$$AlertListResponseImplCopyWithImpl<_$AlertListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertListResponseImplToJson(
      this,
    );
  }
}

abstract class _AlertListResponse implements AlertListResponse {
  const factory _AlertListResponse(
      {required final int total,
      required final List<AlertModel> alerts}) = _$AlertListResponseImpl;

  factory _AlertListResponse.fromJson(Map<String, dynamic> json) =
      _$AlertListResponseImpl.fromJson;

  @override
  int get total;
  @override
  List<AlertModel> get alerts;

  /// Create a copy of AlertListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertListResponseImplCopyWith<_$AlertListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AcknowledgeAlertResponse _$AcknowledgeAlertResponseFromJson(
    Map<String, dynamic> json) {
  return _AcknowledgeAlertResponse.fromJson(json);
}

/// @nodoc
mixin _$AcknowledgeAlertResponse {
  String get id => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  @JsonKey(name: 'acknowledged_at')
  DateTime get acknowledgedAt => throw _privateConstructorUsedError;

  /// Serializes this AcknowledgeAlertResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcknowledgeAlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcknowledgeAlertResponseCopyWith<AcknowledgeAlertResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcknowledgeAlertResponseCopyWith<$Res> {
  factory $AcknowledgeAlertResponseCopyWith(AcknowledgeAlertResponse value,
          $Res Function(AcknowledgeAlertResponse) then) =
      _$AcknowledgeAlertResponseCopyWithImpl<$Res, AcknowledgeAlertResponse>;
  @useResult
  $Res call(
      {String id,
      bool acknowledged,
      @JsonKey(name: 'acknowledged_at') DateTime acknowledgedAt});
}

/// @nodoc
class _$AcknowledgeAlertResponseCopyWithImpl<$Res,
        $Val extends AcknowledgeAlertResponse>
    implements $AcknowledgeAlertResponseCopyWith<$Res> {
  _$AcknowledgeAlertResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcknowledgeAlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: null == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcknowledgeAlertResponseImplCopyWith<$Res>
    implements $AcknowledgeAlertResponseCopyWith<$Res> {
  factory _$$AcknowledgeAlertResponseImplCopyWith(
          _$AcknowledgeAlertResponseImpl value,
          $Res Function(_$AcknowledgeAlertResponseImpl) then) =
      __$$AcknowledgeAlertResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      bool acknowledged,
      @JsonKey(name: 'acknowledged_at') DateTime acknowledgedAt});
}

/// @nodoc
class __$$AcknowledgeAlertResponseImplCopyWithImpl<$Res>
    extends _$AcknowledgeAlertResponseCopyWithImpl<$Res,
        _$AcknowledgeAlertResponseImpl>
    implements _$$AcknowledgeAlertResponseImplCopyWith<$Res> {
  __$$AcknowledgeAlertResponseImplCopyWithImpl(
      _$AcknowledgeAlertResponseImpl _value,
      $Res Function(_$AcknowledgeAlertResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcknowledgeAlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = null,
  }) {
    return _then(_$AcknowledgeAlertResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: null == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AcknowledgeAlertResponseImpl implements _AcknowledgeAlertResponse {
  const _$AcknowledgeAlertResponseImpl(
      {required this.id,
      required this.acknowledged,
      @JsonKey(name: 'acknowledged_at') required this.acknowledgedAt});

  factory _$AcknowledgeAlertResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcknowledgeAlertResponseImplFromJson(json);

  @override
  final String id;
  @override
  final bool acknowledged;
  @override
  @JsonKey(name: 'acknowledged_at')
  final DateTime acknowledgedAt;

  @override
  String toString() {
    return 'AcknowledgeAlertResponse(id: $id, acknowledged: $acknowledged, acknowledgedAt: $acknowledgedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcknowledgeAlertResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, acknowledged, acknowledgedAt);

  /// Create a copy of AcknowledgeAlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcknowledgeAlertResponseImplCopyWith<_$AcknowledgeAlertResponseImpl>
      get copyWith => __$$AcknowledgeAlertResponseImplCopyWithImpl<
          _$AcknowledgeAlertResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcknowledgeAlertResponseImplToJson(
      this,
    );
  }
}

abstract class _AcknowledgeAlertResponse implements AcknowledgeAlertResponse {
  const factory _AcknowledgeAlertResponse(
      {required final String id,
      required final bool acknowledged,
      @JsonKey(name: 'acknowledged_at')
      required final DateTime acknowledgedAt}) = _$AcknowledgeAlertResponseImpl;

  factory _AcknowledgeAlertResponse.fromJson(Map<String, dynamic> json) =
      _$AcknowledgeAlertResponseImpl.fromJson;

  @override
  String get id;
  @override
  bool get acknowledged;
  @override
  @JsonKey(name: 'acknowledged_at')
  DateTime get acknowledgedAt;

  /// Create a copy of AcknowledgeAlertResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcknowledgeAlertResponseImplCopyWith<_$AcknowledgeAlertResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
