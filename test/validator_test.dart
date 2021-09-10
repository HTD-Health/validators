import 'package:flutter_test/flutter_test.dart';
import 'package:validator/validator.dart';

void main() {
  group('Validators.notEmpty -', () {
    group('trim is true -', () {
      Validator validator = Validators.notEmpty(errorMessage: 'error', trim: true);
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
      Validator validator = Validators.notEmpty(errorMessage: 'error', trim: false);
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

  group('Validators.isEmail -', () {
    Validator validator = Validators.email(errorMessage: 'error');
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

  group('Validators.isInt', () {
    Validator validator = Validators.integer(errorMessage: 'error');
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

  group('Validators.isDouble', () {
    Validator validator = Validators.double(errorMessage: 'error');
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

  group('Validators.isNumber -', () {
    Validator validator = Validators.number(errorMessage: 'error');
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

  group('Validators.positiveNumber', () {
    Validator validator = Validators.positiveNumber(errorMessage: 'error');
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
    Validator validator = Validators.largerThan(errorMessage: 'error', threshold: 10);
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
    test('does not return error when called with number larger then threshold', () {
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

  group('Validators.oneOf -', () {
    Validator validator = Validators.oneOf([
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
    test('returns second validator error when the first validator passess but the second one does not', () {
      errorMessage = validator.call('asdasd');
      expect(errorMessage, 'error2');
    });
    test('does not return error when all validators pass', () {
      errorMessage = validator.call('test@test.com');
      expect(errorMessage, null);
    });
  });
}
