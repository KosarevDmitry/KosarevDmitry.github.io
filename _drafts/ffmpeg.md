# slowly
ffmpeg -i 1.mpg 1.mp4 
#ffmpeg -i 1.avi 1.mp4 
# ffmpeg -i  1.vob -c:v libx264 -crf 23 -preset medium -c:a aac -strict -2 -b:a 128k -ar 44100 -ac 2 output.mp4
# quickly vob
# ffmpeg -i 1.vob -c:v copy -c:a copy 1.mp4 2> log.txt 
#  avi a little bit slowly but any way quickly
# ffmpeg -i 2000_Mrs.Bradley.Mysteries-03.The.Rising.of.the.Moon.DVDRip.XviD_fenixclub.com.avi -c:v copy -c:a copy 3.mp4 


ffmpeg -i 1.vob -c:v copy -c:a copy 1.mp4 2> log.txt 


ffmpeg -i "Murder She Wrote 1x00 The Murder Of Sherlock Holmes.avi" -c:v copy -c:a copy "Murder She Wrote 1x00 The Murder Of Sherlock Holmes.mp4" 2> log.txt 
ffmpeg -i "Murder She Wrote 1x01 Deadly Lady.avi" -c:v copy -c:a copy "Murder She Wrote 1x01 Deadly Lady.mp4" 2> log.txt 