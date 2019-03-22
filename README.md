# Docker image for building and running React Native Applications on Android

Docker Image for running and building React Native apps on Android devices.

### What's included:

NodeJS 10.x, latest React Native CLI, yarn, flow-typed, code-push, Android SKD, Gradle and Maven.

Running android app on real device :

`make android-run`

Running android app on [emulator with NVC](https://github.com/budtmo/docker-android) :

`make android-run-emulator`

Or simply running container :

`make docker-run`

All the commands are in the Makefile file.

### How to use:

You can run most of the react native related commands without installing anything locally. You can even use it with CI/CD.

No root user has been added on Dockerfile :)
