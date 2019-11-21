%% Template Matlab script to create an BIDS compatible participants.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified RG 201809

%%
clear
root_dir = '/Volumes/MacOS/PhD/PhD/WP1A - SC/';
project_label = 'Nifti';

participants_tsv_name = fullfile(root_dir,project_label,...
    'participants.tsv');

%% make a participants table and save 

participant_id = {'sub-01';'sub-02'};
age = [25;28];
sex = {'f';'m'}; 

t = table(participant_id,age,sex);

writetable(t,participants_tsv_name,'FileType','text','Delimiter','\t');