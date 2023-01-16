import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerFailure extends Failure {}

class TimeoutFailure extends Failure {}


//NLP failures
class NlpNoPathFound extends Failure {}
