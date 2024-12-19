# client - School Interview System -

Language: English | [日本語](README-ja.md)

## About client directory

This is the source code that makes up the client side of the school interview system.

The client is developed in `Flutter`.

## Development Environment

|                | Version                       |
|----------------|-------------------------------|
| Android Studio | Use the latest stable version |
| Flutter        | 3.24.3                        |

## Set Up

* fvm
    1. This project uses [fvm](https://fvm.app/) to manage the Flutter
       SDK. See [here](https://fvm.app/documentation/getting-started/installation) to **fvm**
       for installation.
    2. Install the Flutter SDK. See [Development Environment](#Development-Environment) for the
       version.
   ```
   fvm install [Version]
   fvm use [Version]
   ```
  `Version`: Desired Flutter SDK version (e.g. `2.2.3`).

* Android Studio
    1. Install [Android Studio](https://developer.android.com/studio/install) and start it.
    2. Install the **Flutter** plugin from `Settings < Plugins`.
    3. Set the **Flutter SDK path** in `Settings < Preferences < Languages & Frameworks < Flutter`.
       You will find your Flutter installation in `~/fvm/versions`.
    4. Set `Edit Configuration Settings` as follows

| Item                | Set Value            |
|---------------------|----------------------|
| Name                | Optional             |
| Dart entrypoint     | client/lib/main.dart |
| Additional run args | --web-port 8001      |

## Build

```
fvm flutter build [Target Environment]
```

`Target Environment`：If it is for a web application, `Web`, etc.

## Run

The following command will launch the web application.

```
fvm flutter run --web-port 8001
```