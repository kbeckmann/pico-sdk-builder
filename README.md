# kbeckmann/pico-sdk-builder: Build machine running archlinux for building Raspberry Pi Pico SDK based projects

This is a simple Docker environment for building packages in an Archlinux environment.

`yay` will be installed as well.

## Example building PicoCart64
```bash
git clone https://github.com/kbeckmann/PicoCart64

cd PicoCart64
git checkout develop
git submodule update --init

wget https://github.com/meeq/FlappyBird-N64/raw/master/FlappyBird-v1.4.z64
./sw/scripts/load_rom.py --compress FlappyBird-v1.4.z64

docker run \
    --mount type=bind,source=$(pwd),target=/ci \
    --workdir=/ci \
    ghcr.io/kbeckmann/pico-sdk-builder:latest \
    bash -c "\
        git config --global --add safe.directory /ci                     && \
        mkdir -p sw/build                                                && \
        cd sw/build                                                      && \
        cmake -DREGION=PAL ..                                            && \
        make                                                             && \
        cp picocart64/picocart64.uf2 /ci/picocart64-pal.uf2              && \
        cmake -DREGION=NTSC ..                                           && \
        make                                                             && \
        cp picocart64/picocart64.uf2 /ci/picocart64-ntsc.uf2"

```

