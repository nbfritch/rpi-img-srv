# rpi-img-srv
Quick and dirty system for periodically taking a picture with an rpi camera and saving it to a ramdisk to preserve sd card write endurance

## Setup
- Add user to `video` group `# usermod -aG video $USER`
- Create 100M ramdisk with `/etc/fstab` entry
```
tmpfs /mnt/ramdisk tmpfs size=100M,nodev,nosuid 0 0
```
- Set permissions `# chown $USER /mnt/ramdisk`

## Components
- `take-pic.rb` Called via cron to delete all but the last five images on a ramdisk and take another with fswebcam
- `img_serve.rb` Sinatra/Puma app to serve the most recent image over http