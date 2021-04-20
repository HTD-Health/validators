import 'package:flutter/foundation.dart';
import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart';
import 'package:validator/src/type_defs.dart';
import 'package:validators/validators.dart' as validators;

extension Validation on String {
  bool get isEmail => validators.isEmail(this);
  bool get isInt => validators.isInt(this);
  bool get isDouble => validators.isFloat(this);
  bool get isNumeric => validators.isNumeric(this);
  bool get isCreditCard => validators.isCreditCard(this);
  bool get isDate => validators.isDate(this);
  bool get isHexColor => validators.isHexColor(this);
  bool get isIp => validators.isIP(this);
}

abstract class Validators {
  Validators._();

  /// All validators provided in [validators] list must pass.
  static Validator many(
    List<Validator> validators, {
    bool successOnEmpty = false,
    bool trim = false,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        if (successOnEmpty && value.isEmpty) {
          return null;
        }

        for (final validator in validators) {
          final error = validator(value);
          if (error != null) return error;
        }
        return null;
      };

  /// At least one validator must be valid,
  /// otherwise first error will be returned.
  static Validator oneOf(
    List<Validator> validators, {
    bool trim = false,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        String error;
        for (final validator in validators) {
          final validationError = validator(value);

          if (validationError == null) return null;

          error ??= validationError;
        }
        return error;
      };

  /// Used when validator is needed to be run against value in place of code,
  /// without depending on tear off mechanic.
  static String manyPreSupplied({
    @required String value,
    @required List<Validator> validators,
  }) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }

  /// Simple wrapper for custom validation (syntax sugar).
  /// Enables following syntax
  /// ```
  /// Validators.many([
  ///   Validators.isNotEmpty(errorMessage: "Cannot be empty"),
  ///   Validators.custom(isValidCode),
  /// ])
  /// ```
  static Validator custom(Validator validator) => validator;

  /// Returns an [errorMessage] if field is empty.
  /// Can be understand as a `required` validator.
  static Validator notEmpty({
    @required String errorMessage,
    bool trim = true,
  }) =>
      (String value) => value?.trim()?.isEmpty == true ? errorMessage : null;

  static Validator email({
    @required String errorMessage,
  }) =>
      (String value) => value.isEmail ? null : errorMessage;

  /// This method is counting characters instead of the string length, thanks to that every
  /// emoji will be counted as a single char instead instead of the real string length:
  ///
  /// example:
  /// ```
  /// '👩‍👩‍👧‍👦'.length // → 11
  /// '👩‍👩‍👧‍👦'.characters.length // → 1
  /// ```
  static Validator sizeInRange({
    @required int minSize,
    @required int maxSize,
    @required String smallerThanMinError,
    @required String largerThanMaxError,
    bool trim = false,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        if (value.length < minSize) {
          return smallerThanMinError;
        } else if (value.characters.length > maxSize) {
          return largerThanMaxError;
        } else {
          return null;
        }
      };

  /// Returns an [errorMessage] when the field is not empty.
  static Validator empty({
    @required String errorMessage,
    bool trim = true,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        if (value.isEmpty) {
          return null;
        } else {
          return errorMessage;
        }
      };

  /// Returns an [errorMessage] when the value of a field is not a valid integer.
  static Validator integer({
    @required errorMessage,
    bool trim = true,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        return value.isInt ? null : errorMessage;
      };

  /// Returns an [errorMessage] when the value of a field contains characters other then numbers.
  static Validator numeric({
    @required errorMessage,
    bool trim = true,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        return value.isNumeric ? null : errorMessage;
      };

  /// Returns an [errorMessage] when the value of a field is not a valid double.
  static Validator doubleValue({
    @required errorMessage,
    bool trim = true,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        return value.isDouble ? null : errorMessage;
      };

  ///Returns [errorMessage] when field value is not a [num] within provided [min]-[max] range.
  static Validator numberValueInRange({
    @required String errorMessage,
    @required num min,
    @required num max,
  }) =>
      (String value) {
        final number = num.parse(value);

        if (number < min || number > max) {
          return errorMessage;
        } else {
          return null;
        }
      };

  /// Returns an [errorMessage] when field value length is not equal to [length]
  static Validator exactLength({
    @required String errorMessage,
    @required int length,
    bool trim = false,
  }) =>
      (String value) {
        if (trim) {
          value = value.trim();
        }

        return value.length != length ? errorMessage : null;
      };

  /// Same as [exactLength] but accepts array of all valid lengths.
  static Validator exactLengths({
    @required String errorMessage,
    @required List<int> lengths,
  }) =>
      (String value) {
        assert(
          lengths.isNotEmpty,
          'Acceptable lengths must contian at least one element',
        );

        if (!lengths.contains(value.length)) {
          return errorMessage;
        }
        return null;
      };

  static Validator hasUppercaseLetters({
    @required String errorMessage,
    int uppercaseLettersCount = 1,
  }) =>
      (String value) {
        int count = 0;

        for (int i = 0; i < value.length; i++) {
          final String letter = value[i];
          if (validators.isUppercase(letter)) {
            count++;
          }
        }

        if (count < uppercaseLettersCount) {
          return errorMessage;
        }
        return null;
      };

  static Validator hasNumbers({
    @required String errorMessage,
    int numbersCount = 1,
  }) =>
      (String value) {
        int count = 0;
        for (int i = 0; i < value.length; i++) {
          final String letter = value[i];
          if (validators.isNumeric(letter)) {
            count++;
          }
        }
        if (count < numbersCount) {
          return errorMessage;
        }
        return null;
      };

  static Validator sameAs({
    @required String errorMessage,
    TextEditingController controller,
  }) =>
      (String text) => controller.value.text != text ? errorMessage : null;

  ///Returns [errorMessage] when field value is not a [num] > 0.
  static Validator positiveNumber({
    @required String errorMessage,
  }) =>
      (String value) {
        if (!value.isDouble) return errorMessage;
        final number = num.parse(value);
        return number <= 0 ? errorMessage : null;
      };
}
