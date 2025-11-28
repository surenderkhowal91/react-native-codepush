@hrhk/react-native-codepush

# A lightweight OTA (Over-The-Air) update system for React Native, allowing you to update your JavaScript bundle instantly without         # publishing a new version to the Play Store or App Store.

This library supports:
Android
iOS

Firebase Remote Config
S3/HTTPS bundle hosting
Zero AppCenter dependency
Customizable update modal

# 🛠 Getting Started

# Note: This library assumes you already have a working React Native environment.
If not, follow the official guide:
https://reactnative.dev/docs/set-up-your-environment

📦 Installation

Install the module using npm or yarn:

# npm
npm install @hrhk/react-native-codepush

# yarn
yarn add @hrhk/react-native-codepush

# iOS Setup
# From your iOS folder, install CocoaPods:
cd ios
pod install

# 🚀 Usage
Import the component:
import CodePushUpdateAlert from '@hrhk/react-native-codepush';

remoteConfig = {
   otaVersion: 1,
    immediate: true/false,
    content: {
      "title": "",
      "description": ""
    },
    BUNDLE_URL: Config.CODEPUSH_URL,
    button: {
        download: "Download Update",
        downloading:'Downloading',
        installing: 'Installing',
        relaunching:'Relaunching',
    },
}

  if (remoteConfig?.otaVersion && remoteConfig?.otaVersion > 0) {
    return <CodePushUpdateAlert otaConfig={remoteConfig} />;
  }

#  📘 How OTA Works

This library loads a downloaded bundle instead of the bundled JS from the APK/IPA.
1. The app checks Firebase Remote Config
2. If a newer OTA version exists:
  i. Downloads ZIP from S3
 ii. Extracts JS bundle + assets
iii. Saves them in local storage
iv. Restarts the app using native module
 v. React Native loads the new bundle on next launch

# 📁 Generating OTA Bundles
# Follow these steps every time you want to release a new JS-only OTA update.

1️⃣ Generate Android Bundle:

npx react-native bundle \
  --platform android \
  --dev false \
  --entry-file index.js \
  --bundle-output ./codepush/android/ota/index.android.bundle \
  --assets-dest ./codepush/android/ota

  A folder will be created:
  codepush/android/ota/
  ├── index.android.bundle
  └── drawable-xxxx/ 
  └── raw/ 

  2️⃣ Generate iOS Bundle: 

npx react-native bundle \
  --platform ios \
  --dev false \
  --entry-file index.js \
  --bundle-output ./codepush/ios/ota/main.jsbundle \
  --assets-dest ./codepush/ios/ota

  A folder will be created:
  codepush/ios/ota/
  ├── main.jsbundle
  └── assets/


  # 3️⃣ Prepare ZIP Files

Zip only the ota folder.
Naming Convention for Android:
# android-{versionName}-{otaVersion}.zip  -> android-1.0.1-1.zip

# iOS:
# ios-{versionName}-{otaVersion}.zip -> ios-1.0-1.zip

Upload ZIP to your public bucket: