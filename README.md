# Card Settings control

A flutter settings control panel with a bunch of canned field options.

![Screenshot](https://github.com/codegrue/card_settings/blob/master/images/example.gif)

This package consists of a CardSettings layout wrapper and a series of form field options including:

- CardSettingsText - Basic text field
- CardSettingsParagraph - Multiline text field with counter
- CardSettingsDouble - Field for double precision numbers
- CardSettingsInt - Field for integer numbers
- CardSettingsSwitch - Field for boolean state 
- CardSettingsListPicker - Picker list of user provided options
- CardSettingsNumberPicker - Picker list of numbers in a given range
- CardSettingsColorPicker - RBG Color Picker
- CardSettingsDatePicker - Material Design Date Picker
- CardSettingsTimePicker - Material Design Time Picker

All fields support `validate`, `onSaved`, and `autoValidate`.

The package also includes these additonal items:

- CardSettingsField - The base layout widget. You can use this to build custom fields.
- CardSettingsHeader - A control to put a header between form sections.
- Converters - a set of utility functions to assist in converting data into and out of the fields.

## Usage
To use this package, add `card_settings` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

``` dart
    card_settings: ^0.1.1
```

All fields in this package are compatible with the standard Flutter Form widget. Simply wrap the CardSettings control in a form and use it as you normally would with the form functionality.

### Example

``` dart
  String name = "Jean Luc";

  @override
  Widget build(BuildContext context) {
      body: Form(
        key: _formKey,
        child: CardSettings(
          children: <Widget>[
            CardSettingsHeader(label: 'New Section'),
            CardSettingsText(
              label: 'Name',
              initialValue: name,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Name type is required.';
              },
              onSaved: (value) => name = value,
            ),
            ),
          ],
        ),
      ),
    );
  }            
```

### Themeing

The controls support the material design theme. If you want to customize the colors you do something like this:

``` dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Card Settings Example',
      home: new HomePage(),
      theme: Theme.of(context).copyWith(
        accentColor: Colors.teal[400], // used for headers
        cardColor: Colors.teal[100], // used for field backgrounds
      ),
    );
  }
}

```

## Changelog

Please see the [Changelog](https://github.com/letsar/flutter_staggered_grid_view/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/letsar/flutter_staggered_grid_view/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/letsar/flutter_staggered_grid_view/pulls).
