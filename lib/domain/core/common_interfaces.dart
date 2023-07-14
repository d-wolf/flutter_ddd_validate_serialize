/// Used as a base class for failures in value objects and use cases.
abstract interface class Failure {}

abstract interface class Validatable {
  bool isValid();
}

abstract interface class Serializable {
  Map<String, dynamic> toJson();
}
