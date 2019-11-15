%HOPLAB: adapting mri experimental data to BIDS
%step nr 4: 
%taking an onsets, names. durations .mat file as prepared for SPM12
%will change it into BIDS .tsv file

%code is made for when this info is different for each subject and each task run
%e.g.
%in sub-01 folder, in ses-1 folder (if more than 1 session), in func folder, 
%you find niftis e.g. sub-01_ses-01_task-XXX_run-1_bold.nii
%and .json files e.g. sub-01_ses-01_task-XXX_run-1_bold.json 
%for each task the sub did

%for each task; each run, you'll need a .tsv with the name
%sub-01_ses-01_task-XXX_run-01_events.tsv OR
%if it's the same for all runs but not all subs, you can have only 1 per sub
%if it's the same for all subs and all runs, you can have only 1 for all subs
%if it's the same for all subs but not all runs, you can have 1 per run for all subs
%!place accordingly in folder hierarchy 

%Made by Ineke, november 2019

Sub='S2'; %id of the 
Subnr='02'; %subject number in your BIDS 
ses='01'; %session number in your BIDS
task='experimental'; %name of your task in BIDS
BIDSDir=['/Volumes/MacOS/PhD/PhD/WP1A - SC/Nifti/sub-' Subnr filesep 'ses-' ses filesep 'func'];
Dir=['/Volumes/MacOS/PhD/PhD/WP1A/Statistics/' Sub '/Experimental/']; %where are the onsets names duration files for your subject
runs=[1:16]; %for how many runs do you have such files

%for every run
for run=runs
    %what's the name of the .mat file for this run
    filename=['Localizer20Categories_' num2str(run) '_.mat'];
    %load in the .mat file
    cd (Dir)
    load([Dir filename]);
    %reformatting 
    vectorOnsets=cell2mat(onsets); %all values of all cells to 1 matrix
    vectorOnsets=sort(vectorOnsets); %sort the onsets numerically
    trialtype=cell(1,length(vectorOnsets)); %to put names of conditions in
    vectorDurations=cell(1,length(vectorOnsets)); %to put durations of conditions in
    for i = 1:length(names) %for each condition
        tofind=onsets{i}; %what are the onsets of this condition
        for j = 1:length(tofind) %for every onset of this condition
            idx(j)=find(vectorOnsets == tofind(j)); %find indices of where those onsets in numerically sorted vector
        end
        trialtype(idx) = (names(i)); %on these indices, put the name of the associated condition
        vectorDurations(idx) = (durations(i)); %on these indices, put the duration of the associated condition
    end
    onset=vectorOnsets';
    duration=vectorDurations';
    trial_type=trialtype';
    t=table(onset,duration,trial_type);
    %writing to a .tsv file
        %name of the .tsv should be?
        correctname=(['sub-' Subnr '_ses-' ses '_task-' task '_run' num2str(run) '_bold_events']);
        %save it in correct BIDS location
        writetable(t,[BIDSDir filesep correctname '.tsv'],'FileType','text','Delimiter','\t')
    clear vectorOnsets vectorDurations trialtype trial_type tofind t onsets onset names i j idx filename durations duration correctname    
end
