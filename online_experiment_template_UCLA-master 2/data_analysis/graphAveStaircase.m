%This function graphs the staircase averaged across subjects. It takes in 
%a cell array called AllWorkers containing the data from every subject. It
%also takes a string descriptive_trial_type telling it which trial to look at
% based on the descriptive_trial_type. 
%It also takes a boolean variable called congruent for which condition to look at.

%new version


function graphAveStaircase(AllWorkers, descriptive_trial_type,congruent)

    toPlot=NaN(length(AllWorkers),60);
    

    for i=1:length(AllWorkers)
        
        d=AllWorkers{i};        
        idx = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.practice, 0, d.block_congruent,congruent);
        %think something fishy happens on incongruent where congruent_block
        %is defaulted to 0
        if length(idx) > 60 
            idx=idx(end-59:end);
        end
        
        if length(idx)==60
            coh=d.coherence(idx);
            coh(coh==0)=NaN;
            toPlot(i,:)=coh(coh~=0);    
        end     
    end
    
    stair=nanmean(toPlot);
    
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