// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_tickets_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyTicketsState {
  int get ticketStatusIndex => throw _privateConstructorUsedError;
  AsyncValue<List<TicketModel>> get myTicketList =>
      throw _privateConstructorUsedError;
  List<TicketModel> get ticketListSelect => throw _privateConstructorUsedError;
  List<TicketModel> get searchTicketListSelect =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyTicketsStateCopyWith<MyTicketsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyTicketsStateCopyWith<$Res> {
  factory $MyTicketsStateCopyWith(
          MyTicketsState value, $Res Function(MyTicketsState) then) =
      _$MyTicketsStateCopyWithImpl<$Res, MyTicketsState>;
  @useResult
  $Res call(
      {int ticketStatusIndex,
      AsyncValue<List<TicketModel>> myTicketList,
      List<TicketModel> ticketListSelect,
      List<TicketModel> searchTicketListSelect});
}

/// @nodoc
class _$MyTicketsStateCopyWithImpl<$Res, $Val extends MyTicketsState>
    implements $MyTicketsStateCopyWith<$Res> {
  _$MyTicketsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketStatusIndex = null,
    Object? myTicketList = null,
    Object? ticketListSelect = null,
    Object? searchTicketListSelect = null,
  }) {
    return _then(_value.copyWith(
      ticketStatusIndex: null == ticketStatusIndex
          ? _value.ticketStatusIndex
          : ticketStatusIndex // ignore: cast_nullable_to_non_nullable
              as int,
      myTicketList: null == myTicketList
          ? _value.myTicketList
          : myTicketList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TicketModel>>,
      ticketListSelect: null == ticketListSelect
          ? _value.ticketListSelect
          : ticketListSelect // ignore: cast_nullable_to_non_nullable
              as List<TicketModel>,
      searchTicketListSelect: null == searchTicketListSelect
          ? _value.searchTicketListSelect
          : searchTicketListSelect // ignore: cast_nullable_to_non_nullable
              as List<TicketModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyTicketsStateCopyWith<$Res>
    implements $MyTicketsStateCopyWith<$Res> {
  factory _$$_MyTicketsStateCopyWith(
          _$_MyTicketsState value, $Res Function(_$_MyTicketsState) then) =
      __$$_MyTicketsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ticketStatusIndex,
      AsyncValue<List<TicketModel>> myTicketList,
      List<TicketModel> ticketListSelect,
      List<TicketModel> searchTicketListSelect});
}

/// @nodoc
class __$$_MyTicketsStateCopyWithImpl<$Res>
    extends _$MyTicketsStateCopyWithImpl<$Res, _$_MyTicketsState>
    implements _$$_MyTicketsStateCopyWith<$Res> {
  __$$_MyTicketsStateCopyWithImpl(
      _$_MyTicketsState _value, $Res Function(_$_MyTicketsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketStatusIndex = null,
    Object? myTicketList = null,
    Object? ticketListSelect = null,
    Object? searchTicketListSelect = null,
  }) {
    return _then(_$_MyTicketsState(
      ticketStatusIndex: null == ticketStatusIndex
          ? _value.ticketStatusIndex
          : ticketStatusIndex // ignore: cast_nullable_to_non_nullable
              as int,
      myTicketList: null == myTicketList
          ? _value.myTicketList
          : myTicketList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TicketModel>>,
      ticketListSelect: null == ticketListSelect
          ? _value._ticketListSelect
          : ticketListSelect // ignore: cast_nullable_to_non_nullable
              as List<TicketModel>,
      searchTicketListSelect: null == searchTicketListSelect
          ? _value._searchTicketListSelect
          : searchTicketListSelect // ignore: cast_nullable_to_non_nullable
              as List<TicketModel>,
    ));
  }
}

/// @nodoc

class _$_MyTicketsState implements _MyTicketsState {
  const _$_MyTicketsState(
      {required this.ticketStatusIndex,
      required this.myTicketList,
      required final List<TicketModel> ticketListSelect,
      required final List<TicketModel> searchTicketListSelect})
      : _ticketListSelect = ticketListSelect,
        _searchTicketListSelect = searchTicketListSelect;

  @override
  final int ticketStatusIndex;
  @override
  final AsyncValue<List<TicketModel>> myTicketList;
  final List<TicketModel> _ticketListSelect;
  @override
  List<TicketModel> get ticketListSelect {
    if (_ticketListSelect is EqualUnmodifiableListView)
      return _ticketListSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ticketListSelect);
  }

  final List<TicketModel> _searchTicketListSelect;
  @override
  List<TicketModel> get searchTicketListSelect {
    if (_searchTicketListSelect is EqualUnmodifiableListView)
      return _searchTicketListSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchTicketListSelect);
  }

  @override
  String toString() {
    return 'MyTicketsState(ticketStatusIndex: $ticketStatusIndex, myTicketList: $myTicketList, ticketListSelect: $ticketListSelect, searchTicketListSelect: $searchTicketListSelect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyTicketsState &&
            (identical(other.ticketStatusIndex, ticketStatusIndex) ||
                other.ticketStatusIndex == ticketStatusIndex) &&
            (identical(other.myTicketList, myTicketList) ||
                other.myTicketList == myTicketList) &&
            const DeepCollectionEquality()
                .equals(other._ticketListSelect, _ticketListSelect) &&
            const DeepCollectionEquality().equals(
                other._searchTicketListSelect, _searchTicketListSelect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      ticketStatusIndex,
      myTicketList,
      const DeepCollectionEquality().hash(_ticketListSelect),
      const DeepCollectionEquality().hash(_searchTicketListSelect));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyTicketsStateCopyWith<_$_MyTicketsState> get copyWith =>
      __$$_MyTicketsStateCopyWithImpl<_$_MyTicketsState>(this, _$identity);
}

abstract class _MyTicketsState implements MyTicketsState {
  const factory _MyTicketsState(
          {required final int ticketStatusIndex,
          required final AsyncValue<List<TicketModel>> myTicketList,
          required final List<TicketModel> ticketListSelect,
          required final List<TicketModel> searchTicketListSelect}) =
      _$_MyTicketsState;

  @override
  int get ticketStatusIndex;
  @override
  AsyncValue<List<TicketModel>> get myTicketList;
  @override
  List<TicketModel> get ticketListSelect;
  @override
  List<TicketModel> get searchTicketListSelect;
  @override
  @JsonKey(ignore: true)
  _$$_MyTicketsStateCopyWith<_$_MyTicketsState> get copyWith =>
      throw _privateConstructorUsedError;
}
