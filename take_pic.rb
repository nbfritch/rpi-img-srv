ramdisk = "/mnt/ramdisk"
pic_count = 5
prefix = "rpi_pic_"

def timestamp()
  Time.now.to_i
end

def pic_filename(framdisk, fprefix, ftimestamp)
  File.join(framdisk, "#{fprefix}#{ftimestamp}.png")
end

def take_pic(framdisk, fprefix, ftimestamp)
  puts "fswebcam -d /dev/video0 -r 2592x1994 -D 2 --png 8 #{pic_filename(framdisk, fprefix, ftimestamp)}"
  `fswebcam -d /dev/video0 -r 2592x1994 -D 2 --png 8 #{pic_filename(framdisk, fprefix, ftimestamp)}`
end

pictures = []
Dir.entries(ramdisk).each do |entry|
  if entry.include?(prefix)
    entry[prefix] = ""
    f = entry.split(".")
    pictures.push(f[0])
  end
end

timestamps = pictures.map do |i|
  i.to_i
end
timestamps.sort!()
puts timestamps
if timestamps.length >= pic_count
  timestamps[0..(timestamps.length - pic_count)].each do |f|
    File.delete(File.join(ramdisk, pic_filename(ramdisk, prefix, f)))
    puts "will delete #{pic_filename(ramdisk, prefix, f)}"
  end
end

take_pic(ramdisk, prefix, timestamp())
