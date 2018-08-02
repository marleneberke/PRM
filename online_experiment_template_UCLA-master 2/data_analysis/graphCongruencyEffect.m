% This function graphs correlations between a congruency effect and meta-d'

function graphCongruencyEffect(congruencyEffects, metadP)

figure;
hold on;
scatter(congruencyEffects,metadP)
xlabel("Congruency Effect")
ylabel("log( meta-d' / d' ) on Memory Task")
%title(['Correlation coefficient is ' num2str(r)])
hold off;

end