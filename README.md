# validator

Simple TextFormField validator utility.

## Getting Started

```yaml
dependencies:
  widgets_library:
    git: 
      url: https://github.com/HTD-Health/validators.git
      ref: 0.1.0
```

## Usage

```dart
Form(
  key: controller.formKey,
  child: TextFormField(
    validator: Validators.many([
      Validators.notEmpty(errorMessage: 'Field cannot be empty'),
      Validators.oneOf([
        Validators.exactLength(
          length: 6,
          errorMessage: 'Field must have length of 6',
        ),
        Validators.custom((String value) => 
          value !== '0' ? 'bad value' : null,
        ),
      ]),
    ], trim: true),
  ),
);
```