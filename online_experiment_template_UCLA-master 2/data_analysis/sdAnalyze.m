% This function prints the hit rates and false alarm rates broken up by
% congruence level. It requires a dataStructure with fields response,
% correct_response, and block_congruent. The second argument is the indices
% of the trials we want to analyze. It is an array. The last inputs are the
% responses we define as a positive and negative. They are how response and
% correct response are encoded. calcMetadPrime is a boolean saying whether
% or not to do meta-d' analysis. confOptions is an int for the number of
% confidence options (if confidence is rated 1-5, then confOptions is 5).

function [hitRate, hitRateCong, hitRateCong1, hitRateCong2, hitRateInCong, hitRateInCong1, hitRateInCong2, faRate, faRateCong, faRateCong1, faRateCong2, faRateInCong, faRateInCong1, faRateInCong2, dPrime, dPrimeCong, dPrimeInCong, metadP]=sdAnalyze(dataStructure, index, positive, negative, calcMetadPrime, confIndex, confOptions)
    d=dataStructure;
    
% %     %correct stats
%     totalCorrect=sum(d.correct(index));
%     %disp(['Total correct is ' num2str(totalCorrect)])
%     correctRate=sum(d.correct(index))/length(d.correct(index));
%     %disp(['Correct rate is ' num2str(correctRate)])
%     %by congruence
%     correctRateCong=length(returnIndicesIntersect(d.correct(index),1,d.block_congruent(index),1))/length(returnIndices(d.block_congruent(index),1));
%     %disp(['Correct rate on congruent trials is ' num2str(correctRateCong)])
%     correctRateInCong=length(returnIndicesIntersect(d.correct(index),1,d.block_congruent(index),0))/length(returnIndices(d.block_congruent(index),0));
%     %disp(['Correct rate on incongruent trials is ' num2str(correctRateInCong)])
    
    %hits
    hitNum=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive));
    hitRate=hitNum/length(returnIndices(d.correct_response(index),positive));
    %disp(['hitNum is ' num2str(hitNum)])
    %disp(['Overall hitRate is ' num2str(hitRate)])
    
    %by congruence
    hitsMatch=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 1));
    hitRateCong=hitsMatch/length((returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 1)));
    hitsUnMatch=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 0));
    hitRateInCong=hitsUnMatch/length((returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 0)));
    
    hitsCong1=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 1, d.remember(index),1));
    hitRateCong1=hitsCong1/length(returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 1, d.remember(index),1));
    hitsCong2=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 1, d.remember(index),2));
    hitRateCong2=hitsCong2/length(returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 1, d.remember(index),2));
    hitsInCong1=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 0, d.remember(index),1));
    hitRateInCong1=hitsInCong1/length(returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 0, d.remember(index),1));
    hitsInCong2=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),positive, d.block_congruent(index), 0, d.remember(index),2));
    hitRateInCong2=hitsInCong2/length(returnIndicesIntersect(d.correct_response(index),positive, d.block_congruent(index), 0, d.remember(index),2));
    
    
    %FA
    %faNum=length(returnIndicesIntersect(d.response(index),positive,d.correct_response(index),negative));
    faNum=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative));
    faRate=faNum/length(returnIndices(d.correct_response(index),negative));
    
    %by congruence
    faMatch=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative,d.block_congruent(index),1));
    faRateCong=faMatch/length((returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 1)));
    faUnMatch=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative,d.block_congruent(index),0));
    faRateInCong=faUnMatch/length((returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 0)));
    
    faCong1=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative, d.block_congruent(index), 1, d.remember(index),1));
    faRateCong1=faCong1/length(returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 1, d.remember(index),1));
    faCong2=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative, d.block_congruent(index), 1, d.remember(index),2));
    faRateCong2=faCong2/length(returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 1, d.remember(index),2));
    faInCong1=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative, d.block_congruent(index), 0, d.remember(index),1));
    faRateInCong1=faInCong1/length(returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 0, d.remember(index),1));
    faInCong2=length(returnIndicesIntersect(d.correct(index),0,d.correct_response(index),negative,d.block_congruent(index), 0, d.remember(index),2));
    faRateInCong2=faInCong2/length(returnIndicesIntersect(d.correct_response(index),negative, d.block_congruent(index), 0, d.remember(index),2));

    
    %d'
    dPrime=norminv(hitRate)-norminv(faRate);
    %disp(['Overall dPrime is ' num2str(dPrime)])
    dPrimeCong=norminv(hitRateCong)-norminv(faRateCong);
    %disp(['In matched condition, dPrime is ' num2str(dPrimeCong)])
    dPrimeInCong=norminv(hitRateInCong)-norminv(faRateInCong);
    %disp(['In unmatched condition, dPrime is ' num2str(dPrimeInCong)])
    
    if calcMetadPrime
        %getting different confidence levels assuming confidence is
        %question following this one
        %also, lower number means higher confidence
        nR_S1=zeros(2*confOptions,1);
        nR_S2=zeros(2*confOptions,1);
        for conf=1:confOptions
            nR_S1(conf)=length(returnIndicesIntersect(d.response(confIndex), num2str(conf), d.correct_response(confIndex), positive, d.correct(confIndex), 1));
            nR_S1(2*confOptions+1-conf)=length(returnIndicesIntersect(d.response(confIndex), num2str(conf), d.correct_response(confIndex), positive, d.correct(confIndex), 0));
                       
            nR_S2(conf)=length(returnIndicesIntersect(d.response(confIndex), num2str(conf), d.correct_response(confIndex), negative, d.correct(confIndex), 0));
            nR_S2(2*confOptions+1-conf)=length(returnIndicesIntersect(d.response(confIndex), num2str(conf), d.correct_response(confIndex), negative, d.correct(confIndex), 1));
        end
        
%         disp('nR_S1 is equal to ')
%         disp(nR_S1)
%         disp('nR_S2 is equal to ')
%         disp(nR_S2)
        
        out = type2_SDT_SSE(nR_S1, nR_S2);
        %disp(['dPrime is equal to ',num2str(out.da),'.'])
        %disp(['meta dPrime is equal to ',num2str(out.meta_da),'.']) 
        metadP=out.meta_da;
        if isempty(metadP)
            metadP=NaN;
        end
    end
    
end