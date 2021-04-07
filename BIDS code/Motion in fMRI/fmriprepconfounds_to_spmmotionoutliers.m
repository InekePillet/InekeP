%% WHAT IT DOES:
%Read fMRIprep confounds.tsv file for a run
%Take out the motion outliers
%Put those in a .txt file in the same folder of the original file

%% WHAT YOU NEED TO DO: 
%Fill out for which subjects you want this script to run on line 20
%Fill in workdir on lines 26 and 30 (path where the fmriprep output is for a certain subject). Make sure that the path format is the same for each subject, except the subject number.
%Note: if you have more than 1 session, run the script as many times as you
%have sessions with the workdir set to the different session each time, or write
%yourself a for loop to do this for you ;-) 
%Note 2: my first 9 subjects are numbered 01-09, if this differs for you
%change lines 25-35


%Ineke Pillet, march 2021, version 1
%% THE ACTUAL CODE: 
%Which subjects do you want to process? Write down their identifiers, in
%integers e.g. sub-08? Then write 8, e.g. sub-08 until sub-11, write (8:11)
subjectstorun=(5:7); 

%This will loop through all the subjects
for subject=subjectstorun

    if subject < 10 
        workdir=['/Volumes/MacOS/PhD/PhD/WP1A/Pilot-SC-3DEPI-20cat/derivatives/fMRI_prep/sub-0' num2str(subject) '/ses-01/fmriprep/sub-0' num2str(subject) '/ses-01/func'];
        %I prefer to have sub-01-sub-09 numbered as such, from 01 to 09 and
        %not as 1 to 9. So the path will differ for these subjects.
    else
        workdir=['/Volumes/MacOS/PhD/PhD/WP1A/Pilot-SC-3DEPI-20cat/derivatives/fMRI_prep/sub-' num2str(subject) '/ses-01/fmriprep/sub-' num2str(subject) '/ses-01/func'];
        %All subjects from 10 and on will just be numbered in the path as
        %they are written so 10, 11, ... 111, ...
    end
        
cd(workdir); 
%Select the file containing the confounds
confoundfilenames=dir('*confound*.tsv');
%There will be several if you had more than 1 run, let's see how many
[numfiles,~]=size(confoundfilenames);
%Let's take all their names and save those in a cell
[confoundfiles{1:numfiles}]=deal(confoundfilenames.name);

%Now, for every run, let's read the file
for run = 1:numfiles
    confounds=tdfread(confoundfiles{run}); %we read it
    names=fieldnames(confounds); %get fieldnames
    match = {};
    for i = 1:length(names) %for each fieldname
      if contains(names{i},'motion_outlier') %check if it is an outlier column
          match{end+1} = names{i}; %if so, place the fieldname in match
      end
    end
    motion_outliers=[];
    for i = 1:length(match) %for every motion outlier field
        a1=getfield(confounds,match{i}); %get the data column of the field
        motion_outliers=[motion_outliers,a1]; %add it to an outliers matrix
    end
    matchfn='_desc-confounds_regressors.tsv'; %we're going to find this part in the original filename; if sub 2 4 10, else regressors instead of timeseries
    newfilename=erase(confoundfiles{run},matchfn); %we now delete that part out 
    finalnewname=['motionoutliers_' newfilename '.txt']; %like SPM we put rp_ in front and make it a txt file
    save(finalnewname,'motion_outliers','-ascii') %we save the param in a txt file in the folder
    clear confounds names match a1 motion_outliers newfilename finalnewname
end

clear confoundfilenames confoundfiles numfiles run 
end
