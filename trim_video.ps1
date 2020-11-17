###########################################################################
# This script uses ffmpeg to trim video clips that were recorded using    #
# Instant Replay from Nvidia's Geforce Experience overlay. The output     #
# filename is generated automatically from the input filename and         #
# arguments and a beep should play to notify the user that the operation  #
# has completed.                                                          #
#                                                                         #
# -Joshua McNeill (josh8211 at gmail dot com)                             #
###########################################################################

$input_file = $args[0]
$filename_length = $input_file.length
$file_year = $input_file.Substring($filename_length - 30, 2)
$file_month = $input_file.Substring($filename_length - 27, 2)
$file_day = $input_file.Substring($filename_length - 24, 2)
$name = $args[1]
$number = $args[2]
$output_file = "${name}_${file_year}_${file_month}_$file_day-$number.mp4"
$start_time = $args[3]

if ($args.count -eq 5) {
  $end_time = $args[4]
  ffmpeg -i $input_file -ss $start_time -to $end_time $output_file
} else {
  ffmpeg -i $input_file -ss $start_time $output_file
}

write-host "Finished file $output_file"
[console]::beep(1000,1000)
