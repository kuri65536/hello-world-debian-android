# Debian Android Hello World
A very simple "Hello World" program for Android, designed to be built with tools included in Debian Buster, and nothing else.

## What is this?

It's a demo Android app that displays the text "Hello World".

## Why would I want this?

The Android toolchain is poorly documented; the subset of tools included in Debian Buster and what you can do with them even less so. Most documentation out there assumes you are using Android Studio or at least Gradle.

This project helps to document the [Android tools in Debian](https://wiki.debian.org/AndroidTools) by providing an example build, and can serve as a base template for new projects for those who would like to develop Android apps using only truly Free and Open Source software.

## Status

This project results in an installable APK file, but additional testing is needed.

## How do I use this?

Assuming you are using Debian Buster, install the following packages:
```
~# apt-get install make android-sdk android-sdk-platform-23
```

This should pull in all the necessary dependencies. Let me know if you find something is missing.

Then, simply check out the project with git, and run '`make`'.

If everything goes well, you will end up with '`helloworld.apk`' in the root directory of the project, which you can transfer to your phone and install in any way you see fit, for example using '`adb install`'.

On the first run, you will be asked for information to create your signing key. If you're just trying things out, you can leave everything as-is.

## Credits

This project would have taken much more time without the clear instructions found at [hanshq.net](https://www.hanshq.net/command-line-android.html) and to a lesser extent [Stack Overflow (via archive.org)](https://web.archive.org/web/20170222142406/http://stackoverflow.com:80/documentation/android/85/getting-started-with-android/9496/android-programming-without-an-ide#t=201709230259099678833).

## Author

[Coffee](https://gitlab.com/Matrixcoffee)

## Contact
* Website: [https://open.source.coffee](https://open.source.coffee)
* Mastodon: [@Coffee@toot.cafe](https://toot.cafe/@Coffee)

## License

This software is is licensed under the CC0 license, meaning that to the extent possible under law, the author has waived all copyright and related or neighboring rights to this work.

This software is offered as-is, and the author makes no representations or warranties of any kind concerning the software, express, implied, statutory or otherwise, including without limitation warranties of title, merchantability, fitness for a particular purpose, non infringement, or the absence of latent or other defects, accuracy, or the present or absence of errors, whether or not discoverable, all to the greatest extent permissible under applicable law.

The above is a summary; the full license can be found in the file called [LICENSE](LICENSE), or at [the creative commons website](https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt).
