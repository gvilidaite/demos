% GV 5/8/16
%
% This script produces a bunch of responses for a pedestal masking paradigm
% for the Z and n parameters used in Figure 1 of the Noise Measures paper
clear all
close all

P = 2.4;
Q = 2;
Zlist = [8 8 32];
Nlist = [0.2 0.7 0.2];

finex = -24:36;
finexC = d_dBtoPercent(finex);
finexC(1) = 0;


for m = 1:length(Zlist)

    Z = Zlist(m);
    N = Nlist(m);
    
    for n = 1:length(finex)
        C = finexC(n);
        resp(m,n) = ((C.^P) ./ (Z + C.^Q)) + N; % normalization model

    end
    
    
end

figure(1);
hold on;

plot(finex,d_percentTodB(resp(1,:)),'r-','color', [0.8 0 0],'LineWidth',4);
plot(finex,d_percentTodB(resp(2,:)),'g-','color', [0 0.6 0],'LineWidth',4);
plot(finex,d_percentTodB(resp(3,:)),'b-','color', [0 0 0.8],'LineWidth',4);


axis([-24 36 -24 24]);
axis square;
ticksx = -24:6:36;
ticksy = ticksx;
set(gca, 'XTick',ticksx, 'YTick',ticksy);
xlabel('Contrast (%)', 'FontSize', 22);
ylabel('Response', 'FontSize', 22);
print('Figure 1', '-deps');









