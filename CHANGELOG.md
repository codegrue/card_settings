# Releases

## [3.0.0] - TBD

- [Breaking change] pickers now use a model to describe the `name`, `code`, and `icon` for a picker. see `flutter_material_pickers`

## [2.0.3] - 2021-05-24

- Upgraded `flutter_cupertino_settings` to qualify for null safety

## [2.0.2] - 2021-04-16

- Upgraded `Flutter_Material_Pickers`
- Added options `values` list to `CardSettingsSelectionPicker`, `CardSettingsRadioPicker`, `CardSettingsListPicker`, and `CardSettingsCheckboxPicker`

## [2.0.1] - 2021-03-29

- use alwaysUse24HourFormat from MediaQuery in CupertinoDatePicker
- fixed CardSettingsDouble empty exception

## [2.0.0] - 2021-03-29

- upgraded to Flutter 2.0

## [1.16.3] - 2021-02-05

- Added range for `intl` dependency

## [1.16.2] - 2021-01-12

- documentation formatting

## [1.16.1] - 2021-01-12

- improved documentation

## [1.16.0] - 2021-01-11

- added contentPadding parameter (thanks bramdekker)
- upgraded depenencies

## [1.15.0] - 2020-11-11

- upgraded `flutter_material_pickers` and thus `file_picker`. Breaking change `UInt8File` replaced with `PlatformFile`
- Fixed bug in `CardSettingsText` when applying a `inputMask`, formatting lagged by one character input

## [1.14.0] - 2020-10-05

- upgraaded to latest `flutter_material_pickers`
- changed autovalidate to be compatible with new channels [KingLudwig94]
- fixed `DateTimePicker` parent layout error

## [1.13.0] - 2020-09-16

- removed dependency on `cupertino_icons`
- fixed overflow error with file image thumbnails on smaller screens in iOS mode
- fixed overflow error on datetimepicker on smaller iOS Screens
- removed seconds from datetimepicker display
- commented public API

## [1.12.2] - 2020-08-31

- updated dependencies

## [1.12.1] - 2020-08-03

- allowed phone numbers to be null
- fixed bug in currencies with separator characters

## [1.12.0] - 2020-07-21

- updated material pickers to adopt the more compatible file_picker

## [1.11.1] - 2020-07-11

- added `scrollable` property to turn off built in scrolling (Material only).
- changed card `padding` proptety to EdgeInsetsGeometry to allow full control
- added `margin` proptety to `CardSettings`
- added `fieldPadding` to all controls
- refactored card building to merge common code

## [1.11.0] - 2020-07-10

- allow `CardSettingsHeader` to be completely customized through a `child` property.
- exposed `CardSettingsWidget` externally to use in building custom widgets

## [1.10.1] - 2020-07-09

- fixed Heading and Instructions not hiding with visible = false

## [1.10.0] - 2020-07-07

- created a `divider` property on CardSettings and CardSettingsSections
- removed the divider appearing from the last item in a section
- ensure that widgets are of type `CardSettingsWidget` rather than just `Widget`
- improved the number of interfaces to force consistency

## [1.9.9+hotfix.1] - 2020-07-01

- fixed content alignment issue

## [1.9.9] - 2020-07-01

- changed label style for disabled fields (thanks esskar)
- added `cardless` option to flatten the material wrapper to just a Container
- added border clipping to card contents by default
- fixed overflow error on some fields when width of card is very slim

## [1.9.8] - 2020-06-19

- updated readme short example
- created custom long example page to reference the important example file
- fixel label widths on Cupertino (thanks esskar)
- added support for text input action and a input action focus node (thanks esskar)
- added custom font to example
- changed photo thumbnail default size to 180x180
- changed CardSettingsDouble to display localized numbers
- changed CardSettingsPhone to format number in user's locale

## [1.9.7] - 2020-06-09

- ensure all widgets have the `labelWidth` property
- fixed bug with photos not honoring the alignment property
- extended interfaces to enforce API consistency

## [1.9.6] - 2020-06-08

- add step interval support to number picker (thanks CoolONEOfficial)
- fixed gesture click on `CardSettingsFilePicker`
- constrined `CardSettingsFilePicker` photo size
- reorganized example to be more readable
- removed hard coded "Color for" from `CardSettingsColorPicker` title to allow localization

## [1.9.5] - 2020-06-04

- fixed `enabled` behavior for all controls

## [1.9.4] - 2020-06-03

- added `CardSettingsFilePicker` (thanks CoolONEOfficial)
- Upgraded `flutter_cupertino_settings` to address compatibility bug with the beta branch
- Removed dependency on `flutter_platform_widgets`
- Fixed overflow calculation for wide label fields

## [1.9.3] - 2020-05-23

- fixed assert bug in `CardSettingsSelectionPicker` when providing values and no icons
- added CI to the project (Github Actions)
- increased unit tests for code coverage
- added more badges to the readme

## [1.9.2] - 2020-05-20

- updated `flutter_material_pickers` package to fix C`ardSettingsSelectionPicker` index bug

## [1.9.1] - 2020-05-19

- refactored single card display to scroll better on web
- defaulted shrinkWrap to true
- `showMaterialonIOS` on fields defaults to inherit from the `CardSettings` parent

## [1.9.0] - 2020-05-18

- compatible with flutter web now
- `CardSettingsDateTimePicker` (combo) added
- `CardSettingsRadioPicker` added
- `CardSettingsSelectionPicker` added
- renamed `CardSettingsMultiselect` to `CardSettingsCheckboxPicker`
- Icon colors will be preserved if provided
- added DateFormat as parameter to `CardSettingsDatePicker`
- made styling a closer match to the new material spec

## [1.8.2] - 5/5/2020

- Updated `flutter_material_pickers` dependency, including styling changes
- Added `hintText` for CardSettingsParagraph

## [1.8.1] - 4/16/2020

- Added hintText to `CardSettingsInt`
- Added null control for initialValue to `CardSettingsInt`
- Updated `flutter_material_pickers` dependency

## [1.8.0] - 3/30/2020

- Added support for wrapping labels

## [1.7.0] - 3/13/2020

- **_(breaking change)_** removed `showErrorIOS` as the `validator` now works for both material and cupertino. This affects: `CardSettingsText`, `CardSettingsParagraph` , `CardSettingsEmail`, `CardSettingsDouble`, `CardSettingsCurrency`, `CardSettingsInt`, `CardSettingsPassword`, `CardSettingsPhone`
- removed the word 'Select' from the hard coded label of `CardSettingsMultiselect` to allow for localization
- example app: changed s`howMaterialonIOS` swap icon to show android or apple logo
- example app: added a dialog on save to mention there are validation errors, as the button appeard to do nothing previosly

## [1.6.1] - 2/13/2020

- updated to use latest version of `flutter_cupertino_settings`

## [1.6.0] - 2/13/2020

- removed pickers and instead referenced the `flutter_material_pickers` package

## [1.5.5] - 1/6/2020

- Updated library references to latest for: `flutter_cupertino_settings`, `flutter_masked_text`

## [1.5.4] - 1/6/2020

- Allowed label width to be set for `CardSettingsSwitch`. <https://github.com/codegrue/card_settings/issues/86>

## [1.5.3] - 12/13/2019

- Enhanced ListPicker to allow a list of values separate from options. <https://github.com/codegrue/card_settings/issues/60>

## [1.5.2] - 12/13/2019

- Fixed elevation not showing in .sectioned version. Padding as well. <https://github.com/codegrue/card_settings/issues/63>

## [1.5.1] - 12/13/2019

- Fixed display of ColorPicker
- Added pickerType property to pick one of "Colors", "Material", or "Block". <https://github.com/codegrue/card_settings/issues/62>
- Migrated Android example to use AndroidX API

## [1.5.0] - 12/12/2019

- Upgraded intl dpendency to 1.16.0 <https://github.com/codegrue/card_settings/issues/82>
- Added code to restrict double's number of decimal digits <https://github.com/codegrue/card_settings/issues/81>
- Added .IsDense to field content so heights line up
- Added global labelWidth property <https://github.com/codegrue/card_settings/issues/80>
- fixed all code warnings
- replaced deprecated code

## [1.4.2] - 10/3/2019

- text align will now used property or end if null
- Added hint text and made initial value optional
- Fixed validator and save issue
- Fixed required indicator position in android
- dynamic multi line support

## [1.4.1] - 2/21/2019

- Added Slider
- Added Dark Mode Support
- Updated Example

## [1.4.0] - 2/18/2019

- Added Optional override for showing material on iOS
- Added Cupertino Forms and all Cupertino Equilivant Controls and Actions
- Updated Example
- [Warning] For the text fields on iOS using [CupertinoTextFields] the [validator] and [onSaved] do not exist, please use [showErrorIOS] to show a [red] Border around the Text Field and [onChanged] and [onFieldSubmitted] to update the value like in the example.
- Require Indicator on iOS will show \* next to the label if [requireIndicator] is not equal to null.

## [1.3.1] - 2/15/2019

- Updated Build Methodes for All Widgets (No More Errors for Dart 2)
- Added Cupertino Widgets for Date, DateTime, Time and List Picker (onLongPress Overrides to material)

## [1.2.5] - 1/22/2019

- Fixed validator text not showing up in any new line fields (e.g. CardSettingsMultiselect)

## [1.2.4] - 1/9/2019

- Allow for zero width margin around card by setting padding to zero

## [1.2.3] - 1/9/2019

- Fixes text color not reflecting custom color in the Instructions widget
- Added the ability to hide the counter in the paragraph control
- Added missing hint text for the password field
- fixed case where if there is no change handler then we crashed
- Added missing contentOnNewLine field
- Added missing contentOnNewLine field
- Added missing contentOnNewLine field

## [1.2.2] - 11/2/2018

- Fixed a crash bug with icons when a theme color is not provided

## [1.2.1] - 10/2/2018

- Removed hard coded word 'Select' from picker title
- Added text capitalization to CardSettingsText
- Set picker to first item if no initialvalue is provided
- Added 'hintText' to CardListPicker

## [1.2.0] - 9/8/2018

- Fixed overflow bug with picker dialogs on smaller screens
- Refactored row layout helpers into a single flexible `CardFieldLayout`

## [1.1.0] - 9/5/2018

- Added `hintText` to `CardSettingsText` widget

## [1.0.1] - 8/24/2018

- Changed Example to use `NativeDeviceOrientationReader` for orientation changes.

## [1.0.0] - 8/24/2018

- Ready for full release. No API changes predicted
- Added Discord channel to the collaboration section

## [0.1.16] - 8/23/2018

- Added `CardSettingsMultiselect` widget
- Fixed bug when onChange was null
- Fixed validation issue with phone numbers

## [0.1.15] - 8/20/2018

- Added landscape layout and material title for `CardSettingsListPicker`
- Added landscape layout and material title for `CardSettingsNumberPicker`
- Added landscape layout and material title for `CardSettingsColorPicker`

## [0.1.14] - 8/20/2018

- Added `CardFieldLayout_FractionallySpaced` for controlled spacing in a row
- Fixed bug with labelAlign right not working

## [0.1.13] - 8/19/2018

- Enhanced the example to show switching to landscape orientation
- Created `CardFieldLayout_EqualSpaced` to handle mutiple fields in a row.

## [0.1.12] - 8/17/2018

- Added `padding` and `cardElevation` to `CardSettings`
- Added support for field `icon` to every widget
- Added a `requiredIndicator` to show next to a label
- Removed `textInputAction` property to be compatible with the current beta branch

## [0.1.11] - 8/15/2018

- downgraded intl dependency to ^0.15.6
- removed a few properties that were reported as issues in dartpub analyze

## [0.1.10] - 8/9/2018

- Removed TextCapitalization from CardSettingsText due to an analysis error

## [0.1.8] - 8/9/2018

- Added a analysis_options.yaml file and a bunch if linter checks
- Cleaned and tigtened code

## [0.1.7] - 8/8/2018

- All fields now implement an `onChange` event.
- Added a `CardSettingsPhone` widget
- Enhanced `CardSettingsText` to allow a input mask (based on flutter_masked_text)

## [0.1.6] - 8/2/2018

- Added contentAlign property to all fields to allow for right justification
- Added labelAlign to CardHeaders to allow center or right positioning
- Improved support of themes for input text and labels

## [0.1.5] - 8/1/2018

- Support default button style through themes
- All text fields expose controller as optional parameter (except currency)
- Support theming of header text
- Changed `CardSettings` to an `InheritableWidget` with global properties to control label appearance
- Added a `labelAlign` property to all fields

## [0.1.4] - 7/31/2018

- Added `CardSettingsEmail` field
- Added `CardSettingsPassword` field
- Changed all TextFormFields to be stateless widget wrappers

## [0.1.3] - 7/30/2018

- Added `CardSettingsCurrency` field
- Added `CardSettingsInstructions` field
- Added `CardSettingsButton` field
- Added ability to tap to select in pickers

## [0.1.2] - 7/27/2018

- Attempt to improve documentation and remove warnings

## [0.1.1] - 7/26/2018

- General cleanup to meet publication requirements.

## [0.1.0] - 7/26/2018

- First release implementing card view and core set of field widgets.
