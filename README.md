[![Pub Package](https://img.shields.io/pub/v/card_settings.svg)](https://pub.dartlang.org/packages/card_settings)
[![Github Issues](http://githubbadges.herokuapp.com/codegrue/card_settings/issues.svg)](https://github.com/codegrue/card_settings/issues)


# Card Settings

A flutter package for building card based settings forms. This includes a library of pre-built form field widgets. The style is a bit like a cross between 
the cupertino settings screen and material design; The idea is it should be usable and intutive on both iOS and Android.

![Screenshot](https://github.com/codegrue/card_settings/blob/master/images/example.gif)

This package consists of a CardSettings layout wrapper and a series of form field options including:

- **Text Fields**
  - *CardSettingsText* - Basic text field
  - *CardSettingsParagraph* - Multiline text field with counter
  - *CardSettingsEmail* - A text field pre-configured for email input.
  - *CardSettingsPassword* - A text field pre-configured for passwords.
- **Numeric Fields**
  - *CardSettingsDouble* - Field for double precision numbers
  - *CardSettingsInt* - Field for integer numbers
  - *CardSettingsCurrency* - Field for currency entry
  - *CardSettingsSwitch* - Field for boolean state   
- **Pickers**
  - *CardSettingsListPicker* - Picker list of arbitrary options
  - *CardSettingsNumberPicker* - Picker list of numbers in a given range
  - *CardSettingsColorPicker* - RGB Color Picker
  - *CardSettingsDatePicker* - Material Design Date Picker
  - *CardSettingsTimePicker* - Material Design Time Picker
- **Informational Sections**
  - *CardSettingsHeader* - A control to put a header between form sections.
  - *CardSettingsInstructions* - Informational read-only text.
- **Actions**
  - *CardSettingsButton* - Actions buttons for the form

All fields support `validate`, `onSaved`, `autovalidate`, and `visible`.

The package also includes these additonal items:

- *CardSettingsField* - The base layout widget. You can use this to build custom fields.
- *Converters* - a set of utility functions to assist in converting data into and out of the fields.

### Simple Example

All fields in this package are compatible with the standard Flutter Form widget. Simply wrap the CardSettings control in a form and use it as you normally would with the form functionality.

``` dart
  String title = "Spheria";
  String author = "Cody Leet";
  String url = "http://www.codyleet.com/spheria"

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
                if (value == null || value.isEmpty) return 'Title is required.';
              },
              onSaved: (value) => title = value,
            ),
            CardSettingsText(
              label: 'URL',
              initialValue: url,
              validator: (value) {
                if (!value.startsWith('http:')) return 'Must be a valid website.';
              },
              onSaved: (value) => url = value,
            ),
          ],
        ),
      ),
    );
  }            
```

See the full demo example [here](https://pub.dartlang.org/packages/card_settings#-example-tab-).

### Theming

The widgets support the material design theme. This example shows what global theme values to set to determine how the various elements appear.

``` dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Card Settings Example',
      home: new HomePage(),
      theme: ThemeData(
        accentColor: Colors.indigo[400], // used for card headers
        cardColor: Colors.white, // used for field backgrounds
        backgroundColor: Colors.indigo[100], // color outside the card
        primaryColor: Colors.teal, // color of page header
        buttonColor: Colors.lightBlueAccent[100], // background color of buttons
        textTheme: TextTheme(
          button: TextStyle(color: Colors.deepPurple), // text style of buttons
        ),
      ),
    );
  }
}

```

Or if you want to apply a different theme to just the `CardSettings` heirarchy, you can wrap it in a `Theme` widget like so:

``` dart
  Theme(
    data: Theme.of(context).copyWith(
      primaryTextTheme: TextTheme(
        title: TextStyle(color: Colors.lightBlue[50]), // style for headers
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), // style for labels
      ),
    ),
    child: CardSettings(
      ...
    ),
  )
```

### Global Properties

The `CardSettings` widget implements a few global settings that all child fields can inherit. Currently it supports only label customization.

#### Labels

You can control how the labels are rendered with three properties:

``` dart
  CardSettings(
    labelAlign: TextAlign.right, // change the label alignment
    labelSuffix: ':', // add an optional tag after the label
    labelPadding: 10.0, // control the spacing between the label and the content
  )
```

The `labelAlign` property is also available on each field, so you can override the global setting for individual fields.

``` dart
  CardSettingsText(
    label: 'Last Name',
    labelAlign: TextAlign.right,
  )
```

### Dynamic Visibility

Each field implements a `visible` property that you can use to control the visibility based on the value of other fields. In this example, the switch field controls the visibility of the text field:

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
