# Card Settings control

A flutter package for building card based settings forms. This includes a library of pre-built form field widgets. The style is a bit like a cross between 
the cupertino settings screen and material design; The idea is it should be usable and intutive on both iOS and Android.

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
- CardSettingsButton - Actions buttons for the form
- CardSettingsCurrency - Field for currency entry

All fields support `validate`, `onSaved`, `autovalidate`, and `visible`.

The package also includes these additonal items:

- CardSettingsField - The base layout widget. You can use this to build custom fields.
- CardSettingsHeader - A control to put a header between form sections.
- CardSettingsInstructions - Informational read-only text.
- Converters - a set of utility functions to assist in converting data into and out of the fields.

## Usage
To use this package, add `card_settings` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

``` dart
    card_settings: ^0.1.2
```

### Simple Example

All fields in this package are compatible with the standard Flutter Form widget. Simply wrap the CardSettings control in a form and use it as you normally would with the form functionality.

``` dart
  String title = "Spheria";
  String author = "Cody Leet";

  @override
  Widget build(BuildContext context) {
      body: Form(
        key: _formKey,
        child: CardSettings(
          children: <Widget>[
            CardSettingsHeader(label: 'Favorite Book'),
            CardSettingsText(
              label: 'Title',
              initialValue: title,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Title is required.';
              },
              onSaved: (value) => title = value,
            ),
            CardSettingsText(
              label: 'Author',
              initialValue: author,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Author is required.';
              },
              onSaved: (value) => author = value,
            ),
          ],
        ),
      ),
    );
  }            
```

See the full demo example [here](https://pub.dartlang.org/packages/card_settings#-example-tab-).

### Theming

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
        backgroundColor: Colors.teal[200], // color outside the card
      ),
    );
  }
}

```

### Dynamic Visibility

Each field implements a `visible` property that you can use to control the visibility based on the value of other fields. In this example, the switch field controls the visibility of the color picker control:

``` dart
  bool _ateOut = false;

  CardSettingsSwitch(
    label: 'Ate out?',
    initialValue: _ateOut,
    onChanged: (value) => setState(() => _ateOut = value),
  ),

  CardSettingsText(
    label: 'Restaurant',
    visible: _ateOut,
  ),
```

## Dependencies

This widget set relies on these external third-party components:

- [flutter_colorpicker](https://pub.dartlang.org/packages/flutter_colorpicker)
- [flutter_masked_text](https://pub.dartlang.org/packages/flutter_masked_text)

## Changelog

Please see the [Changelog](https://github.com/codegrue/card_settings/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/codegrue/card_settings/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/codegrue/card_settings/pulls).
