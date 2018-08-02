%This function graphs the congruent and incongruent staircases averaged across subjects. It takes in 
%a cell array called AllWorkers containing the data from every subject. It
%also takes a string descriptive_trial_type telling it which trial to look at
% based on the descriptive_trial_type. If the string is 'rdk3', this
% indicates that we're looking at the coherence staircase for the detection
% task. If it's 'rdk4', that means we're looking at the difference in
% angles given as options in the memory task.
%It also takes a boolean variable called congruent for which condition to look at.

%This (newer) version takes an average of all coherence values at every
%trial, excluding 0s.


function graphAveStaircase(AllWorkers, descriptive_trial_type)

    toPlot0=NaN(length(AllWorkers),65);
    toPlot1=NaN(length(AllWorkers),65);
    
    for i=1:length(AllWorkers)
        
        d=AllWorkers{i};   
        %incongruent block
        idx0 = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.block_congruent,0);
        %congruent block
        idx1 = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.block_congruent,1);
        %think something fishy happens on incongruent where congruent_block
        %is defaulted to 0
        %can fix by cutting off one more (64s instead of 65)
        if length(idx0) > 65 
            idx0=idx0(end-64:end);
        end
        
        if length(idx1) > 65 
            idx1=idx1(end-64:end);
        end
        
        %if it's coherence we want
        if strcmp(descriptive_trial_type,'rdk3')
            if length(idx0)==65
                coh0=d.coherence(idx0);
                coh0(coh0==0)=NaN;
                toPlot0(i,:)=coh0(coh0~=0);    
            end

            if length(idx1)==65
                coh1=d.coherence(idx1);
                coh1(coh1==0)=NaN;
                toPlot1(i,:)=coh1(coh1~=0);    
            end
        %if it's the angle difference we want
        elseif strcmp(descriptive_trial_type,'rdk4')
            if length(idx0)==65
                differences=zeros(60,1);%holds the differences between angle options in 2FC A/B
                cellArray=d.coherent_direction(idx0);
                for j=1:length(cellArray)
                    k=strfind(cellArray{j},',');
                    angle1=	str2double(cellArray{j}(2:k-1));
                    angle2=str2double(cellArray{j}(k:end-1));
                    differences(j)=min(abs(angle1-angle2),360-abs(angle1-angle2));
                end
                toPlot0(i,:)=differences;
            end
            
            if length(idx1)==65
                differences=zeros(60,1);%holds the differences between angle options in 2FC A/B
                cellArray=d.coherent_direction(idx1);
                for j=1:length(cellArray)
                    k=strfind(cellArray{j},',');
                    angle1=	str2double(cellArray{j}(2:k-1));
                    angle2=str2double(cellArray{j}(k:end-1));
                    differences(j)=min(abs(angle1-angle2),360-abs(angle1-angle2));
                end
                toPlot1(i,:)=differences;
            end            
        end     
    end
    
    stair0=nanmean(toPlot0);
    stair1=nanmean(toPlot1);
    
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