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
