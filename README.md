# mbeacon
Turn your mac into an iBeacon.

# Getting Started

```
$ defaults write mbeacon uuid -string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
$ mbeacon -major 0 -minor 0
```

or 

```
$ mbeacon -uuid "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" -major 0 -minor 0
```
