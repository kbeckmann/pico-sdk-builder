# kbeckmann/pico-sdk-builder: Build machine running archlinux for building Raspberry Pi Pico SDK based projects

This is a simple Docker environment for building packages in an Archlinux environment.

`yay` will be installed. Useful in order to test if packages have undocumented dependencies.

## Example
```
$ docker pull kbeckmann/archbuilder
$ docker run -ti kbeckmann/archbuilder
[docker@53642656badd opt]$ yay -S stupidterm-git
... installing dependencies
... building
... installing your package
```

