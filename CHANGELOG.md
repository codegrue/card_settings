## [0.1.0] - 7/26/2018

* First release implementing card view and core set of field widgets.

## [0.1.1] - 7/26/2018

* General cleanup to meet publication requirements.

## [0.1.2] - 7/27/2018

* Attempt to improve documentation and remove warnings

## [0.1.3] - 7/30/2018

* Added `CardSettingsCurrency` field
* Added `CardSettingsInstructions` field
* Added `CardSettingsButton` field
* Added ability to tap to select in pickers

## [0.1.4] - 7/31/2018

* Added `CardSettingsEmail` field
* Added `CardSettingsPassword` field
* Changed all TextFormFields to be stateless widget wrappers

## [0.1.5] - 8/1/2018

* Support default button style through themes
* All text fields expose controller as optional parameter (except currency)
* Support theming of header text
* Changed `CardSettings` to an `InheritableWidget` with global properties to control label appearance
* Added a `labelAlign` property to all fields

## [0.1.6] - 8/2/2018

* Added contentAlign property to all fields to allow for right justification
* Added labelAlign to CardHeaders to allow center or right positioning
* Improved support of themes for input text and labels

## [0.1.7] - 8/8/2018

* All fields now implement an `onChange` event.
* Added a `CardSettingsPhone` widget
* Enhanced `CardSettingsText` to allow a input mask (based on flutter_masked_text)

## [0.1.8] - 8/9/2018

* Added a analysis_options.yaml file and a bunch if linter checks
* Cleaned and tigtened code

## [0.1.9-10] - 8/9/2018

* Removed TextCapitalization from CardSettingsText due to an analysis error