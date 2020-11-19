# InekeP
My personal repository where I keep code related to neuroscience that I may want to share with others. 
Code is ready to be used, but might be improved from time to time. 

Currently, within this there is code designed to:
- Help BIDSify your raw data. Matlab scripts to make json files for anatomy and functional scans (pay extra attention here to values important for fmriprep to do slice-timing), to create the dataset description and participants file, to change SPM onsets files into events.tsv files (check the output from this script for a file or 2). Also, it includes an excel file to calculate some physics parameters but you don't need them in your json files if you do 3T fMRI. To round it all up, there is a word document that tries to provide a step by step plan to BIDSify (currently there is no code for the steps relating to creating the folder hierarchy, placing the files there, renaming the files; will be coded in python coming soon).
- Work with a dataset that is in BIDS structure and to work on that (or on results of BIDS apps). At this moment, there is only code to take the 6 motion parameters from fMRIprep and save them as SPM would after realignment, and create motion plots of these 6. 
