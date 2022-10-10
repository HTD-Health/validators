import 'package:flutter_test/flutter_test.dart';
import 'package:validator/validator.dart';

void main() {
  group('Validators.notEmpty -', () {
    group('trim is true -', () {
      final Validator validator =
          Validators.notEmpty(errorMessage: 'error', trim: true);
      String? errorMessage;

      test('returns no error when called with null', () {
        errorMessage = validator.call(null);
        expect(errorMessage, null);
      });
      test('returns error when called with empty string', () {
        errorMessage = validator.call('');
        expect(errorMessage, 'error');
      });
      test('returns error when called with string with only spaces', () {
        errorMessage = validator.call('   ');
        expect(errorMessage, 'error');
      });
      test('does not return error when called with non-empty string', () {
        errorMessage = validator.call('abcd');
        expect(errorMessage, null);

        errorMessage = validator.call('-1');
        expect(errorMessage, null);
      });
    });

    group('trim is false -', () {
      final Validator validator =
          Validators.notEmpty(errorMessage: 'error', trim: false);
      String? errorMessage;

      test('does not return error when called with only spaces', () {
        errorMessage = validator.call('   ');
        expect(errorMessage, null);
      });
      test('returns no error when called with null', () {
        errorMessage = validator.call(null);
        expect(errorMessage, null);
      });
    });
  });

  group('Validators.email -', () {
    final Validator validator = Validators.email(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with non-email string', () {
      errorMessage = validator.call('abc');
      expect(errorMessage, 'error');

      errorMessage = validator.call('   ');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1');
      expect(errorMessage, 'error');

      errorMessage = validator.call('test@test');
      expect(errorMessage, 'error');

      errorMessage = validator.call('test@test.');
      expect(errorMessage, 'error');

      errorMessage = validator.call('@test.com');
      expect(errorMessage, 'error');
    });
    test('does not retrun error when called with email string', () {
      errorMessage = validator.call('test@test.com');
      expect(errorMessage, null);

      errorMessage = validator.call('test123@test.com');
      expect(errorMessage, null);

      errorMessage = validator.call('test+1@test.com');
      expect(errorMessage, null);

      errorMessage = validator.call('test+1@test.c');
      expect(errorMessage, null);
    });
  });

  group('Validators.integer', () {
    final Validator validator = Validators.integer(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with non-integer string', () {
      errorMessage = validator.call('a');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1,2');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1.2');
      expect(errorMessage, 'error');

      errorMessage = validator.call('!');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10-');
      expect(errorMessage, 'error');

      errorMessage = validator.call('   ');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with proper integer string', () {
      errorMessage = validator.call('0');
      expect(errorMessage, null);

      errorMessage = validator.call('1');
      expect(errorMessage, null);

      errorMessage = validator.call('-1');
      expect(errorMessage, null);

      errorMessage = validator.call('1000');
      expect(errorMessage, null);

      errorMessage = validator.call('-1000');
      expect(errorMessage, null);

      errorMessage = validator.call('1000000');
      expect(errorMessage, null);

      errorMessage = validator.call('-1000000');
      expect(errorMessage, null);
    });
  });

  group('Validators.double', () {
    final Validator validator = Validators.double(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with non-double string', () {
      errorMessage = validator.call('a');
      expect(errorMessage, 'error');

      errorMessage = validator.call('!');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10-');
      expect(errorMessage, 'error');

      errorMessage = validator.call('   ');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1.2.3');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1,2,3');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with proper double string', () {
      errorMessage = validator.call('0');
      expect(errorMessage, null);

      errorMessage = validator.call('1,2');
      expect(errorMessage, null);

      errorMessage = validator.call('1.2');
      expect(errorMessage, null);

      errorMessage = validator.call('-1,2');
      expect(errorMessage, null);

      errorMessage = validator.call('-1.2');
      expect(errorMessage, null);

      errorMessage = validator.call('1');
      expect(errorMessage, null);

      errorMessage = validator.call('-1');
      expect(errorMessage, null);

      errorMessage = validator.call('01');
      expect(errorMessage, null);

      errorMessage = validator.call('000111');
      expect(errorMessage, null);
    });
  });

  group('Validators.number -', () {
    final Validator validator = Validators.number(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with non-number string', () {
      errorMessage = validator.call('a');
      expect(errorMessage, 'error');

      errorMessage = validator.call('!');
      expect(errorMessage, 'error');

      errorMessage = validator.call('   ');
      expect(errorMessage, 'error');

      errorMessage = validator.call('e19');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1.2.3');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with number string', () {
      errorMessage = validator.call('1');
      expect(errorMessage, null);

      errorMessage = validator.call('1.2');
      expect(errorMessage, null);

      errorMessage = validator.call('1,2');
      expect(errorMessage, null);

      errorMessage = validator.call('19.00');
      expect(errorMessage, null);

      errorMessage = validator.call('000110');
      expect(errorMessage, null);
    });
  });

  group('Validators.sizeInRange', () {
    late Validator validator;
    setUp(() {
      validator = Validators.sizeInRange(
        minSize: 2,
        maxSize: 6,
        smallerThanMinError: 'Error string',
        largerThanMaxError: 'Error string',
      );
    });

    test('does not allow values shorter than minimum', () {
      expect(validator.call('1'), 'Error string');
    });

    test('does not allow values longer than max', () {
      expect(validator.call('1234567'), 'Error string');
    });
  });

  group('Validators.maximumLength', () {
    late Validator validator;

    setUp(() {
      validator = Validators.maximumLength(
        maxSize: 3,
        errorMessage: 'Error string',
      );
    });

    test('does not allow values longer than minimum', () {
      expect(validator.call('1234'), 'Error string');
    });
  });

  group('Validators.minimumLength', () {
    late Validator validator;

    setUp(() {
      validator = Validators.minimumLength(
        minSize: 3,
        errorMessage: 'Error string',
      );
    });

    test('does not allow values shorter than minimum', () {
      expect(validator.call('12'), 'Error string');
    });
  });

  group('Validators.positiveNumber', () {
    final Validator validator =
        Validators.positiveNumber(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with non positive number', () {
      errorMessage = validator.call('-1');
      expect(errorMessage, 'error');

      errorMessage = validator.call('-1.5');
      expect(errorMessage, 'error');

      errorMessage = validator.call('-1,5');
      expect(errorMessage, 'error');

      errorMessage = validator.call('-1000');
      expect(errorMessage, 'error');

      errorMessage = validator.call('-0');
      expect(errorMessage, 'error');

      errorMessage = validator.call('-0.0');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with positive number or zero', () {
      errorMessage = validator.call('0');
      expect(errorMessage, null);

      errorMessage = validator.call('0.0');
      expect(errorMessage, null);

      errorMessage = validator.call('10.0');
      expect(errorMessage, null);

      errorMessage = validator.call('0,0');
      expect(errorMessage, null);

      errorMessage = validator.call('100');
      expect(errorMessage, null);
    });
  });

  group('Validators.largerThan', () {
    final Validator validator =
        Validators.largerThan(errorMessage: 'error', threshold: 10);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with not a number string', () {
      errorMessage = validator.call('a');
      expect(errorMessage, 'error');

      errorMessage = validator.call('!');
      expect(errorMessage, 'error');
    });
    test('returns error when called with number lower then threshold', () {
      errorMessage = validator.call('9');
      expect(errorMessage, 'error');

      errorMessage = validator.call('0');
      expect(errorMessage, 'error');

      errorMessage = validator.call('9.9');
      expect(errorMessage, 'error');

      errorMessage = validator.call('9,9999');
      expect(errorMessage, 'error');
    });
    test('returns error when called with number equal to threshold', () {
      errorMessage = validator.call('10');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10.0');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10,00');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with number larger then threshold',
        () {
      errorMessage = validator.call('10.1');
      expect(errorMessage, null);

      errorMessage = validator.call('10,1');
      expect(errorMessage, null);

      errorMessage = validator.call('11');
      expect(errorMessage, null);

      errorMessage = validator.call('1000');
      expect(errorMessage, null);
    });
  });

  group('Validators.smallerThan', () {
    final Validator validator =
        Validators.smallerThan(errorMessage: 'error', threshold: 10);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with not a number string', () {
      errorMessage = validator.call('a');
      expect(errorMessage, 'error');

      errorMessage = validator.call('!');
      expect(errorMessage, 'error');
    });
    test('returns error when called with number higher then threshold', () {
      errorMessage = validator.call('10.1');
      expect(errorMessage, 'error');

      errorMessage = validator.call('11');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10,11');
      expect(errorMessage, 'error');

      errorMessage = validator.call('100.0');
      expect(errorMessage, 'error');
    });
    test('returns error when called with number equal to threshold', () {
      errorMessage = validator.call('10');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10.0');
      expect(errorMessage, 'error');

      errorMessage = validator.call('10,00');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with number smaller then threshold',
        () {
      errorMessage = validator.call('9.1');
      expect(errorMessage, null);

      errorMessage = validator.call('9,1');
      expect(errorMessage, null);

      errorMessage = validator.call('1');
      expect(errorMessage, null);

      errorMessage = validator.call('-9');
      expect(errorMessage, null);
    });
  });

  group('Validators.hasDigits -', () {
    String? errorMessage;

    group('minDigitsCount is 1 -', () {
      final Validator validator = Validators.hasDigits(errorMessage: 'error');

      test('does not return error when called with null', () {
        errorMessage = validator.call(null);
        expect(errorMessage, null);
      });
      test('returns error when called with empty string', () {
        errorMessage = validator.call('');
        expect(errorMessage, 'error');
      });
      test('returns error when called with string not containing any digits',
          () {
        errorMessage = validator.call('abcd');
        expect(errorMessage, 'error');
      });
      test(
          'does not return error when called with value containing '
          'at least 1 digit', () {
        errorMessage = validator.call('abc1def');
        expect(errorMessage, null);

        errorMessage = validator.call('abc123def');
        expect(errorMessage, null);

        errorMessage = validator.call('1');
        expect(errorMessage, null);

        errorMessage = validator.call('1.23abc');
        expect(errorMessage, null);
      });
    });

    group('minDigitsCount is 4', () {
      final Validator validator =
          Validators.hasDigits(errorMessage: 'error', minDigitsCount: 4);
      test(
          'does not return error when called with value containing at least'
          ' minDigitsCount digits', () {
        errorMessage = validator.call('abc1234def');
        expect(errorMessage, null);

        errorMessage = validator.call('abc12345def');
        expect(errorMessage, null);
      });
      test(
          'returns error when called with value containing less than'
          ' minDigitsCount digits', () {
        errorMessage = validator.call('abc123def');
        expect(errorMessage, 'error');

        errorMessage = validator.call('abc');
        expect(errorMessage, 'error');
      });
    });
  });

  group('Validators.sameAs', () {
    final Validator validator =
        Validators.sameAs(errorMessage: 'error', other: 'other');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('does not return error when called with mathing values', () {
      errorMessage = validator.call('other');
      expect(errorMessage, null);
    });
    test('returns error when called with non-mathing values', () {
      errorMessage = validator.call('different');
      expect(errorMessage, 'error');
    });
  });

  group('Validators.oneOf -', () {
    final Validator validator = Validators.oneOf([
      Validators.notEmpty(errorMessage: 'error1'),
      Validators.email(errorMessage: 'error2'),
    ]);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns first validator error when first validator failes', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error1');
    });
    test(
        'returns second validator error when the first validator passess but '
        'the second one does not', () {
      errorMessage = validator.call('asdasd');
      expect(errorMessage, 'error2');
    });
    test('does not return error when all validators pass', () {
      errorMessage = validator.call('test@test.com');
      expect(errorMessage, null);
    });
  });

  group('Validators.all -', () {
    final Validator validator = Validators.all([
      Validators.integer(errorMessage: 'error1'),
      Validators.positiveNumber(errorMessage: 'error2'),
      Validators.largerThan(errorMessage: 'error2', threshold: 10),
    ]);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test(
        'returns second validator error when the 1st and 3rd validators'
        ' pass but the 2nd does not', () {
      errorMessage = validator.call('5');
      expect(errorMessage, 'error2');
    });
    test('does not return error when all validators pass', () {
      errorMessage = validator.call('12');
      expect(errorMessage, null);
    });
  });

  group('Validators.exactLength -', () {
    final Validator validator =
        Validators.exactLength(errorMessage: 'error', length: 4);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with different length', () {
      errorMessage = validator.call('1');
      expect(errorMessage, 'error');

      errorMessage = validator.call('');
      expect(errorMessage, 'error');

      errorMessage = validator.call('11');
      expect(errorMessage, 'error');

      errorMessage = validator.call('111');
      expect(errorMessage, 'error');

      errorMessage = validator.call('11111');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1 1  ');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1234  ');
      expect(errorMessage, 'error');

      errorMessage = validator.call(' 12 4');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with exact length', () {
      errorMessage = validator.call('1234');
      expect(errorMessage, null);

      errorMessage = validator.call('12 4');
      expect(errorMessage, null);
    });
  });

  group('Validators.exactLengths -', () {
    final Validator validator =
        Validators.exactLengths(errorMessage: 'error', lengths: [3, 4]);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with not supported length', () {
      errorMessage = validator.call('1');
      expect(errorMessage, 'error');

      errorMessage = validator.call('');
      expect(errorMessage, 'error');

      errorMessage = validator.call('11');
      expect(errorMessage, 'error');

      errorMessage = validator.call('11111');
      expect(errorMessage, 'error');

      errorMessage = validator.call('1234  ');
      expect(errorMessage, 'error');

      errorMessage = validator.call('   123');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with supported length', () {
      errorMessage = validator.call('1234');
      expect(errorMessage, null);

      errorMessage = validator.call('12 4');
      expect(errorMessage, null);

      errorMessage = validator.call('123');
      expect(errorMessage, null);
    });
  });

  group('Validators.hasUppercaseLetters -', () {
    final Validator validator =
        Validators.hasUppercaseLetters(errorMessage: 'error');
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with no uppercase letters', () {
      errorMessage = validator.call('only lowercase letters here');
      expect(errorMessage, 'error');

      errorMessage = validator.call('abc');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with 1 or more uppercase letters',
        () {
      errorMessage = validator.call('Uppercase letter here');
      expect(errorMessage, null);

      errorMessage = validator.call('ALL CAPS');
      expect(errorMessage, null);
    });
  });

  group('Validators.numberValueInRange -', () {
    final Validator validator =
        Validators.numberValueInRange(errorMessage: 'error', min: 5, max: 8);
    String? errorMessage;

    test('does not return error when called with null', () {
      errorMessage = validator.call(null);
      expect(errorMessage, null);
    });
    test('returns error when called with empty string', () {
      errorMessage = validator.call('');
      expect(errorMessage, 'error');
    });
    test('returns error when called with number not in range', () {
      errorMessage = validator.call('4');
      expect(errorMessage, 'error');

      errorMessage = validator.call('4.9');
      expect(errorMessage, 'error');

      errorMessage = validator.call('4,9');
      expect(errorMessage, 'error');
    });
    test('does not return error when called with number in range', () {
      errorMessage = validator.call('5');
      expect(errorMessage, null);

      errorMessage = validator.call('5,0');
      expect(errorMessage, null);

      errorMessage = validator.call('5.0');
      expect(errorMessage, null);

      errorMessage = validator.call('5.5');
      expect(errorMessage, null);

      errorMessage = validator.call('5,5');
      expect(errorMessage, null);

      errorMessage = validator.call('6');
      expect(errorMessage, null);

      errorMessage = validator.call('8');
      expect(errorMessage, null);

      errorMessage = validator.call('8.0');
      expect(errorMessage, null);
    });
  });
}
