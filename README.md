# Invoca Ruby Challenge

### Project Description
We have thousands of video caption (aka subtitle) files in the QuickTime (QT) format that don't work with the video player we want to use. We need to write a script that will adjust the format of these files so that our player can display them. A sample file has been attached for you to test with. The changes we need made to each file are:

1. Rename each file from this format: Job_XXXX.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt to XXXX.qt.text.
2. Generate a file named XXXX.smil for each qt file, that contains the contents of the template.smil file (attached to this email.) Replace the "{file_name}" tags in the template file with XXXX when generating the file.
3. Replace square brackets that appear in the caption text with parenthesis.   
4. Remove caption blocks that only contain the string "[BLANK_AUDIO]".  

5. Remove the end times on the caption blocks. Each caption consists of a timestamp followed by lines of text, then another timestamp. We want the trailing timestamp removed.

Your solution should:

1. Be executable on a Mac without special software installed.
2. Can we written in any language that meets the above criteria, but Ruby is preferred.
3. Take a directory name as an argument. This directory will contain all of the QT files to process.
4. Command line tool is preferred, but if you want to make a UI, go for it.


### To run:
navigate to src/ directory in console and run 
```bash
$ruby main.rb [directory(ies)]
```
where [directory(ies)] is a file directory or multiple file directories separated by spaces

### To test:
run test.rb 
```bash
$ruby test.rb
```
