%This function graphs the staircase averaged across subjects. It takes in 
%a cell array called AllWorkers containing the data from every subject. It
%also takes a string descriptive_trial_type telling it which trial to look at
% based on the descriptive_trial_type. 

%This (older) version only averages values for the first n trial for which
%all subjects have non-zero coherence. ~30 per condition.


function graphAveStaircaseOld(AllWorkers, descriptive_trial_type)
    %set parameter number of practice trials
    numPractice=5; %usually 5
    %set parameter number of trials of each condition
    numTrialsEach=40; %usually 60

    %array that stores the toPlots for each subject
    stair0=zeros(99999,1);
    stair1=zeros(99999,1);
    
    %keep track of minimum length of the toPlots
    min0=inf;
    min1=inf;

    for i=1:length(AllWorkers)
        
        d=AllWorkers{i};
        %incongruent
        idx0 = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.block_congruent,0);
        %congruent
        idx1 = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.block_congruent,1);
        
        %think something fishy happens on incongruent where congruent_block
        %is defaulted to 0
        if length(idx0) > (numPractice+numTrialsEach) 
            idx0=idx0(end-(numPractice+numTrialsEach-1):end);
        end
        
        if length(idx1) > numPractice+numTrialsEach 
            idx1=idx1(end-(numPractice+numTrialsEach-1):end);
        end
        
        coh0=d.coherence(idx0);
        toPlot0=coh0(coh0~=0);
        
        coh1=d.coherence(idx1);
        toPlot1=coh1(coh1~=0);
        
        if length(toPlot0) < min0
            min0=length(toPlot0);
        end 
        
        if length(toPlot1) < min1
            min1=length(toPlot1);
        end
        
        stair0=stair0(1:min0)+toPlot0(1:min0);
        stair1=stair1(1:min1)+toPlot1(1:min1);
    end
    
    stair0=stair0/length(AllWorkers);
    stair1=stair1/length(AllWorkers);
    
    %setting ylabel
    if strcmp(descriptive_trial_type,'rdk3')
        ylab='Coherence level';
    elseif strcmp(descriptive_trial_type,'rdk4')
        ylab='Angle difference';
    end
   
    
    figure;
    hold on;
    plot(stair0)
    plot(stair1)
    ylabel(ylab)
    xlabel('Trials') 
    title(['Averaged across ' num2str(length(AllWorkers)) ' subjects'])
    legend('incongruent','congruent')
    hold off;
end