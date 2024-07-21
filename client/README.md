# client - School Interview System -

Flutter project.

This is the client code for the school interview system.

We develop mainly for the **web application**, with mobile applications to follow.

## Development Environment

IDE：`Visual Studio Code`（The newer version the better.）<br>
Flutter：`3.22.2`<br>
Dart：`3.4.3`

## Getting Started

This section describes how to build a development environment for **web application** development.

### Use VS Code to install Flutter

1. Launch **VS Code**.
2. To open the **Command Palette**, press `Command + Shift + P`.
3. In the Command Palette, type `flutter`.
4. Select **Flutter: New Project**.
5. VS Code prompts you to locate the Flutter SDK on your computer.

   - If you have the Flutter SDK installed, click `Locate SDK`.
   - If you do not have the Flutter SDK installed, click `Download SDK`.

6. When prompted **Which Flutter template?**, ignore it. Press `Esc`. You can create a test project after checking your development setup.

### Download the Flutter SDK

1. When the **Select Folder for Flutter SDK** dialog displays, choose where you want to install Flutter.

   VS Code places you in your user profile to start. Choose a different location.

   Consider `~/development/`

2. Click `Clone Flutter`.

   While downloading Flutter, VS Code displays this pop-up notification:

   ```
   Downloading the Flutter SDK. This may take a few minutes.
   ```

3. the **Output** panel displays.

   When the Flutter install succeeds, VS Code displays this pop-up notification:

   ```
   Do you want to add the Flutter SDK to PATH so it's accessible in external terminals?
   ```

   (I'll explain later on how to add SDK location to PATH in your Mac)

4. VS Code may display a Google Analytics notice.

   If you agree, click OK.

5. To enable flutter in all Terminal windows:
   - Close, then reopen all Terminal windows.
   - Restart VS Code.

### How to add the SDK location to PATH in your Mac.

If you use Mac, you can configure it by following step.

1. open `~/.zshrc` file.

   ```
   // if you want to use Vim
   vim ~/.zshrc
   ```

   (You can use VSCode as well. you can use any edtior.)

2. Add following command in `.zshrc`
   If your Flutter SDK location is `Users/danfuji/flutter/flutter`,
   then you can add the following command in .zshrc.

   (✏️ replace the location with yours!)

   ```
   export PATH=/Users/danfuji/flutter/flutter/bin:$PATH
   ```

### Run Flutter doctor

1. Open your Terminal.

2. To verify your installation of all the components, run the following command.

   ```
   flutter doctor
   ```

   Since the environment was built for **web application** development, all components are not required.

   ```
   Running flutter doctor...
   Doctor summary (to see all details, run flutter doctor -v):
   [✓] Flutter (Channel stable, 3.22.1, on macOS 14.4.0 23E214 darwin-arm64, locale en)
   [!] Android toolchain - develop for Android devices
   [✓] Chrome - develop for the web
   [!] Xcode - develop for iOS and macOS (Xcode not installed)
   [!] Android Studio (not installed)
   [✓] VS Code (version 1.89)
   [✓] Connected device (1 available)
   [✓] Network resources

   ! Doctor found issues in 3 categories.
   ```

   If you want to develop for **mobile apps**, all the `!` must be `✓`, but this is not necessary right now.

3. Version Confirmation.

   To check the version, run the following command.

   ```
   flutter --version
   ```

   Match the environment to the [Development Environment](#development-environment) if necessary.

### Run the app

In `client` directory, you can run the following command to run the app.

```
flutter run
```

It may ask you whether the app target is iOS or web(chrome).

### reference

- https://docs.flutter.dev/get-started/install/macos/web
