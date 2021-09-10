import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart';
import 'package:validators/validators.dart' as validators;

typedef Validator = String? Function(String?);

extension Validation on String {
  bool get isEmail => validators.isEmail(this);
  bool get isInt => int.tryParse(this) != null;
  bool get isDouble => double.tryParse(this.replaceFirst(',', '.')) != null;
  bool get isNumber => this.isInt || this.isDouble;
  bool get isNumeric => validators.isNumeric(this);
  bool get isCreditCard => validators.isCreditCard(this);
  bool get isDate => validators.isDate(this);
  bool get isHexColor => validators.isHexColor(this);
  bool get isIp => validators.isIP(this);
}

abstract class Validators {
  /// All validators provided in [validators] list must pass.
  static Validator all(
    List<Validator> validators, {
    bool successOnEmpty = false,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        if (successOnEmpty && value.isEmpty == true) {
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
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        String? error;

        for (final validator in validators) {
          final validationError = validator(value);
          if (validationError == null) continue;
          error ??= validationError;
        }
        return error;
      };

  /// Used when validator is needed to be run against value in place of code,
  /// without depending on tear off mechanic.
  static String? manyPreSupplied({
    required String value,
    required List<Validator> validators,
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

  /// Returns [errorMessage] if field is empty.
  /// Can be understand as a `required` validator.
  static Validator notEmpty({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        return value.isEmpty ? errorMessage : null;
      };

  /// Returns [errorMessage] when the value is not a valid email.
  static Validator email({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        return value.isEmail ? null : errorMessage;
      };

  /// Returns [errorMessage] when the value is not an integer.
  static Validator integer({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        return value.isInt ? null : errorMessage;
      };

  /// Returns [errorMessage] when the value is not a double.
  static Validator double({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        return value.isDouble ? null : errorMessage;
      };

  /// Returns [errorMessage] when the value is not a double or an integer.
  static Validator number({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        if (value.isInt) return null;
        if (value.isDouble) return null;
        return errorMessage;
      };

  /// This method is counting characters instead of the string length, thanks to that every
  /// emoji will be counted as a single char instead of the real string length:
  ///
  /// example:
  /// ```
  /// '👩‍👩‍👧‍👦'.length // → 11
  /// '👩‍👩‍👧‍👦'.characters.length // → 1
  /// ```
  static Validator sizeInRange({
    required int minSize,
    required int maxSize,
    required String smallerThanMinError,
    required String largerThanMaxError,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        if (value.length < minSize) {
          return smallerThanMinError;
        } else if (value.characters.length > maxSize) {
          return largerThanMaxError;
        } else {
          return null;
        }
      };

  /// Returns [errorMessage] when the value is not empty.
  static Validator empty({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        return value.isEmpty ? null : errorMessage;
      };

  /// Returns [errorMessage] when the value contains characters other then numbers.
  static Validator numeric({
    required errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        return value.isNumeric ? null : errorMessage;
      };

  /// Returns [errorMessage] when value is not a number within provided [min]-[max] range.
  static Validator numberValueInRange({
    required String errorMessage,
    required num min,
    required num max,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        if (value.isEmpty) return errorMessage;

        final number = num.parse(value.replaceFirst(',', '.'));

        if (number < min || number > max) {
          return errorMessage;
        } else {
          return null;
        }
      };

  /// Returns [errorMessage] when value length is not equal to [length]
  static Validator exactLength({
    required String errorMessage,
    required int length,
    bool trim = true,
  }) =>
      (String? value) {
        assert(length >= 0, 'length must be greater than or equal to 0');
        if (value == null) return null;
        if (trim) value = value.trim();

        return value.length != length ? errorMessage : null;
      };

  /// Returns [errorMessage] when value length is not one of [lengths]
  static Validator exactLengths({
    required String errorMessage,
    required List<int> lengths,
    bool trim = true,
  }) =>
      (String? value) {
        assert(lengths.isNotEmpty, 'lengths must contain at least one element');
        if (value == null) return null;
        if (trim) value = value.trim();

        if (!lengths.contains(value.length)) {
          return errorMessage;
        }
        return null;
      };

  /// Returns [errorMessage] when value does not contain at least [minUppercaseLettersCount] uppercase letters.
  static Validator hasUppercaseLetters({
    required String errorMessage,
    int minUppercaseLettersCount = 1,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        int count = 0;

        for (int i = 0; i < value.length; i++) {
          final String letter = value[i];
          if (letter == ' ') continue;
          if (validators.isUppercase(letter)) {
            count++;
          }
        }

        if (count < minUppercaseLettersCount) {
          return errorMessage;
        }
        return null;
      };

  /// Returns [errorMessage] when value does not contain at least [minDigitsCount] digits
  static Validator hasDigits({
    required String errorMessage,
    int minDigitsCount = 1,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();

        int count = 0;
        for (int i = 0; i < value.length; i++) {
          final String letter = value[i];
          if (validators.isNumeric(letter)) {
            count++;
          }
        }
        if (count < minDigitsCount) {
          return errorMessage;
        }
        return null;
      };

  /// Returns [errorMessage] when value is not equal to [other].
  static Validator sameAs({
    required String errorMessage,
    required String other,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) {
          value = value.trim();
          other = other.trim();
        }
        return value == other ? null : errorMessage;
      };

  /// Returns [errorMessage] when value is not larger or equal to 0.
  static Validator positiveNumber({
    required String errorMessage,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        if (!value.isNumber) return errorMessage;
        if (value == '-0') return errorMessage;
        final number = num.parse(value.replaceFirst(',', '.'));
        return number.isNegative ? errorMessage : null;
      };

  /// Returns [errorMessage] when value is not larger then [threshold].
  static Validator largerThan({
    required String errorMessage,
    required num threshold,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        if (!value.isNumber) return errorMessage;
        final number = num.parse(value.replaceFirst(',', '.'));
        return number <= threshold ? errorMessage : null;
      };

  /// Returns [errorMessage] when value is not smaller then [threshold].
  static Validator smallerThan({
    required String errorMessage,
    required num threshold,
    bool trim = true,
  }) =>
      (String? value) {
        if (value == null) return null;
        if (trim) value = value.trim();
        if (!value.isNumber) return errorMessage;
        final number = num.parse(value.replaceFirst(',', '.'));
        return number >= threshold ? errorMessage : null;
      };
}
