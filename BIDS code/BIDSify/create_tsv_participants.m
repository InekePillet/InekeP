%% Template Matlab script to create an BIDS compatible participants.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified RG 201809

%%
clear all
root_dir = '/Volumes/MacOS/PhD/PhD/WP1A/';
project_label = 'Pilot-SC-3DEPI-20cat';

participants_tsv_name = fullfile(root_dir,project_label,'participants.tsv');
%% make a participants table and save 

participant_id = {'sub-01';'sub-02';'sub-03';'sub-04';'sub-05';'sub-06';'sub-07';'sub-08';'sub-09';'sub-10';'sub-11';'sub-12';'sub-13';'sub-14';'sub-15';'sub-16';'sub-17';'sub-18';'sub-19'}; % ;'sub-02'
age = [24;35;27;29;25;29;35;24;45;28;23;33;26;37;22;41;29;41;25]; %;28
sex = {'m';'f';'m';'f';'m';'m';'m';'f';'m';'m';'f';'f';'f';'m';'m';'m';'m';'f';'f'}; %;'f'

t = table(participant_id,age,sex);

writetable(t,participants_tsv_name,'FileType','text','Delimiter','\t');