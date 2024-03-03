## v0.0.1 27 Sep, 2023

* Initial release.

## v0.0.2 25 Dec, 2023
* Upgraded Android SDK to v1.0.0-beta15
* Improve the README.md

## v0.0.3 26 Dec, 2023
* Adopting new Android SDK result handling


## v0.0.5 27 Dec, 2023
* Updating iOS framework to 10.0.11


## v0.0.6 27 Dec, 2023
* Including AmwalPayWidget to the plugin

## v0.1.0 2 Jan, 2024
* Supporting RefId for the payment request
* Supporting the new AmwalPayWidget
* Adding new Android SDK v1.0.0-beta16
* Supporting new iOS SDK v1.0.12
* Improve arguments validation

## v0.1.1 8 Jan, 2024
* Fixing SSL related security issue in the Android SDK

## v0.2.0 10 Jan, 2024
* Fixing issue with Android Bottom Sheet State
* Fixing issue with Android OTP doesn't send automatically when the user taps on the widget
* Supporting localization for the Android SDK
* Supporting localization for the iOS SDK
* Supporting localization for AmwalPayWidget
* Updating iOS SDK to v1.1.0
* Updating Android SDK to v1.0.0-rc1


## v0.2.1 11 Jan, 2024
* Updating Android SDK to v1.0.0-rc3
* Supporting an option to change the language of the widget explicitly

## v0.3.1 15 Jan, 2024
* Fix language issue in the iOS SDK

## v0.3.2 23 Jan, 2024
* Fix webView issue in Production environment
* Update Android to v1.0.0-rc4

## v0.3.3 31 Jan, 2024
* Hide webView Logs in Production environment
* Update Android to v1.0.0-rc5

## v0.3.4 31 Jan, 2024
* Fixing regressions in Production environment
* Update Android to v1.0.0-rc6

## v0.4.0 7 Feb, 2024
* Adding new phoneNumber feature to support the new AmwalPayWidget

## v0.5.0 26 Feb, 2024
* Update Android to v1.0.0-rc8
* OTP doesn't redirect to transaction status while performing Quest Checkout.
* Used Google's International Phone Number Validation Library.
* Fixed country code caching and validation.
* Show API call error in PhoneNumberScreen.
* Deprecated passed countryCode configuration in favor of the phoneNumber parameter.
* Fix transaction status mirroring to the correct values.
* Now the developers will get a runtime error if the autofill phoneNumber is not valid.


## v0.6.0 3 March, 2024
* Update Android to v1.0.0-rc9
* Fix status issue with Android doesn't return error status.
* Added new API changes, now after the payment is done, there is a new return type `TransactionStatus`, which will help developers do better error handling, check [Readme](/README.md) for more details.
