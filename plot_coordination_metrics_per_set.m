function plot_coordination_metrics_per_set(dataset, metrics, fontSize, markerSize)
nSet = length(dataset);
nFile = cell2mat(cellfun(@(x) length(unique(x.captions)), dataset, 'UniformOutput',false));
    
for iSet = 1:nSet   
    % plot per-session MI, TE, average and non-random reward
    figure('Name',[dataset{iSet}.setName, ' per-session summary']);
    set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
    
    nPlot = 8;
    maxTE = max(max([metrics(iSet).teTarget; metrics(iSet).teSide]));
    maxTE = max(maxTE, 0.2);
    for iPlot = 1:nPlot
        subplot(nPlot/2, 2, iPlot);
        if ((iPlot == 1) || (iPlot == 2) || (iPlot == 5)|| (iPlot == 6) || (iPlot == 7))
            if (iPlot == 1)
                y = [metrics(iSet).shareOwnChoices];
                minY = 0;
                maxY = 1;
                yCaption = {'share own choices'};
            elseif (iPlot == 2)
                y = metrics(iSet).shareLeftChoices;
                minY = 0;
                maxY = 1;
                yCaption = {'share objective left choices'};
            elseif (iPlot == 5)
                y = metrics(iSet).teTarget;
                minY = 0;
                maxY = maxTE + 0.01;
                yCaption = {'target transfer entropy'};
            elseif (iPlot == 6)
                y = metrics(iSet).teSide;
                minY = 0;
                maxY = maxTE + 0.01;
                yCaption = {'side transfer entropy'};
            elseif (iPlot == 7)
                y = metrics(iSet).playerReward;
                minY = 1;
                maxY = 4.01;
                yCaption = {'average reward'};
            end
            hold on
            plot(y(1,:), 'r-o', 'MarkerSize', markerSize);
            plot(y(2,:), 'b-s', 'MarkerSize', markerSize);            
            if (iPlot == 1) || (iPlot == 2) 
                plot(metrics(iSet).shareJointChoices, 'MarkerSize', markerSize, 'Color', [0.5,0,0.5]);
                plot([1,nFile(iSet)], [0.5, 0.5], 'k--')                
            elseif (iPlot == 7)
                plot([1,nFile(iSet)], [2.75, 2.75], 'k--')   
                plot(metrics(iSet).averReward, 'MarkerSize', markerSize, 'Color', [0.5,0,0.5]);
            end
            hold off
            
        elseif (iPlot == 8)
            y = metrics(iSet).dltReward;
            yInt = metrics(iSet).dltConfInterval;
            yInt(2,:) = yInt(2,:) - yInt(1,:); % to provide white area below conf interval
            minY = -0.5;
            maxY = 1.1;
            yCaption = {'non-random reward'};
            bottomAreaColor = [1.0, 1.0, 1.0];
            
            hold on
            h = area(yInt', minY);
            
            h(1).FaceColor = bottomAreaColor;
            if (length(h) > 1)
                h(2).FaceColor = [1.0, 0.5, 1.0];
            end
            plot(y(1,:), '-d', 'MarkerSize', markerSize, 'Color', [0.5,0,0.5]);
            plot([1,nFile(iSet)], [0.0, 0.0], 'k--')
            hold off
        else        
            if (iPlot == 3)
                y = metrics(iSet).miTarget;
                signifIndex = logical(metrics(iSet).miTargetSignif);
                minY = 0;
                maxY = 1;
                yCaption = {'target mutual information'};
                
            elseif (iPlot == 4)
                y = metrics(iSet).miSide;
                signifIndex = logical(metrics(iSet).miSideSignif);
                minY = 0;
                maxY = 1;
                yCaption = {'side mutual information'};
            end
            x = 1:nFile(iSet);
            hold on
            plot(x, y, '-d', 'MarkerSize', markerSize, 'Color', [0.5,0,0.5]);
            plot(x(signifIndex), y(signifIndex), 'd', 'MarkerSize', markerSize, 'Color', [0.5,0,0.5], 'MarkerFaceColor', [0.5,0,0.5]);
            hold off
        end
        %if (iPlot >= nPlot - 1)
        %  xlabel('Session number', 'fontsize', FontSize, 'FontName', 'Arial');
        %end
        % sessions with non-unique labels are merged, so we need to select only unique labels
        ylabel(yCaption, 'fontsize', fontSize, 'FontName', 'Arial');
        axis([0.99, nFile(iSet) + 0.01, minY, maxY]);
        [~, labelIndices] = unique(dataset{iSet}.captions);
        correctLabel = dataset{iSet}.captions(sort(labelIndices));
        if ((iPlot == 7) || (iPlot == 8))
            set( gca, 'fontsize', fontSize, 'XTick', 1:nFile(iSet), 'XTickLabel', correctLabel, 'XTickLabelRotation',45, 'FontName', 'Arial');%'FontName', 'Times');
        else
            set( gca, 'fontsize', fontSize, 'XTick', 1:nFile(iSet), 'XTick', [], 'FontName', 'Arial');%'FontName', 'Times');
        end
        %set( gca, 'fontsize', FontSize, 'FontName', 'Arial');%'FontName', 'Times');
        %title(dataset{1}.setName, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
    end
    set( gcf, 'PaperUnits','centimeters' );
    xSize = 19; ySize = 25;
    xLeft = 0; yTop = 0;
    set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    print ( '-depsc', '-r600', ['perSession', '_', dataset{iSet}.setName]);
    print('-dpdf', ['perSession', '_', dataset{iSet}.setName], '-r600');
end
end