// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PIF`
  String get appName {
    return Intl.message(
      'PIF',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drink {
    return Intl.message(
      'Drinks',
      name: 'drink',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get booking {
    return Intl.message(
      'Bookings',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Space Booking`
  String get spaceBooking {
    return Intl.message(
      'Space Booking',
      name: 'spaceBooking',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floor {
    return Intl.message(
      'Floor',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `Video conferencing`
  String get videoConferencing {
    return Intl.message(
      'Video conferencing',
      name: 'videoConferencing',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book {
    return Intl.message(
      'Book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `Instant Book`
  String get instanceBooking {
    return Intl.message(
      'Instant Book',
      name: 'instanceBooking',
      desc: '',
      args: [],
    );
  }

  /// `Scan to book`
  String get scanToBook {
    return Intl.message(
      'Scan to book',
      name: 'scanToBook',
      desc: '',
      args: [],
    );
  }

  /// `Filter by`
  String get filterBy {
    return Intl.message(
      'Filter by',
      name: 'filterBy',
      desc: '',
      args: [],
    );
  }

  /// `Dates & Repeat`
  String get datesAndRepeat {
    return Intl.message(
      'Dates & Repeat',
      name: 'datesAndRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Select Dates`
  String get selectDates {
    return Intl.message(
      'Select Dates',
      name: 'selectDates',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Capacity`
  String get capacity {
    return Intl.message(
      'Capacity',
      name: 'capacity',
      desc: '',
      args: [],
    );
  }

  /// `Rest filters`
  String get resetFilter {
    return Intl.message(
      'Rest filters',
      name: 'resetFilter',
      desc: '',
      args: [],
    );
  }

  /// `results found`
  String get resultFound {
    return Intl.message(
      'results found',
      name: 'resultFound',
      desc: '',
      args: [],
    );
  }

  /// `NO ROOMS TO SHOW`
  String get noRoomToShow {
    return Intl.message(
      'NO ROOMS TO SHOW',
      name: 'noRoomToShow',
      desc: '',
      args: [],
    );
  }

  /// `Oops! We can’t find matching results `
  String get cantFindMatchingResult {
    return Intl.message(
      'Oops! We can’t find matching results ',
      name: 'cantFindMatchingResult',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get selectTime {
    return Intl.message(
      'Select time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Drag for booking details`
  String get dragForBookingDetails {
    return Intl.message(
      'Drag for booking details',
      name: 'dragForBookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Screen sharing`
  String get screenSharing {
    return Intl.message(
      'Screen sharing',
      name: 'screenSharing',
      desc: '',
      args: [],
    );
  }

  /// `Room calendar`
  String get roomCalendar {
    return Intl.message(
      'Room calendar',
      name: 'roomCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Booking title`
  String get bookingTitle {
    return Intl.message(
      'Booking title',
      name: 'bookingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Starting time`
  String get startingTime {
    return Intl.message(
      'Starting time',
      name: 'startingTime',
      desc: '',
      args: [],
    );
  }

  /// `Ending time`
  String get endingTime {
    return Intl.message(
      'Ending time',
      name: 'endingTime',
      desc: '',
      args: [],
    );
  }

  /// `Select time on room calendar`
  String get selectTimeOnRoomCalendar {
    return Intl.message(
      'Select time on room calendar',
      name: 'selectTimeOnRoomCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Invite Guests`
  String get guest {
    return Intl.message(
      'Invite Guests',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `New visitor`
  String get newVisitors {
    return Intl.message(
      'New visitor',
      name: 'newVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Add guests`
  String get addGuest {
    return Intl.message(
      'Add guests',
      name: 'addGuest',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get bookNow {
    return Intl.message(
      'Book now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `Oops! no matching results found`
  String get noMatchingResultFound {
    return Intl.message(
      'Oops! no matching results found',
      name: 'noMatchingResultFound',
      desc: '',
      args: [],
    );
  }

  /// `Invite visitor`
  String get inviteVisitor {
    return Intl.message(
      'Invite visitor',
      name: 'inviteVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Visitor outside Co-builder`
  String get visitorOutsideCoBuilder {
    return Intl.message(
      'Visitor outside Co-builder',
      name: 'visitorOutsideCoBuilder',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Visitor Email`
  String get visitorEmail {
    return Intl.message(
      'Visitor Email',
      name: 'visitorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Booking room`
  String get bookingRoom {
    return Intl.message(
      'Booking room',
      name: 'bookingRoom',
      desc: '',
      args: [],
    );
  }

  /// `You booked this by mistake?`
  String get bookedByMistake {
    return Intl.message(
      'You booked this by mistake?',
      name: 'bookedByMistake',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Please enter firstname`
  String get firstNameEmpty {
    return Intl.message(
      'Please enter firstname',
      name: 'firstNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter lastname`
  String get lastNameEmpty {
    return Intl.message(
      'Please enter lastname',
      name: 'lastNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get emailEmpty {
    return Intl.message(
      'Please enter email',
      name: 'emailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Trouble scanning QR code? Enter manually`
  String get troubleScanningQRCodeEnterManually {
    return Intl.message(
      'Trouble scanning QR code? Enter manually',
      name: 'troubleScanningQRCodeEnterManually',
      desc: '',
      args: [],
    );
  }

  /// `Align QR code within frame\n to scan`
  String get alignQRCodeWithinFrameToScan {
    return Intl.message(
      'Align QR code within frame\n to scan',
      name: 'alignQRCodeWithinFrameToScan',
      desc: '',
      args: [],
    );
  }

  /// `Room Name`
  String get roomName {
    return Intl.message(
      'Room Name',
      name: 'roomName',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Search & Filters`
  String get advancedSearchAndFilters {
    return Intl.message(
      'Advanced Search & Filters',
      name: 'advancedSearchAndFilters',
      desc: '',
      args: [],
    );
  }

  /// `Not matching what you are looking for?`
  String get notMatchingWhatYouAreLookingFor {
    return Intl.message(
      'Not matching what you are looking for?',
      name: 'notMatchingWhatYouAreLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code to book`
  String get scanQRCodeToBook {
    return Intl.message(
      'Scan QR code to book',
      name: 'scanQRCodeToBook',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get gotIt {
    return Intl.message(
      'Got it',
      name: 'gotIt',
      desc: '',
      args: [],
    );
  }

  /// `You can book a meeting room by scanning the QR code on displays beside the rooms door`
  String get scanHelpMessage {
    return Intl.message(
      'You can book a meeting room by scanning the QR code on displays beside the rooms door',
      name: 'scanHelpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure you are scanning a valid room QR code`
  String get pleaseMakeSureYouAreScanningAValidRoomQRCode {
    return Intl.message(
      'Please make sure you are scanning a valid room QR code',
      name: 'pleaseMakeSureYouAreScanningAValidRoomQRCode',
      desc: '',
      args: [],
    );
  }

  /// `End time should be greater than start time`
  String get timeValidation {
    return Intl.message(
      'End time should be greater than start time',
      name: 'timeValidation',
      desc: '',
      args: [],
    );
  }

  /// `Request to book`
  String get requestToBook {
    return Intl.message(
      'Request to book',
      name: 'requestToBook',
      desc: '',
      args: [],
    );
  }

  /// `We received your request, and will send you update\nwithin 3hrs`
  String get requestBookTitle {
    return Intl.message(
      'We received your request, and will send you update\nwithin 3hrs',
      name: 'requestBookTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Request`
  String get cancelRequest {
    return Intl.message(
      'Cancel Request',
      name: 'cancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Please select date`
  String get dateValidation {
    return Intl.message(
      'Please select date',
      name: 'dateValidation',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get dateTime {
    return Intl.message(
      'Date & Time',
      name: 'dateTime',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAll {
    return Intl.message(
      'Show all',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `This is a required field !`
  String get thisFieldIsRequired {
    return Intl.message(
      'This is a required field !',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please select different slot that slot is not available`
  String get bookingAlert {
    return Intl.message(
      'Please select different slot that slot is not available',
      name: 'bookingAlert',
      desc: '',
      args: [],
    );
  }

  /// `Pending approval`
  String get pendingStatus {
    return Intl.message(
      'Pending approval',
      name: 'pendingStatus',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expireStatus {
    return Intl.message(
      'Expired',
      name: 'expireStatus',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activeStatus {
    return Intl.message(
      'Active',
      name: 'activeStatus',
      desc: '',
      args: [],
    );
  }

  /// `Logged`
  String get loggedStatus {
    return Intl.message(
      'Logged',
      name: 'loggedStatus',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upComing {
    return Intl.message(
      'Upcoming',
      name: 'upComing',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Search by booking title`
  String get searchByBookingTitle {
    return Intl.message(
      'Search by booking title',
      name: 'searchByBookingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Show filtered rooms`
  String get showFilterRooms {
    return Intl.message(
      'Show filtered rooms',
      name: 'showFilterRooms',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get bookingDetails {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Idea Generation with Client`
  String get ideaGenerationWithClient {
    return Intl.message(
      'Idea Generation with Client',
      name: 'ideaGenerationWithClient',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate`
  String get duplicate {
    return Intl.message(
      'Duplicate',
      name: 'duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Logged`
  String get logged {
    return Intl.message(
      'Logged',
      name: 'logged',
      desc: '',
      args: [],
    );
  }

  /// `Host`
  String get host {
    return Intl.message(
      'Host',
      name: 'host',
      desc: '',
      args: [],
    );
  }

  /// `Guests`
  String get guests {
    return Intl.message(
      'Guests',
      name: 'guests',
      desc: '',
      args: [],
    );
  }

  /// `Room Details`
  String get roomDetails {
    return Intl.message(
      'Room Details',
      name: 'roomDetails',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to Delete booking?`
  String get deleteMessageBooking {
    return Intl.message(
      'Are you sure you want to Delete booking?',
      name: 'deleteMessageBooking',
      desc: '',
      args: [],
    );
  }

  /// `Yeah`
  String get yeah {
    return Intl.message(
      'Yeah',
      name: 'yeah',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `or Add more items`
  String get addMoreItems {
    return Intl.message(
      'or Add more items',
      name: 'addMoreItems',
      desc: '',
      args: [],
    );
  }

  /// `Order now`
  String get orderNow {
    return Intl.message(
      'Order now',
      name: 'orderNow',
      desc: '',
      args: [],
    );
  }

  /// `Drinks ordered`
  String get drinkOrder {
    return Intl.message(
      'Drinks ordered',
      name: 'drinkOrder',
      desc: '',
      args: [],
    );
  }

  /// `NO Drinks TO SHOW`
  String get noDrinkToShow {
    return Intl.message(
      'NO Drinks TO SHOW',
      name: 'noDrinkToShow',
      desc: '',
      args: [],
    );
  }

  /// `You Ordered this by mistake?`
  String get orderByMistake {
    return Intl.message(
      'You Ordered this by mistake?',
      name: 'orderByMistake',
      desc: '',
      args: [],
    );
  }

  /// `Add to order`
  String get addToCart {
    return Intl.message(
      'Add to order',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Drinks Bag`
  String get drinksBag {
    return Intl.message(
      'Drinks Bag',
      name: 'drinksBag',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Invite Visitors`
  String get inviteVisitors {
    return Intl.message(
      'Invite Visitors',
      name: 'inviteVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Starting Date`
  String get startingDate {
    return Intl.message(
      'Starting Date',
      name: 'startingDate',
      desc: '',
      args: [],
    );
  }

  /// `Ending Date`
  String get endingDate {
    return Intl.message(
      'Ending Date',
      name: 'endingDate',
      desc: '',
      args: [],
    );
  }

  /// `Visitors`
  String get visitors {
    return Intl.message(
      'Visitors',
      name: 'visitors',
      desc: '',
      args: [],
    );
  }

  /// `Add previous visitors`
  String get addPreviousVisitor {
    return Intl.message(
      'Add previous visitors',
      name: 'addPreviousVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Add More Visitors`
  String get addMoreVisitors {
    return Intl.message(
      'Add More Visitors',
      name: 'addMoreVisitors',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Send Invitation`
  String get sendInvitation {
    return Intl.message(
      'Send Invitation',
      name: 'sendInvitation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get enterValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Previous Visitors`
  String get previousVisitors {
    return Intl.message(
      'Previous Visitors',
      name: 'previousVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Search from your visitors history`
  String get searchFromVisitorHistory {
    return Intl.message(
      'Search from your visitors history',
      name: 'searchFromVisitorHistory',
      desc: '',
      args: [],
    );
  }

  /// `Search Visitor`
  String get searchVisitor {
    return Intl.message(
      'Search Visitor',
      name: 'searchVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Pending verification`
  String get pendingVerification {
    return Intl.message(
      'Pending verification',
      name: 'pendingVerification',
      desc: '',
      args: [],
    );
  }

  /// `Add Visitors`
  String get addVisitors {
    return Intl.message(
      'Add Visitors',
      name: 'addVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Search by Visitor name`
  String get searchByVisitorName {
    return Intl.message(
      'Search by Visitor name',
      name: 'searchByVisitorName',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Details`
  String get invitationDetails {
    return Intl.message(
      'Invitation Details',
      name: 'invitationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Visits list`
  String get visitsList {
    return Intl.message(
      'Visits list',
      name: 'visitsList',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Unverified`
  String get unverified {
    return Intl.message(
      'Unverified',
      name: 'unverified',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Oops! You didn’t added any visitor yet`
  String get visitorEmptyMsg {
    return Intl.message(
      'Oops! You didn’t added any visitor yet',
      name: 'visitorEmptyMsg',
      desc: '',
      args: [],
    );
  }

  /// `NO VISITORS TO SHOW`
  String get noVisitors {
    return Intl.message(
      'NO VISITORS TO SHOW',
      name: 'noVisitors',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Sent`
  String get invitationSent {
    return Intl.message(
      'Invitation Sent',
      name: 'invitationSent',
      desc: '',
      args: [],
    );
  }

  /// `Invited visitors by mistake?`
  String get inviteByMistake {
    return Intl.message(
      'Invited visitors by mistake?',
      name: 'inviteByMistake',
      desc: '',
      args: [],
    );
  }

  /// `End date should be greater than start date`
  String get dateTimeCompareMsg {
    return Intl.message(
      'End date should be greater than start date',
      name: 'dateTimeCompareMsg',
      desc: '',
      args: [],
    );
  }

  /// `Note: The catering services are out of working hours at the moment, we will be happy to serve you again when the team is available`
  String get storeNotAvailable {
    return Intl.message(
      'Note: The catering services are out of working hours at the moment, we will be happy to serve you again when the team is available',
      name: 'storeNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Delivering to`
  String get deliveringTo {
    return Intl.message(
      'Delivering to',
      name: 'deliveringTo',
      desc: '',
      args: [],
    );
  }

  /// `Edit Booking`
  String get editBooking {
    return Intl.message(
      'Edit Booking',
      name: 'editBooking',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already used to invite another visitor you added. !`
  String get visitorAlreadyFound {
    return Intl.message(
      'This email address is already used to invite another visitor you added. !',
      name: 'visitorAlreadyFound',
      desc: '',
      args: [],
    );
  }

  /// `Guest Already Added`
  String get alreadyAdded {
    return Intl.message(
      'Guest Already Added',
      name: 'alreadyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Booking for`
  String get bookingFor {
    return Intl.message(
      'Booking for',
      name: 'bookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Please select future time`
  String get pastBookingAlert {
    return Intl.message(
      'Please select future time',
      name: 'pastBookingAlert',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `LogIn`
  String get login {
    return Intl.message(
      'LogIn',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR to book`
  String get scanQrToBook {
    return Intl.message(
      'Scan QR to book',
      name: 'scanQrToBook',
      desc: '',
      args: [],
    );
  }

  /// `Booking Created Successfully`
  String get bookingSlotSuccess {
    return Intl.message(
      'Booking Created Successfully',
      name: 'bookingSlotSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Order Sent Successfully`
  String get drinkOrderSuccess {
    return Intl.message(
      'Order Sent Successfully',
      name: 'drinkOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Sent Successfully`
  String get inviteVisitorSuccess {
    return Intl.message(
      'Invitation Sent Successfully',
      name: 'inviteVisitorSuccess',
      desc: '',
      args: [],
    );
  }

  /// `NO TICKETS TO SHOW`
  String get ticketEmpty {
    return Intl.message(
      'NO TICKETS TO SHOW',
      name: 'ticketEmpty',
      desc: '',
      args: [],
    );
  }

  /// `You didn’t raise any tickets yet`
  String get youDidNotRaiseAnyTicketsYet {
    return Intl.message(
      'You didn’t raise any tickets yet',
      name: 'youDidNotRaiseAnyTicketsYet',
      desc: '',
      args: [],
    );
  }

  /// `character !`
  String get character {
    return Intl.message(
      'character !',
      name: 'character',
      desc: '',
      args: [],
    );
  }

  /// `Max length of`
  String get maxLengthOf {
    return Intl.message(
      'Max length of',
      name: 'maxLengthOf',
      desc: '',
      args: [],
    );
  }

  /// `Profile Settings`
  String get profileSetting {
    return Intl.message(
      'Profile Settings',
      name: 'profileSetting',
      desc: '',
      args: [],
    );
  }

  /// `Handbook`
  String get handBook {
    return Intl.message(
      'Handbook',
      name: 'handBook',
      desc: '',
      args: [],
    );
  }

  /// `App Tour`
  String get appTour {
    return Intl.message(
      'App Tour',
      name: 'appTour',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get faq {
    return Intl.message(
      'FAQs',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Get Support`
  String get getSupport {
    return Intl.message(
      'Get Support',
      name: 'getSupport',
      desc: '',
      args: [],
    );
  }

  /// `Issue Description`
  String get issueDescription {
    return Intl.message(
      'Issue Description',
      name: 'issueDescription',
      desc: '',
      args: [],
    );
  }

  /// `Search Support`
  String get searchSupport {
    return Intl.message(
      'Search Support',
      name: 'searchSupport',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to Discard the ticket?`
  String get discardTheTicket {
    return Intl.message(
      'Are you sure you want to Discard the ticket?',
      name: 'discardTheTicket',
      desc: '',
      args: [],
    );
  }

  /// `Sub category`
  String get subCategory {
    return Intl.message(
      'Sub category',
      name: 'subCategory',
      desc: '',
      args: [],
    );
  }

  /// `Select item`
  String get selectItem {
    return Intl.message(
      'Select item',
      name: 'selectItem',
      desc: '',
      args: [],
    );
  }

  /// `Search by description`
  String get searchByDescription {
    return Intl.message(
      'Search by description',
      name: 'searchByDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please select fill data`
  String get fillAllData {
    return Intl.message(
      'Please select fill data',
      name: 'fillAllData',
      desc: '',
      args: [],
    );
  }

  /// `Please fill description`
  String get fillDescription {
    return Intl.message(
      'Please fill description',
      name: 'fillDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Team`
  String get selectTeam {
    return Intl.message(
      'Please Select Team',
      name: 'selectTeam',
      desc: '',
      args: [],
    );
  }

  /// `Please select subcategory`
  String get selectSubCategory {
    return Intl.message(
      'Please select subcategory',
      name: 'selectSubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment...`
  String get addComment {
    return Intl.message(
      'Add a comment...',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Please enter comment`
  String get commentAlert {
    return Intl.message(
      'Please enter comment',
      name: 'commentAlert',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get lang {
    return Intl.message(
      'العربية',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `We offer password-less experience to authorized users`
  String get weOfferPasswordExperience {
    return Intl.message(
      'We offer password-less experience to authorized users',
      name: 'weOfferPasswordExperience',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive an email? `
  String get receiveAnEmail {
    return Intl.message(
      'Didn’t receive an email? ',
      name: 'receiveAnEmail',
      desc: '',
      args: [],
    );
  }

  /// `resend email`
  String get resendEmail {
    return Intl.message(
      'resend email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Hi `
  String get hi {
    return Intl.message(
      'Hi ',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `On behalf of Co-builder team,we are thrilled to have you onboard.`
  String get OnBehalfOfCoBuilderTeam {
    return Intl.message(
      'On behalf of Co-builder team,we are thrilled to have you onboard.',
      name: 'OnBehalfOfCoBuilderTeam',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `On behalf of Co-builder team, we are thrilled to have you onboard.`
  String get thrilledToHaveYouOnboard {
    return Intl.message(
      'On behalf of Co-builder team, we are thrilled to have you onboard.',
      name: 'thrilledToHaveYouOnboard',
      desc: '',
      args: [],
    );
  }

  /// `Id Number`
  String get idNumber {
    return Intl.message(
      'Id Number',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Face ID`
  String get faceID {
    return Intl.message(
      'Face ID',
      name: 'faceID',
      desc: '',
      args: [],
    );
  }

  /// `Use your face ID as you Access-Pass to Co-builder`
  String get useYourFaceIDAsyYouAccessPassToCoBuilder {
    return Intl.message(
      'Use your face ID as you Access-Pass to Co-builder',
      name: 'useYourFaceIDAsyYouAccessPassToCoBuilder',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Scan later`
  String get scanLater {
    return Intl.message(
      'Scan later',
      name: 'scanLater',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Scan Again`
  String get scanAgain {
    return Intl.message(
      'Scan Again',
      name: 'scanAgain',
      desc: '',
      args: [],
    );
  }

  /// `Expiring in`
  String get expiredIn {
    return Intl.message(
      'Expiring in',
      name: 'expiredIn',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Support Status`
  String get supportStatus {
    return Intl.message(
      'Support Status',
      name: 'supportStatus',
      desc: '',
      args: [],
    );
  }

  /// `Last Activity`
  String get lastActivity {
    return Intl.message(
      'Last Activity',
      name: 'lastActivity',
      desc: '',
      args: [],
    );
  }

  /// `hrs`
  String get hrs {
    return Intl.message(
      'hrs',
      name: 'hrs',
      desc: '',
      args: [],
    );
  }

  /// `Coming Visitor`
  String get comingVisitor {
    return Intl.message(
      'Coming Visitor',
      name: 'comingVisitor',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinks {
    return Intl.message(
      'Drinks',
      name: 'drinks',
      desc: '',
      args: [],
    );
  }

  /// `Hub`
  String get hub {
    return Intl.message(
      'Hub',
      name: 'hub',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Visits`
  String get visits {
    return Intl.message(
      'Visits',
      name: 'visits',
      desc: '',
      args: [],
    );
  }

  /// `Support Tickets`
  String get supportTickets {
    return Intl.message(
      'Support Tickets',
      name: 'supportTickets',
      desc: '',
      args: [],
    );
  }

  /// `Search Hub`
  String get searchHub {
    return Intl.message(
      'Search Hub',
      name: 'searchHub',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get readMore {
    return Intl.message(
      'Read More',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Search Nationality`
  String get searchNationality {
    return Intl.message(
      'Search Nationality',
      name: 'searchNationality',
      desc: '',
      args: [],
    );
  }

  /// `Id type`
  String get idType {
    return Intl.message(
      'Id type',
      name: 'idType',
      desc: '',
      args: [],
    );
  }

  /// `Search Services`
  String get searchService {
    return Intl.message(
      'Search Services',
      name: 'searchService',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message(
      'Take Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
