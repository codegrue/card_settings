# Releases

## [1.2.2] - 11/2/2018

* Fixed a crash bug with icons when a theme color is not provided

## [1.2.1] - 10/2/2018

* Removed hard coded word 'Select' from picker title
* Added text capitalization to CardSettingsText
* Set picker to first item if no initialvalue is provided
* Added 'hintText' to CardListPicker

## [1.2.0] - 9/8/2018

* Fixed overflow bug with picker dialogs on smaller screens
* Refactored row layout helpers into a single flexible `CardFieldLayout`

## [1.1.0] - 9/5/2018

* Added `hintText` to `CardSettingsText` widget

## [1.0.1] - 8/24/2018

* Changed Example to use `NativeDeviceOrientationReader` for orientation changes.

## [1.0.0] - 8/24/2018

* Ready for full release. No API changes predicted
* Added Discord channel to the collaboration section

## [0.1.16] - 8/23/2018

* Added `CardSettingsMultiselect` widget
* Fixed bug when onChange was null
* Fixed validation issue with phone numbers

## [0.1.15] - 8/20/2018

* Added landscape layout and material title for `CardSettingsListPicker`
* Added landscape layout and material title for `CardSettingsNumberPicker`
* Added landscape layout and material title for `CardSettingsColorPicker`

## [0.1.14] - 8/20/2018

* Added `CardFieldLayout_FractionallySpaced` for controlled spacing in a row
* Fixed bug with labelAlign right not working

## [0.1.13] - 8/19/2018

* Enhanced the example to show switching to landscape orientation
* Created `CardFieldLayout_EqualSpaced` to handle mutiple fields in a row.

## [0.1.12] - 8/17/2018

* Added `padding` and `cardElevation` to `CardSettings`
* Added support for field `icon` to every widget
* Added a `requiredIndicator` to show next to a label
* Removed `textInputAction` property to be compatible with the current beta branch

## [0.1.11] - 8/15/2018

* downgraded intl dependency to ^0.15.6
* removed a few properties that were reported as issues in dartpub analyze

## [0.1.10] - 8/9/2018

* Removed TextCapitalization from CardSettingsText due to an analysis error

## [0.1.8] - 8/9/2018

* Added a analysis_options.yaml file and a bunch if linter checks
* Cleaned and tigtened code

## [0.1.7] - 8/8/2018

* All fields now implement an `onChange` event.
* Added a `CardSettingsPhone` widget
* Enhanced `CardSettingsText` to allow a input mask (based on flutter_masked_text)

## [0.1.6] - 8/2/2018

* Added contentAlign property to all fields to allow for right justification
* Added labelAlign to CardHeaders to allow center or right positioning
* Improved support of themes for input text and labels

## [0.1.5] - 8/1/2018

* Support default button style through themes
* All text fields expose controller as optional parameter (except currency)
* Support theming of header text
* Changed `CardSettings` to an `InheritableWidget` with global properties to control label appearance
* Added a `labelAlign` property to all fields

## [0.1.4] - 7/31/2018

* Added `CardSettingsEmail` field
* Added `CardSettingsPassword` field
* Changed all TextFormFields to be stateless widget wrappers

## [0.1.3] - 7/30/2018

* Added `CardSettingsCurrency` field
* Added `CardSettingsInstructions` field
* Added `CardSettingsButton` field
* Added ability to tap to select in pickers

## [0.1.2] - 7/27/2018

* Attempt to improve documentation and remove warnings

## [0.1.1] - 7/26/2018

* General cleanup to meet publication requirements.

## [0.1.0] - 7/26/2018

* First release implementing card view and core set of field widgets.