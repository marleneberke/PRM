% This script goes through the data, subject-by-subject, and analyzes them. 
% This analyzes the data in a data structure form by default, but you can
% change it to analyze the cell array or other data if you have it

clear;
close all;

% Create a path to the text file with all the subjects
path='subjects.txt';
% Make an ID for the subject list file
subjectListFileId=fopen(path);
% Read in the number from the subject list
numberOfSubjects = fscanf(subjectListFileId,'%d');

% Cell array that stores the struct for each worker as an element
AllWorkers={};

% For loop that loops through all the subjects
for i = 1:numberOfSubjects
    
    % Read the subject ID from the file, stop after each line
    subjectId = fscanf(subjectListFileId,'%s',[1 1]);
    % Print out the subject ID
    fprintf('subject: %s\n',subjectId);
    
    % Import the data
    Alldata = load([pwd '/Data/structure_data_' subjectId '.mat']);
    % Data structure that contains all the data for this subject
    d = Alldata.data;
    AllWorkers{i}=d;
    
    %how much practice she did
    numPrac=length(returnIndicesIntersect(d.practice, 1, d.descriptive_trial_type, 'rdk4'));
    disp(['Number of rounds of practice ' num2str(numPrac)])
    
    %looking for where descriptive_trial_type is rdk3
    idx = returnIndicesIntersect(d.descriptive_trial_type, 'rdk3', d.practice, 0);
    %problem is blank is filled in as false, so better off taking last 120
    idx=idx(end-119:end);
    coh=d.coherence(idx);
    %checking out convergence and congruence
    x=d.block_congruent(idx);
    x=x(coh~=0);
    x=logical(diff(x));
    x=find(x==1);
    figure;
    hold on;
    plot(coh(coh~=0))
    xticks([0;x])
    xticklabels({'unmatched','matched','unmatched','matched','unmatched','matched'})
    ylabel('Coherence level')
    xlabel('Trials')
    title('Coherence level as a function of condition (matched and unmatched)')
    hold off;
    
    %new idea, try adjusting based on rdk3's idx
    index=idx+2;
    sdAnalyze(d,index,'y','n',false)
    
    disp('AB task')
    
    %turning to AB part
    id= returnIndicesIntersect(d.descriptive_trial_type, 'rdk4', d.practice, 0);%looking at rdk4 now
    %only use last 120 entries
    id=id(end-119:end);
    %adding congruence
    d.block_congruent(id)=d.block_congruent(id-5);
    %copying correct and correct_response to conf
    d.correct(id+1)=d.correct(id);
    d.correct_response(id+1)=d.correct_response(id);
    sdAnalyze(d,id,'a','b',true,id+1,2);
    
    
    
    
end % End of for loop that loops through each subject


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









