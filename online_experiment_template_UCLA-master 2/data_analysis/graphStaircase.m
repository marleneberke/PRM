% This function graphs the intensity of a staircase. As input, it takes a
% struct called dataStructure, which must have the fields
% descritpive_trial_type, practice, and block_coherent. The function
% graphStaircase also takes a string (descriptive_trial_type) telling it which trial to look at
% based on the descriptive_trial_type. The string intensity tells what the thing is that we're staircasing. It can either be 'coherence' or 'angle'. It also takes a boolean variable called congruent
% for which condition to look at. i gives the subject number. It only graphs the values for
% non-practice trials.
%l for legend

%it returns toPlot, an array of containting the intensity of the staircase
%that we would plot

function toPlot = graphStaircase(dataStructure, descriptive_trial_type, intensity, congruent, i)
    d=dataStructure;
    
    idx = returnIndicesIntersect(d.descriptive_trial_type, descriptive_trial_type, d.practice, 0, d.block_congruent,congruent);
    %problem is blank is filled in as false, so better off taking last 120
    idx=idx(end+1-(120/2):end);
    
    if (strcmp(intensity,'coherence'))
        coh=d.coherence(idx);
        toPlot=coh(coh~=0);
    elseif (strcmp(intensity,'angle'))
        differences=zeros(60,1);%holds the differences between angle options in 2FC A/B
        cellArray=d.coherent_direction(idx);
        for j=1:length(cellArray)
            k=strfind(cellArray{j},',');
            angle1=str2num(cellArray{j}(2:k-1));
            angle2=str2num(cellArray{j}(k:end-1));
            differences(j)=min(abs(angle1-angle2),360-abs(angle1-angle2));            
        end
        toPlot=differences;
    else
        disp('Value for intensity is not valid. Only the strings coherence or angle are valid inputs');
    end
    
%     figure;
%     plot(toPlot)
%     hold on;
%     ylabel('Intensity level')
%     xlabel('Trials')
%     if congruent
%         text='congruent';
%     else
%         text='incongruent';
%     end
%     title(['Intensity during the ' text ' block for subject ' num2str(i)])
% %     title(['Intensity during the ' text ' block'])
% %     l = [l, 'subject ' num2str(i)];
% %     legend(['subject ' num2str(i)])
%     hold off;
  
end