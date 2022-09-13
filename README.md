## WIP [pi-gen][] build of [Pi Scan][]

Start with a clean build (this will take a long time):

```
$ sudo ./build.sh
```

When complete, turn off rebuilds of the intermediate stages:

```
$ touch stage{0,1,2}/SKIP
$ touch piscan/SKIP
$ touch stage2/SKIP_IMAGES
$ touch piscan/SKIP_IMAGES
```

Then we can iterate on rebuilding the last stage (`piscan-2`) quickly with:

```
sudo CLEAN=1 ./build.sh
```

Completed builds are in ``deploy/image_`date +%F`-pi-scan-finalfinal.zip``

[pi-gen]: https://github.com/RPi-Distro/pi-gen
[Pi Scan]: https://github.com/Tenrec-Builders/pi-scan
