%% WHAT IT DOES:
%It plots the 6 motion parameters (3 translation in a plot in mm, 3 rotation in a plot in radians)
%For every subject, for every run
%And saves it

%% WHAT YOU NEED TO DO: 
%Fill out for which subjects you want to run this code on line 20
%Note: my first 9 subjects are numbered 01-09, if this differs for you
%change lines 24-32
%Note: comment line 57 if you just want to save and not inspect each figure


%First written by Jessica(?), adapted to a second version by Ineke Pillet,
%nov 2020 (For use with BIDS dataset, added a loop to run this for not just one subject at a time but
%for as much as you need; add labels legends and a headtitle; and to save
%the plots)
%% THE ACTUAL CODE: 
%Which subjects do you want to process? Write down their identifiers, in
%integers e.g. sub-08? Then write 8, e.g. sub-08 until sub-11, write (8:11)
subjectstorun=(4:19); 

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
    
%Read the rp-file (if fmriprep was used, first run script fmriprepconfounds_to_spmmotionparamtext.m)
files = dir('rp_*.txt');

%Plot of every run
for i = 1:size(files,1)
    motpar = load(files(i).name); %Load the motion parameters from the file, formatted in SPM style
    figure(1) %Open a figure window
    subplot(1,2,1) %Make first plot
    plot(motpar(:,1:3)) %Plots the translation parameters
    xlabel('volume');
    ylabel('mm');
    legend('x translation','y translation','z translation','Location','southwest');
    subplot(1,2,2) %Make second plot in this figure
    plot(motpar(:,4:6)) %Plots the rotation parameters
    xlabel('volume');
    ylabel('radians');
    legend('pitch','roll','yaw','Location','southwest');
    sgtitle(num2str(files(i).name), 'Interpreter', 'none'); %Give a title to the figure
    match='.txt'; %We're going to find this part in the original filename
    newfilename=erase(files(i).name,match); %We now delete that part out  
    saveas(gcf,newfilename,'tiff'); %Save the figure with this filename without .txt as a tiff file
    k = waitforbuttonpress; %Comment this line if you don't want to see all of them and just want to save
end

end
