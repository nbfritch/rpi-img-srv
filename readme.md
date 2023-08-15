# rpi-img-srv
`take-pic.rb` Called via cron to delete all but the last five images on a ramdisk and take another with fswebcam
`img_serve.rb` Sinatra/Puma app to serve the most recent image over http