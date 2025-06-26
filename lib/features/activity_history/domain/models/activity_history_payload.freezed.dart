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
                case 'taskAdded':
          return TaskAddedPayload.fromJson(
            json
          );
                case 'taskUpdated':
          return TaskUpdatedPayload.fromJson(
            json
          );
                case 'taskCompleted':
          return TaskCompletedPayload.fromJson(
            json
          );
                case 'taskDeleted':
          return TaskDeletedPayload.fromJson(
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

class TaskAddedPayload extends ActivityHistoryPayload {
  const TaskAddedPayload({required this.taskId, required this.title, required this.creatorId, final  String? $type}): $type = $type ?? 'taskAdded',super._();
  factory TaskAddedPayload.fromJson(Map<String, dynamic> json) => _$TaskAddedPayloadFromJson(json);

 final  String taskId;
 final  String title;
 final  String creatorId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskAddedPayloadCopyWith<TaskAddedPayload> get copyWith => _$TaskAddedPayloadCopyWithImpl<TaskAddedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskAddedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskAddedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.title, title) || other.title == title)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,title,creatorId);

@override
String toString() {
  return 'ActivityHistoryPayload.taskAdded(taskId: $taskId, title: $title, creatorId: $creatorId)';
}


}

/// @nodoc
abstract mixin class $TaskAddedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TaskAddedPayloadCopyWith(TaskAddedPayload value, $Res Function(TaskAddedPayload) _then) = _$TaskAddedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String title, String creatorId
});




}
/// @nodoc
class _$TaskAddedPayloadCopyWithImpl<$Res>
    implements $TaskAddedPayloadCopyWith<$Res> {
  _$TaskAddedPayloadCopyWithImpl(this._self, this._then);

  final TaskAddedPayload _self;
  final $Res Function(TaskAddedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? title = null,Object? creatorId = null,}) {
  return _then(TaskAddedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TaskUpdatedPayload extends ActivityHistoryPayload {
  const TaskUpdatedPayload({required this.taskId, required this.updaterId, required final  Map<String, dynamic> changes, final  String? $type}): _changes = changes,$type = $type ?? 'taskUpdated',super._();
  factory TaskUpdatedPayload.fromJson(Map<String, dynamic> json) => _$TaskUpdatedPayloadFromJson(json);

 final  String taskId;
 final  String updaterId;
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
$TaskUpdatedPayloadCopyWith<TaskUpdatedPayload> get copyWith => _$TaskUpdatedPayloadCopyWithImpl<TaskUpdatedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskUpdatedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskUpdatedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.updaterId, updaterId) || other.updaterId == updaterId)&&const DeepCollectionEquality().equals(other._changes, _changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,updaterId,const DeepCollectionEquality().hash(_changes));

@override
String toString() {
  return 'ActivityHistoryPayload.taskUpdated(taskId: $taskId, updaterId: $updaterId, changes: $changes)';
}


}

/// @nodoc
abstract mixin class $TaskUpdatedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TaskUpdatedPayloadCopyWith(TaskUpdatedPayload value, $Res Function(TaskUpdatedPayload) _then) = _$TaskUpdatedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String updaterId, Map<String, dynamic> changes
});




}
/// @nodoc
class _$TaskUpdatedPayloadCopyWithImpl<$Res>
    implements $TaskUpdatedPayloadCopyWith<$Res> {
  _$TaskUpdatedPayloadCopyWithImpl(this._self, this._then);

  final TaskUpdatedPayload _self;
  final $Res Function(TaskUpdatedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? updaterId = null,Object? changes = null,}) {
  return _then(TaskUpdatedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,updaterId: null == updaterId ? _self.updaterId : updaterId // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TaskCompletedPayload extends ActivityHistoryPayload {
  const TaskCompletedPayload({required this.taskId, required this.completedById, final  String? $type}): $type = $type ?? 'taskCompleted',super._();
  factory TaskCompletedPayload.fromJson(Map<String, dynamic> json) => _$TaskCompletedPayloadFromJson(json);

 final  String taskId;
 final  String completedById;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCompletedPayloadCopyWith<TaskCompletedPayload> get copyWith => _$TaskCompletedPayloadCopyWithImpl<TaskCompletedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskCompletedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCompletedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.completedById, completedById) || other.completedById == completedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,completedById);

@override
String toString() {
  return 'ActivityHistoryPayload.taskCompleted(taskId: $taskId, completedById: $completedById)';
}


}

/// @nodoc
abstract mixin class $TaskCompletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TaskCompletedPayloadCopyWith(TaskCompletedPayload value, $Res Function(TaskCompletedPayload) _then) = _$TaskCompletedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String completedById
});




}
/// @nodoc
class _$TaskCompletedPayloadCopyWithImpl<$Res>
    implements $TaskCompletedPayloadCopyWith<$Res> {
  _$TaskCompletedPayloadCopyWithImpl(this._self, this._then);

  final TaskCompletedPayload _self;
  final $Res Function(TaskCompletedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? completedById = null,}) {
  return _then(TaskCompletedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,completedById: null == completedById ? _self.completedById : completedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TaskDeletedPayload extends ActivityHistoryPayload {
  const TaskDeletedPayload({required this.taskId, required this.deletedById, final  String? $type}): $type = $type ?? 'taskDeleted',super._();
  factory TaskDeletedPayload.fromJson(Map<String, dynamic> json) => _$TaskDeletedPayloadFromJson(json);

 final  String taskId;
 final  String deletedById;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDeletedPayloadCopyWith<TaskDeletedPayload> get copyWith => _$TaskDeletedPayloadCopyWithImpl<TaskDeletedPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskDeletedPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDeletedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.deletedById, deletedById) || other.deletedById == deletedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,deletedById);

@override
String toString() {
  return 'ActivityHistoryPayload.taskDeleted(taskId: $taskId, deletedById: $deletedById)';
}


}

/// @nodoc
abstract mixin class $TaskDeletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $TaskDeletedPayloadCopyWith(TaskDeletedPayload value, $Res Function(TaskDeletedPayload) _then) = _$TaskDeletedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String deletedById
});




}
/// @nodoc
class _$TaskDeletedPayloadCopyWithImpl<$Res>
    implements $TaskDeletedPayloadCopyWith<$Res> {
  _$TaskDeletedPayloadCopyWithImpl(this._self, this._then);

  final TaskDeletedPayload _self;
  final $Res Function(TaskDeletedPayload) _then;

/// Create a copy of ActivityHistoryPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? deletedById = null,}) {
  return _then(TaskDeletedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,deletedById: null == deletedById ? _self.deletedById : deletedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProjectUpdatedPayload extends ActivityHistoryPayload {
  const ProjectUpdatedPayload({required this.updaterId, required final  Map<String, dynamic> changes, final  String? $type}): _changes = changes,$type = $type ?? 'projectUpdated',super._();
  factory ProjectUpdatedPayload.fromJson(Map<String, dynamic> json) => _$ProjectUpdatedPayloadFromJson(json);

 final  String updaterId;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectUpdatedPayload&&(identical(other.updaterId, updaterId) || other.updaterId == updaterId)&&const DeepCollectionEquality().equals(other._changes, _changes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,updaterId,const DeepCollectionEquality().hash(_changes));

@override
String toString() {
  return 'ActivityHistoryPayload.projectUpdated(updaterId: $updaterId, changes: $changes)';
}


}

/// @nodoc
abstract mixin class $ProjectUpdatedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $ProjectUpdatedPayloadCopyWith(ProjectUpdatedPayload value, $Res Function(ProjectUpdatedPayload) _then) = _$ProjectUpdatedPayloadCopyWithImpl;
@useResult
$Res call({
 String updaterId, Map<String, dynamic> changes
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
@pragma('vm:prefer-inline') $Res call({Object? updaterId = null,Object? changes = null,}) {
  return _then(ProjectUpdatedPayload(
updaterId: null == updaterId ? _self.updaterId : updaterId // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssigneeAssignedPayload extends ActivityHistoryPayload {
  const AssigneeAssignedPayload({required this.taskId, required this.assigneeId, required this.assignedById, final  String? $type}): $type = $type ?? 'assigneeAssigned',super._();
  factory AssigneeAssignedPayload.fromJson(Map<String, dynamic> json) => _$AssigneeAssignedPayloadFromJson(json);

 final  String taskId;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssigneeAssignedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.assigneeId, assigneeId) || other.assigneeId == assigneeId)&&(identical(other.assignedById, assignedById) || other.assignedById == assignedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,assigneeId,assignedById);

@override
String toString() {
  return 'ActivityHistoryPayload.assigneeAssigned(taskId: $taskId, assigneeId: $assigneeId, assignedById: $assignedById)';
}


}

/// @nodoc
abstract mixin class $AssigneeAssignedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $AssigneeAssignedPayloadCopyWith(AssigneeAssignedPayload value, $Res Function(AssigneeAssignedPayload) _then) = _$AssigneeAssignedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String assigneeId, String assignedById
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
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? assigneeId = null,Object? assignedById = null,}) {
  return _then(AssigneeAssignedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,assigneeId: null == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String,assignedById: null == assignedById ? _self.assignedById : assignedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssigneeChangedPayload extends ActivityHistoryPayload {
  const AssigneeChangedPayload({required this.taskId, required this.oldAssigneeId, required this.newAssigneeId, required this.changedById, final  String? $type}): $type = $type ?? 'assigneeChanged',super._();
  factory AssigneeChangedPayload.fromJson(Map<String, dynamic> json) => _$AssigneeChangedPayloadFromJson(json);

 final  String taskId;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssigneeChangedPayload&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.oldAssigneeId, oldAssigneeId) || other.oldAssigneeId == oldAssigneeId)&&(identical(other.newAssigneeId, newAssigneeId) || other.newAssigneeId == newAssigneeId)&&(identical(other.changedById, changedById) || other.changedById == changedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,oldAssigneeId,newAssigneeId,changedById);

@override
String toString() {
  return 'ActivityHistoryPayload.assigneeChanged(taskId: $taskId, oldAssigneeId: $oldAssigneeId, newAssigneeId: $newAssigneeId, changedById: $changedById)';
}


}

/// @nodoc
abstract mixin class $AssigneeChangedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $AssigneeChangedPayloadCopyWith(AssigneeChangedPayload value, $Res Function(AssigneeChangedPayload) _then) = _$AssigneeChangedPayloadCopyWithImpl;
@useResult
$Res call({
 String taskId, String oldAssigneeId, String newAssigneeId, String changedById
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
@pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? oldAssigneeId = null,Object? newAssigneeId = null,Object? changedById = null,}) {
  return _then(AssigneeChangedPayload(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
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
  const ProjectCompletedPayload({required this.completedById, final  String? $type}): $type = $type ?? 'projectCompleted',super._();
  factory ProjectCompletedPayload.fromJson(Map<String, dynamic> json) => _$ProjectCompletedPayloadFromJson(json);

 final  String completedById;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectCompletedPayload&&(identical(other.completedById, completedById) || other.completedById == completedById));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completedById);

@override
String toString() {
  return 'ActivityHistoryPayload.projectCompleted(completedById: $completedById)';
}


}

/// @nodoc
abstract mixin class $ProjectCompletedPayloadCopyWith<$Res> implements $ActivityHistoryPayloadCopyWith<$Res> {
  factory $ProjectCompletedPayloadCopyWith(ProjectCompletedPayload value, $Res Function(ProjectCompletedPayload) _then) = _$ProjectCompletedPayloadCopyWithImpl;
@useResult
$Res call({
 String completedById
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
@pragma('vm:prefer-inline') $Res call({Object? completedById = null,}) {
  return _then(ProjectCompletedPayload(
completedById: null == completedById ? _self.completedById : completedById // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
