%This function graphs the staircase averaged across subjects. It takes in 
%a cell array called AllWorkers containing the data from every subject. It
%also takes a string descriptive_trial_type telling it which trial to look at
% based on the descriptive_trial_type. 
%It also takes a boolean variable called congruent for which condition to look at.


function graphAveStaircase(AllWorkers, descriptive_trial_type,congruent)
    %array that stores the toPlots for each subject
    stair=zeros(99999,1);
    
    %keep track of minimum length of the toPlots
    min=inf;

    for i=1:length(AllWorkers)
        
        d=AllWorkers{i};        
        idx = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.practice, 0, d.block_congruent,congruent);
        coh=d.coherence(idx);
        toPlot=coh(coh~=0);
        
        if length(toPlot) < min
            min=length(toPlot);
        end  
        
        stair=stair(1:min)+toPlot(1:min);
    end
    
    stair=stair/length(AllWorkers);
    
    %setting ylabel
    if strcmp(descriptive_trial_type,'rdk3')
        ylab='Coherence level';
    elseif strcmp(descriptive_trial_type,'rdk4')
        ylab='Angle difference';
    end
    
    %setting title
    if congruent
        text='congruent condition';
    else
        text='incongruent condition';
    end
    
    figure;
    plot(stair)
    hold on;
    ylabel(ylab)
    xlabel('Trials') 
    title(['Averaged across ' num2str(length(AllWorkers)) ' subjects, ' text])
    hold off;
end