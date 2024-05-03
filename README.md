# iOS SDK Sample
Sample representing Saooti iOS SDK: https://github.com/saooti/ios-sdk

## Access
You need to have access to https://github.com/saooti/ios-sdk

## Setup

Once you have permissions - generate a new (or update existing) classic token https://github.com/settings/tokens with `repo` permission for your account.

Note: This sample uses CocoaPods, you can use SPM also.

Set your credentials - login and token to `Podfile`:
````
pod 'SaootiSDK', :git => 'https://<github_login>:<github_token>@github.com/saooti/ios-sdk.git'
````

Install pod:
````
pod update
````

Set your organisation id to `SDK_SampleApp.swift` at `Saooti.setOrganisationId("<organisation_id>")`.
