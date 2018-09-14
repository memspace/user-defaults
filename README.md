A Flutter plugin to interact with `NSUserDefaults` on iOS and `SharedPreferences` on Android.

Checkout also the official `shared_preferences` plugin from Flutter. Here are a few differences
between the two:

1. Allows selecting specific settings store by name. Can be useful if you have setup
  an App Group for iOS and have shared `NSUserDefaults` instance different from `standardUserDefaults`.
2. Does not filter settings by any prefix. `shared_preferences` uses `flutter.` prefix
  on all keys.
3. Does not cache values on the Dart side. Every call to `get` retrieves fresh value from the
  native side.