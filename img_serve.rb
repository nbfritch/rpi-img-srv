require 'sinatra'
require 'puma'

set :port, 8000
set :bind, '0.0.0.0'

def get_img()
  entries = Dir.entries('/mnt/ramdisk')
  just_images = entries.filter do |e|
    e.include?('rpi_pic_')
  end
  just_images.sort!()
  if just_images.length == 0
    return nil
  else
    return just_images[just_images.length - 1]
  end
end

get '/' do
  i = get_img()
  if i == nil
    return "<h1>No Images</h1>"
  else
    content_type "image/png"
    return File.read(File.join("/mnt/ramdisk", i))
  end
end
