#!/usr/bin/python
import sys
import os
import os.path
import shutil

dirs = []
#  NR 1
dirs.extend(['pitches', 'rhythms', 'expressive',
'repeats', 'simultaneous', 'staff', 'editorial', 'text'])
# NR 2
dirs.extend(['vocal', 'chords', 'piano',
'percussion', 'guitar', 'strings', 'bagpipes', 'ancient'])



#
#dirs.extend(['real-music'])
#dirs = ['ancient','chords','connecting','contemporary','expressive','education','guitar','parts','pitch','repeats','scheme','spacing','staff','text','vocal','other','nonmusic','engravers','instrument']
notsafe=[]

try:
	in_dir = sys.argv[1]
except:
	print "Please specify input_file."
	sys.exit()

def copy_with_warning(src, dest):
	msg = '%%  Do not edit this file; it is auto-generated from LSR!\n'
	open (dest, 'w').write( msg + open (src).read() )


def copy_dir_with_test(srcdir, destdir):
	global notsafe
	global notconvert
	if not(os.path.exists(srcdir)):
		return
	file_names = os.listdir (srcdir)
	for file in file_names:
		if (file.endswith ('.ly')):
			src = os.path.join (srcdir, file)
			destname = file.replace (';', '-')
			dest = os.path.join (destdir, destname)
			copy_with_warning(src, dest)
			os.system('convert-ly -e ' + dest)
			if os.path.exists( dest + '~' ):
				os.remove( dest + '~' )
			# the -V seems to make unsafe snippets fail nicer/sooner.
			s = os.system('nice lilypond -V -dno-print-pages -dsafe -o /tmp/lsrtest ' + dest)
			#s = os.system('nice lilypond -dno-print-pages -dsafe -o /tmp/lsrtest ' + dest)
			if s:
				notsafe.append(dest)


for dir in dirs:
	srcdir = os.path.join (in_dir, dir)
	destdir = os.path.join ('input', 'lsr', dir)
	if not(os.path.isdir(destdir)):
		print "Please run this script from the head of the source tree,"
		print "  and/or check that you have the right categories."
		sys.exit()

	## clean out existing files
	file_names = os.listdir (destdir)
	for file in file_names:
		if (file.endswith ('.ly')):
			os.remove( os.path.join(destdir,file) )
	## copy in new files from LSR download
	copy_dir_with_test( srcdir, destdir )
	## copy in new files in source tree
	copy_dir_with_test( os.path.join ('input', 'new', dir), destdir )


file=open("lsr-unsafe.txt", 'w')
for s in notsafe:
	file.write(s+'\n')
file.close()

print
print
print "Unsafe files printed in lsr-unsafe.txt: CHECK MANUALLY!"
print "  xargs git-diff < lsr-unsafe.txt"
print

