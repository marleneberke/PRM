%Returns correct rate on memory task when there's no coherent motion during
%the delay, separated by condition


function [correctRateCong, correctRateInCong] = correctRateMem(d)

memIndex = returnIndicesIntersect(d.descriptive_trial_type,'rdk4', d.practice,0);
memIndex=memIndex(end-119:end);
delayIndex = returnIndicesIntersect(d.descriptive_trial_type,'rdk3',d.practice,0);
delayIndex=delayIndex(end-119:end);
%congruent
correctRateCong=(length(returnIndicesIntersect(d.correct(memIndex),1,d.block_congruent(memIndex),1))-length(returnIndicesIntersect(d.coherence(delayIndex),0,d.correct(memIndex),1,d.block_congruent(memIndex),1)))/length(returnIndicesIntersect(d.coherence(delayIndex),0,d.block_congruent(memIndex),1));
%incongruent
correctRateInCong=(length(returnIndicesIntersect(d.correct(memIndex),1,d.block_congruent(memIndex),0))-length(returnIndicesIntersect(d.coherence(delayIndex),0,d.correct(memIndex),1,d.block_congruent(memIndex),0)))/length(returnIndicesIntersect(d.coherence(delayIndex),0,d.block_congruent(memIndex),0));

end