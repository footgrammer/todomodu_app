// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_history_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ActivityHistoryPayload _$ActivityHistoryPayloadFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'memberJoined':
          return MemberJoinedPayload.fromJson(
            json
          );
                case 'memberLeft':
          return MemberLeftPayload.fromJson(
            json
          );
                case 'noticePosted':
          return NoticePostedPayload.fromJson(
            json
          );
                case 'todoAdded':
          return TodoAddedPayload.fromJson(
            json
          );
                case 'todoUpdated':
          return TodoUpdatedPayload.fromJson(
            json
          );
                case 'todoCompleted':
          return TodoCompletedPayload.fromJson(
            json
          );
                case 'todoDeleted':
          return TodoDeletedPayload.fromJson(
            json
          );
                case 'projectUpdated':
          return ProjectUpdatedPayload.fromJson(
            json
          );
                case 'assigneeAssigned':
          return AssigneeAssignedPayload.fromJson(
            json
          );
                case 'assigneeChanged':
          return AssigneeChangedPayload.fromJson(
            json
          );
                case 'projectCompleted':
          return ProjectCompletedPayload.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ActivityHistoryPayload',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ActivityHistoryPayload {



  /// Serializes this ActivityHistoryPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHistoryPayload);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityHistoryPayload()';
}


}

/// @nodoc
class $ActivityHistoryPayloadCopyWith<$Res>  {
$ActivityHistoryPayloadCopyWith(ActivityHistoryPayload _, $Res Function(ActivityHistoryPayload) __);
}


/// @nodoc
@JsonSerializable()

class MemberJoinedPayload extends ActivityHistoryPayload {
  const MemberJoinedPayload({required this.joinedUserId, final  String? $type}): $type = $type ?? 'memberJoined',super._();
  factory MemberJoinedPayload.fromJson(Map<String, dynamic> json) => _$MemberJoinedPayloadFromJson(json);

 final  String joinedUserId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberJoinedPayloadCopyWith<MemberJoinedPayload> get copyWith => _$MemberJoinedPayloadCopyWithImpl<MemberJoinedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberJoinedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberJoinedPayload&&(identical(other.joinedUserId, joinedUserId) || other.joinedUserId == joinedUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,joinedUserId);

@override
String toString() {
  return 'ActivityHistoryPayload.memberJoined(joinedUserId: $joinedUserId)';
}


}

/// @nodoc
abstract mixin class $MemberJoinedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $MemberJoinedPayloadCopyWith(MemberJoinedPayload value, $Res Function(MemberJoinedPayload) _then) = _$MemberJoinedPayloadCopyWithImpl;
@useResult
$Res call({
 String joinedUserId
});




}
/// @nodoc
class _$MemberJoinedPayloadCopyWithImpl<$Res>
    implements $MemberJoinedPayloadCopyWith<$Res> {
  _$MemberJoinedPayloadCopyWithImpl(this._self, this._then);

  final MemberJoinedPayload _self;
  final $Res Function(MemberJoinedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? joinedUserId = null,}) {
  return _then(MemberJoinedPayload(
joinedUserId: null == joinedUserId ? _self.joinedUserId : joinedUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MemberLeftPayload extends ActivityHistoryPayload {
  const MemberLeftPayload({required this.memberId, final  String? $type}): $type = $type ?? 'memberLeft',super._();
  factory MemberLeftPayload.fromJson(Map<String, dynamic> json) => _$MemberLeftPayloadFromJson(json);

 final  String memberId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberLeftPayloadCopyWith<MemberLeftPayload> get copyWith => _$MemberLeftPayloadCopyWithImpl<MemberLeftPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberLeftPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberLeftPayload&&(identical(other.memberId, memberId) || other.memberId == memberId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId);

@override
String toString() {
  return 'ActivityHistoryPayload.memberLeft(memberId: $memberId)';
}


}

/// @nodoc
abstract mixin class $MemberLeftPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $MemberLeftPayloadCopyWith(MemberLeftPayload value, $Res Function(MemberLeftPayload) _then) = _$MemberLeftPayloadCopyWithImpl;
@useResult
$Res call({
 String memberId
});




}
/// @nodoc
class _$MemberLeftPayloadCopyWithImpl<$Res>
    implements $MemberLeftPayloadCopyWith<$Res> {
  _$MemberLeftPayloadCopyWithImpl(this._self, this._then);

  final MemberLeftPayload _self;
  final $Res Function(MemberLeftPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? memberId = null,}) {
  return _then(MemberLeftPayload(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NoticePostedPayload extends ActivityHistoryPayload {
  const NoticePostedPayload({required this.noticeId, required this.title, final  String? $type}): $type = $type ?? 'noticePosted',super._();
  factory NoticePostedPayload.fromJson(Map<String, dynamic> json) => _$NoticePostedPayloadFromJson(json);

 final  String noticeId;
 final  String title;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticePostedPayloadCopyWith<NoticePostedPayload> get copyWith => _$NoticePostedPayloadCopyWithImpl<NoticePostedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticePostedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticePostedPayload&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,noticeId,title);

@override
String toString() {
  return 'ActivityHistoryPayload.noticePosted(noticeId: $noticeId, title: $title)';
}


}

/// @nodoc
abstract mixin class $NoticePostedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $NoticePostedPayloadCopyWith(NoticePostedPayload value, $Res Function(NoticePostedPayload) _then) = _$NoticePostedPayloadCopyWithImpl;
@useResult
$Res call({
 String noticeId, String title
});




}
/// @nodoc
class _$NoticePostedPayloadCopyWithImpl<$Res>
    implements $NoticePostedPayloadCopyWith<$Res> {
  _$NoticePostedPayloadCopyWithImpl(this._self, this._then);

  final NoticePostedPayload _self;
  final $Res Function(NoticePostedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? noticeId = null,Object? title = null,}) {
  return _then(NoticePostedPayload(
noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TodoAddedPayload extends ActivityHistoryPayload {
  const TodoAddedPayload({required this.todoId, required this.title, final  String? $type}): $type = $type ?? 'todoAdded',super._();
  factory TodoAddedPayload.fromJson(Map<String, dynamic> json) => _$TodoAddedPayloadFromJson(json);

 final  String todoId;
 final  String title;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoAddedPayloadCopyWith<TodoAddedPayload> get copyWith => _$TodoAddedPayloadCopyWithImpl<TodoAddedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoAddedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoAddedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId,title);

@override
String toString() {
  return 'ActivityHistoryPayload.todoAdded(todoId: $todoId, title: $title)';
}


}

/// @nodoc
abstract mixin class $TodoAddedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TodoAddedPayloadCopyWith(TodoAddedPayload value, $Res Function(TodoAddedPayload) _then) = _$TodoAddedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId, String title
});




}
/// @nodoc
class _$TodoAddedPayloadCopyWithImpl<$Res>
    implements $TodoAddedPayloadCopyWith<$Res> {
  _$TodoAddedPayloadCopyWithImpl(this._self, this._then);

  final TodoAddedPayload _self;
  final $Res Function(TodoAddedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,Object? title = null,}) {
  return _then(TodoAddedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TodoUpdatedPayload extends ActivityHistoryPayload {
  const TodoUpdatedPayload({required this.todoId, required this.title, required final  Map<String, dynamic> changes, final  String? $type}): _changes = changes,$type = $type ?? 'todoUpdated',super._();
  factory TodoUpdatedPayload.fromJson(Map<String, dynamic> json) => _$TodoUpdatedPayloadFromJson(json);

 final  String todoId;
 final  String title;
 final  Map<String, dynamic> _changes;
 Map<String, dynamic> get changes {
  if (_changes is EqualUnmodifiableMapView) return _changes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_changes);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoUpdatedPayloadCopyWith<TodoUpdatedPayload> get copyWith => _$TodoUpdatedPayloadCopyWithImpl<TodoUpdatedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoUpdatedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoUpdatedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._changes, _changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId,title,const DeepCollectionEquality().hash(_changes));

@override
String toString() {
  return 'ActivityHistoryPayload.todoUpdated(todoId: $todoId, title: $title, changes: $changes)';
}


}

/// @nodoc
abstract mixin class $TodoUpdatedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TodoUpdatedPayloadCopyWith(TodoUpdatedPayload value, $Res Function(TodoUpdatedPayload) _then) = _$TodoUpdatedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId, String title, Map<String, dynamic> changes
});




}
/// @nodoc
class _$TodoUpdatedPayloadCopyWithImpl<$Res>
    implements $TodoUpdatedPayloadCopyWith<$Res> {
  _$TodoUpdatedPayloadCopyWithImpl(this._self, this._then);

  final TodoUpdatedPayload _self;
  final $Res Function(TodoUpdatedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,Object? title = null,Object? changes = null,}) {
  return _then(TodoUpdatedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TodoCompletedPayload extends ActivityHistoryPayload {
  const TodoCompletedPayload({required this.todoId, required this.title, required this.completedById, final  String? $type}): $type = $type ?? 'todoCompleted',super._();
  factory TodoCompletedPayload.fromJson(Map<String, dynamic> json) => _$TodoCompletedPayloadFromJson(json);

 final  String todoId;
 final  String title;
 final  String completedById;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoCompletedPayloadCopyWith<TodoCompletedPayload> get copyWith => _$TodoCompletedPayloadCopyWithImpl<TodoCompletedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoCompletedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoCompletedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.title, title) || other.title == title)&&(identical(other.completedById, completedById) || other.completedById == completedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId,title,completedById);

@override
String toString() {
  return 'ActivityHistoryPayload.todoCompleted(todoId: $todoId, title: $title, completedById: $completedById)';
}


}

/// @nodoc
abstract mixin class $TodoCompletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TodoCompletedPayloadCopyWith(TodoCompletedPayload value, $Res Function(TodoCompletedPayload) _then) = _$TodoCompletedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId, String title, String completedById
});




}
/// @nodoc
class _$TodoCompletedPayloadCopyWithImpl<$Res>
    implements $TodoCompletedPayloadCopyWith<$Res> {
  _$TodoCompletedPayloadCopyWithImpl(this._self, this._then);

  final TodoCompletedPayload _self;
  final $Res Function(TodoCompletedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,Object? title = null,Object? completedById = null,}) {
  return _then(TodoCompletedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,completedById: null == completedById ? _self.completedById : completedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TodoDeletedPayload extends ActivityHistoryPayload {
  const TodoDeletedPayload({required this.todoId, final  String? $type}): $type = $type ?? 'todoDeleted',super._();
  factory TodoDeletedPayload.fromJson(Map<String, dynamic> json) => _$TodoDeletedPayloadFromJson(json);

 final  String todoId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoDeletedPayloadCopyWith<TodoDeletedPayload> get copyWith => _$TodoDeletedPayloadCopyWithImpl<TodoDeletedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoDeletedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoDeletedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId);

@override
String toString() {
  return 'ActivityHistoryPayload.todoDeleted(todoId: $todoId)';
}


}

/// @nodoc
abstract mixin class $TodoDeletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TodoDeletedPayloadCopyWith(TodoDeletedPayload value, $Res Function(TodoDeletedPayload) _then) = _$TodoDeletedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId
});




}
/// @nodoc
class _$TodoDeletedPayloadCopyWithImpl<$Res>
    implements $TodoDeletedPayloadCopyWith<$Res> {
  _$TodoDeletedPayloadCopyWithImpl(this._self, this._then);

  final TodoDeletedPayload _self;
  final $Res Function(TodoDeletedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,}) {
  return _then(TodoDeletedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProjectUpdatedPayload extends ActivityHistoryPayload {
  const ProjectUpdatedPayload({required this.updaterId, required this.title, required final  Map<String, dynamic> changes, final  String? $type}): _changes = changes,$type = $type ?? 'projectUpdated',super._();
  factory ProjectUpdatedPayload.fromJson(Map<String, dynamic> json) => _$ProjectUpdatedPayloadFromJson(json);

 final  String updaterId;
 final  String title;
 final  Map<String, dynamic> _changes;
 Map<String, dynamic> get changes {
  if (_changes is EqualUnmodifiableMapView) return _changes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_changes);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectUpdatedPayloadCopyWith<ProjectUpdatedPayload> get copyWith => _$ProjectUpdatedPayloadCopyWithImpl<ProjectUpdatedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectUpdatedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectUpdatedPayload&&(identical(other.updaterId, updaterId) || other.updaterId == updaterId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._changes, _changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updaterId,title,const DeepCollectionEquality().hash(_changes));

@override
String toString() {
  return 'ActivityHistoryPayload.projectUpdated(updaterId: $updaterId, title: $title, changes: $changes)';
}


}

/// @nodoc
abstract mixin class $ProjectUpdatedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $ProjectUpdatedPayloadCopyWith(ProjectUpdatedPayload value, $Res Function(ProjectUpdatedPayload) _then) = _$ProjectUpdatedPayloadCopyWithImpl;
@useResult
$Res call({
 String updaterId, String title, Map<String, dynamic> changes
});




}
/// @nodoc
class _$ProjectUpdatedPayloadCopyWithImpl<$Res>
    implements $ProjectUpdatedPayloadCopyWith<$Res> {
  _$ProjectUpdatedPayloadCopyWithImpl(this._self, this._then);

  final ProjectUpdatedPayload _self;
  final $Res Function(ProjectUpdatedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? updaterId = null,Object? title = null,Object? changes = null,}) {
  return _then(ProjectUpdatedPayload(
updaterId: null == updaterId ? _self.updaterId : updaterId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssigneeAssignedPayload extends ActivityHistoryPayload {
  const AssigneeAssignedPayload({required this.todoId, required this.title, required this.assigneeId, required this.assignedById, final  String? $type}): $type = $type ?? 'assigneeAssigned',super._();
  factory AssigneeAssignedPayload.fromJson(Map<String, dynamic> json) => _$AssigneeAssignedPayloadFromJson(json);

 final  String todoId;
 final  String title;
 final  String assigneeId;
 final  String assignedById;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssigneeAssignedPayloadCopyWith<AssigneeAssignedPayload> get copyWith => _$AssigneeAssignedPayloadCopyWithImpl<AssigneeAssignedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssigneeAssignedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssigneeAssignedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.title, title) || other.title == title)&&(identical(other.assigneeId, assigneeId) || other.assigneeId == assigneeId)&&(identical(other.assignedById, assignedById) || other.assignedById == assignedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId,title,assigneeId,assignedById);

@override
String toString() {
  return 'ActivityHistoryPayload.assigneeAssigned(todoId: $todoId, title: $title, assigneeId: $assigneeId, assignedById: $assignedById)';
}


}

/// @nodoc
abstract mixin class $AssigneeAssignedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $AssigneeAssignedPayloadCopyWith(AssigneeAssignedPayload value, $Res Function(AssigneeAssignedPayload) _then) = _$AssigneeAssignedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId, String title, String assigneeId, String assignedById
});




}
/// @nodoc
class _$AssigneeAssignedPayloadCopyWithImpl<$Res>
    implements $AssigneeAssignedPayloadCopyWith<$Res> {
  _$AssigneeAssignedPayloadCopyWithImpl(this._self, this._then);

  final AssigneeAssignedPayload _self;
  final $Res Function(AssigneeAssignedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,Object? title = null,Object? assigneeId = null,Object? assignedById = null,}) {
  return _then(AssigneeAssignedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,assigneeId: null == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String,assignedById: null == assignedById ? _self.assignedById : assignedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssigneeChangedPayload extends ActivityHistoryPayload {
  const AssigneeChangedPayload({required this.todoId, required this.title, required this.oldAssigneeId, required this.newAssigneeId, required this.changedById, final  String? $type}): $type = $type ?? 'assigneeChanged',super._();
  factory AssigneeChangedPayload.fromJson(Map<String, dynamic> json) => _$AssigneeChangedPayloadFromJson(json);

 final  String todoId;
 final  String title;
 final  String oldAssigneeId;
 final  String newAssigneeId;
 final  String changedById;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssigneeChangedPayloadCopyWith<AssigneeChangedPayload> get copyWith => _$AssigneeChangedPayloadCopyWithImpl<AssigneeChangedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssigneeChangedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssigneeChangedPayload&&(identical(other.todoId, todoId) || other.todoId == todoId)&&(identical(other.title, title) || other.title == title)&&(identical(other.oldAssigneeId, oldAssigneeId) || other.oldAssigneeId == oldAssigneeId)&&(identical(other.newAssigneeId, newAssigneeId) || other.newAssigneeId == newAssigneeId)&&(identical(other.changedById, changedById) || other.changedById == changedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todoId,title,oldAssigneeId,newAssigneeId,changedById);

@override
String toString() {
  return 'ActivityHistoryPayload.assigneeChanged(todoId: $todoId, title: $title, oldAssigneeId: $oldAssigneeId, newAssigneeId: $newAssigneeId, changedById: $changedById)';
}


}

/// @nodoc
abstract mixin class $AssigneeChangedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $AssigneeChangedPayloadCopyWith(AssigneeChangedPayload value, $Res Function(AssigneeChangedPayload) _then) = _$AssigneeChangedPayloadCopyWithImpl;
@useResult
$Res call({
 String todoId, String title, String oldAssigneeId, String newAssigneeId, String changedById
});




}
/// @nodoc
class _$AssigneeChangedPayloadCopyWithImpl<$Res>
    implements $AssigneeChangedPayloadCopyWith<$Res> {
  _$AssigneeChangedPayloadCopyWithImpl(this._self, this._then);

  final AssigneeChangedPayload _self;
  final $Res Function(AssigneeChangedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todoId = null,Object? title = null,Object? oldAssigneeId = null,Object? newAssigneeId = null,Object? changedById = null,}) {
  return _then(AssigneeChangedPayload(
todoId: null == todoId ? _self.todoId : todoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,oldAssigneeId: null == oldAssigneeId ? _self.oldAssigneeId : oldAssigneeId // ignore: cast_nullable_to_non_nullable
as String,newAssigneeId: null == newAssigneeId ? _self.newAssigneeId : newAssigneeId // ignore: cast_nullable_to_non_nullable
as String,changedById: null == changedById ? _self.changedById : changedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProjectCompletedPayload extends ActivityHistoryPayload {
  const ProjectCompletedPayload({required this.completedById, required this.title, final  String? $type}): $type = $type ?? 'projectCompleted',super._();
  factory ProjectCompletedPayload.fromJson(Map<String, dynamic> json) => _$ProjectCompletedPayloadFromJson(json);

 final  String completedById;
 final  String title;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCompletedPayloadCopyWith<ProjectCompletedPayload> get copyWith => _$ProjectCompletedPayloadCopyWithImpl<ProjectCompletedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectCompletedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectCompletedPayload&&(identical(other.completedById, completedById) || other.completedById == completedById)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completedById,title);

@override
String toString() {
  return 'ActivityHistoryPayload.projectCompleted(completedById: $completedById, title: $title)';
}


}

/// @nodoc
abstract mixin class $ProjectCompletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $ProjectCompletedPayloadCopyWith(ProjectCompletedPayload value, $Res Function(ProjectCompletedPayload) _then) = _$ProjectCompletedPayloadCopyWithImpl;
@useResult
$Res call({
 String completedById, String title
});




}
/// @nodoc
class _$ProjectCompletedPayloadCopyWithImpl<$Res>
    implements $ProjectCompletedPayloadCopyWith<$Res> {
  _$ProjectCompletedPayloadCopyWithImpl(this._self, this._then);

  final ProjectCompletedPayload _self;
  final $Res Function(ProjectCompletedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? completedById = null,Object? title = null,}) {
  return _then(ProjectCompletedPayload(
completedById: null == completedById ? _self.completedById : completedById // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
