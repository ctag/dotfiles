# settings for device drivers

### Begin group: DEFAULT
 
# format map
# Ordered list of formats the device will accept
format_map = cPickle.loads('\x80\x02]q\x01(X\x04\x00\x00\x00azw3q\x02X\x04\x00\x00\x00azw1q\x03X\x03\x00\x00\x00azwq\x04X\x04\x00\x00\x00mobiq\x05X\x03\x00\x00\x00prcq\x06X\x03\x00\x00\x00tpzq\x07X\x04\x00\x00\x00pobiq\x08X\x03\x00\x00\x00pdfq\tX\x03\x00\x00\x00txtq\nX\x04\x00\x00\x00textq\x0bX\x04\x00\x00\x00azw4q\x0ce.')
 
# use subdirs
# Place files in sub directories if the device supports them
use_subdirs = True
 
# read metadata
# Read metadata from files on device
read_metadata = True
 
# use author sort
# Use author sort instead of author
use_author_sort = False
 
# save template
# Template to control how books are saved
save_template = u'{author_sort}/{title} - {authors}'
 
# extra customization
# Extra customization
extra_customization = cPickle.loads('\x80\x02]q\x01(\x88X\x04\x00\x00\x00fastq\x02X\x00\x00\x00\x00X\x00\x00\x00\x00\x88e.')
 


