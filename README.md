[![Pub Package](https://img.shields.io/pub/v/card_settings.svg)](https://pub.dartlang.org/packages/card_settings)
[![Github Issues](http://githubbadges.herokuapp.com/codegrue/card_settings/issues.svg)](https://github.com/codegrue/card_settings/issues)


# Card Settings

A flutter package for building card based settings forms. This includes a library of pre-built form field widgets. The style is a bit like a cross between 
the cupertino settings screen and material design; The idea is it should be usable and intutive on both iOS and Android.

![Screenshot](https://github.com/codegrue/card_settings/blob/master/images/example.gif)

This package consists of a CardSettings layout wrapper and a series of form field options including:

- **Text Fields**
  - *CardSettingsText* - Basic text field
  - *CardSettingsParagraph* - Multiline text field with a counter
  - *CardSettingsEmail* - A text field pre-configured for email input
  - *CardSettingsPassword* - A text field pre-configured for passwords
  - *CardSettingsPhone* - A masked phone entry field (US style currently)
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
- **Selection**
  - *CardSettingsMultiselect* - Select from a list of available options
- **Informational Sections**
  - *CardSettingsHeader* - A control to put a header between form sections
  - *CardSettingsInstructions* - Informational read-only text
- **Actions**
  - *CardSettingsButton* - Actions buttons for the form

All fields support `validate`, `onChange`, `onSaved`, `autovalidate`, and `visible`.

The package also includes these additonal items:

- *CardSettingsField* - The base layout widget. You can use this to build custom fields
- *Converters* - a set of utility functions to assist in converting data into and out of the fields

### Simple Example

All fields in this package are compatible with the standard Flutter Form widget. Simply wrap the CardSettings control in a form and use it as you normally would with the form functionality.

``` dart
  String title = "Spheria";
  String author = "Cody Leet";
  String url = "http://www.codyleet.com/spheria"

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          button: TextStyle(color: Colors.deepPurple[900]), // style of button text
          subhead: TextStyle(color: Colors.deepOrange[900]), // style of input text
        ),
      ),
    );
  }
}

```

Or if you want to apply a different theme to the `CardSettings` hierarchy only, you can wrap it in a `Theme` widget like so:

``` dart
  Theme(
    data: Theme.of(context).copyWith(
      primaryTextTheme: TextTheme(
        title: TextStyle(color: Colors.lightBlue[50]), // style for headers
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.deepPurple), // style for labels
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

You can control how the labels are rendered with four properties:

``` dart
  CardSettings(
    labelAlign: TextAlign.right, // change the label alignment
    labelSuffix: ':', // add an optional tag after the label
    labelPadding: 10.0, // control the spacing between the label and the content
    contentAlign: TextAlign.left, // alignment of the entry widgets
    icon: Icon(Icons.person), // puts and option icon to the left of the label
    requiredIndicator: Text('*', style: TextStyle(color: Colors.red)), // puts an optional indicator to the right of the label
  )
```

The `labelAlign` and `contentAlign` properties are also available on each field, so you can override the global setting for individual fields.

``` dart
  CardSettingsText(
    label: 'Last Name',
    labelAlign: TextAlign.left,
    contentAlign: TextAlign.right,
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

### Masking

The `CardSettingsText` widget has an `inputMask` property that forces entered text to conform to a given pattern. This is built upon the [flutter_masked_text](https://pub.dartlang.org/packages/flutter_masked_text)
package and as such masks are formatted with the following characters:

- 0: accept numbers
- A: accept letters
- @: accept numbers and letters
- *: accept any character

So for example, phone number would be '(000) 000-0000'.

Note: `CardSettingsPhone` is a convenience widget that is pre-configured to use this pattern.

Note2: `flutter_masked_text` is a controller and as such, you will not be able to use an inputMask and a custom controller at the same time. This might be rectified in the future.

### Orientation

This suite allows for orientation switching. To configure this, wrap different layouts with a [NativeDeviceOrientationReader](https://pub.dartlang.org/packages/native_device_orientation) object.
*Note there is a bug in the flutter `OrientationBuilder` that may miscalculate landscape when the soft keyboard appears, so at this time it could cause overflow issues if used.*

You might want to have different fields in each layout, or a different field order. So that Flutter doesn't get confused tracking state under this circumstance, you must provide a unique state key for each individual field, using the same key in each layout.

``` dart
final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

child: NativeDeviceOrientationReader(
  builder: (context) {
    var orientation = NativeDeviceOrientationReader.orientation(context);
    return (orientation == NativeDeviceOrientation.portraitUp)
      ? CardSettings(
        children: <Widget>[
          // Portrait layout here 
          CardSettingsEmail(key: _emailKey)
        ],
      )
      : CardSettings(
        children: <Widget>[
          // Landscape layout here
          CardSettingsEmail(key: _emailKey)
        ],
      );
  },
)
```

You may have multiple fields on the same row in landscape orientation. This requires wrapper widgets to provide the layout inside the row. This library provides a few of these shortcut wrappers to produce cleaner code:

- `CardFieldLayout_EqualSpaced` - Multiple fields in a row equally spaced
- `CardFieldLayout_FractionallySpaced` - Multiple fields in a row with controlled spacing

Usage looks like this:

``` dart
CardSettings(
  children: <Widget>[
    CardFieldLayout_EqualSpaced(children: <Widget>[
      CardSettingsEmail(),
      CardSettingsPassword(),
    ]),
  ],
);
```

And to control the relative widths the Fractional version may be used:

``` dart
CardSettings(
  children: <Widget>[
    CardFieldLayout_FractionallySpaced(
      children: <Widget>[
        CardSettingsEmail(),
        CardSettingsPassword(),
      ],
      widthFactors: <double>[0.75,0.25], // 75% and 25% respectively
    ),
  ],
);
```

### Custom Fields

The `CardSettingsField` is the basis of all other fields and can be used to build unique fields outside of this library. Its purpose is to govern layout with consistent decorations. The best way to make a custom field is to inherit from `FormField<T>`, which will manage the state of your field. The cleanest example of this is the `CardSettingsSwitch` widget. All you have to do is provide your custom widgets in the `content` property.

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

If you want to discuss this project, please join the [Discord](https://discord.gg/BT7RGsd) chat.