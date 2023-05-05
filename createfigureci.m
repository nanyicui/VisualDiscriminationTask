function createfigureci(yvector1, yvector2, n, figure1)
%CREATEFIGURE(YVECTOR1,YVECTOR2)
%  YVECTOR1:  bar yvector
%  YVECTOR2:  bar yvector

% Create axes
axes1 = axes('Parent',figure1,'YTickLabel','','YTick',zeros(1,0),'XTickLabel','','XTick',zeros(1,0),...
    'Position',[0.13 0.7-n length(yvector1)/200 0.011]);
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[1 length(yvector1)]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
hold(axes1,'all');

% Create bar
bar(yvector1,'FaceColor',[0 0 0],'BarWidth',1,'Parent',axes1);

% Create axes
% if n==7/20
%     axes2 = axes('Parent',figure1,'YTickLabel','','YTick',zeros(1,0),'XTickLabel',{'0','25','50','75'},'XTick',[0 25 50 75],...
%         'Position',[0.13 0.689-n length(yvector1)/136 0.011]);
% else
    axes2 = axes('Parent',figure1,'YTickLabel','','YTick',zeros(1,0),'XTickLabel','','XTick',zeros(1,0),...
        'Position',[0.13 0.689-n length(yvector1)/200 0.011]);
% end
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes2,[1 length(yvector2)]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[0 1]);
hold(axes2,'all');

% Create bar
bar(yvector2,'FaceColor',[0 0 0],'BarWidth',1,'Parent',axes2);

