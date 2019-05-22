function instantTransfer = calc_instant_transfer(x, y, isAvailable, order, windowSize)
% calc_instant_transfer_entropy computes instant transfer entropy (iTE).
% Given integer-valued signals x and y, iTE(x, y) characterizes average causal
% influence of y on x (strictly speaking: the amount of uncertainty reduced
% in value of x by knowing the current value of y given past values of x and y.)
%
% INPUT
%   - x - 1xN array of positive integers representing the effect (resulting signal);
%   - y - 1xN array of positive integers representing the cause;
%   - order - number of points in the past taken into account.
% OPTIONAL INPUT
%   - windowSize - length of the sliding window used for estimating probabilities of
%     x and y; by default windowSize = 5*cardX^(order+1)*cardY^(order) is
%     used, since this length provides reliable estimation of probabilities
%
% OUTPUT:
%   transferEntropy - values of local transfer entropy.
%   - values transferEntropy(order:order+windowSize) are computed for probabilities
%     calculated for x(1:order+windowSize) and y(1:order+windowSize);
%   - values transferEntropy(i) for i > order+windowSize are computed for
%     probabilities calculated in x(i-order-windowSize:i), y(i-order-windowSize:i);
%
%
% EXAMPLE of use
%{
 x = [ones(1, 40), zeros(1, 40), ones(1, 40), zeros(1, 40)];
 y = [0 x(1:end-1)];
 TE = calc_transfer_entropy(y, x, 1, 30);
 plot(TE);
 % result: signal with clear peaks at 41,81 and 121
%}
x = x - min(x) + 1; %make numbers in x start from 1 if it was not so
y = y - min(y) + 1; %make numbers in y start from 1 if it was not so
cardX = max(x); %compute size of alphabet
cardY = max(y); %compute size of alphabet

lengthX = length(x);
if (~exist('windowSize', 'var'))
    windowSize = 5*cardX^(order+1)*cardY^(order);
end
if (windowSize > lengthX - order)
    windowSize = lengthX - order;
end

% initialize distributions allowing for finite sample size
nAllXprevY = zeros(cardX, (cardY^order)*(cardX^order)); %joint distribution of current and previous x and previous y
nPrevXprevY = zeros(1, (cardY^order)*(cardX^order)); %joint distribution of previous x and y
nAllXallY = zeros(cardX, (cardY^(order+1))*(cardX^order)); %joint distribution of current and previous x and y
nPrevXallY = zeros(1, (cardY^(order+1))*(cardX^order)); %joint distribution of previous x and current and previous y

% descriptors for previous X and Y values as single number
prevXprevYstr = zeros(1, lengthX);
prevXallYstr = zeros(1, lengthX);

instantTransfer = zeros(1, lengthX);

lastXstr = sum((x(1:order) - 1).*(cardX.^(0:order-1)));
lastYstr = sum((y(1:order) - 1).*(cardY.^(0:order-1)));
currYstr = sum((y(1:order) - 1).*(cardY.^(1:order))); % we set the first entry to 1 since it is erased anyway
lastXlastYstr = lastXstr + lastYstr*(cardX^order);

nCountedTimePoints = 0;
%denomAllXY = numel(nAllXY) + windowSize;
%denomAllX = numel(nAllX) + windowSize;
for i = order+1:lengthX
    % update the decriptors depending on current y value
    currYstr = floor(currYstr/cardY) + (y(i) - 1)*cardY^(order);
    lastXcurrYstr = lastXstr + currYstr*(cardX^order);
    
    % add new symbols to the probability distribution
    prevXprevYstr(i) = lastXlastYstr + 1;
    prevXallYstr(i) = lastXcurrYstr + 1;
    
    if (isAvailable(i))
        nAllXprevY(x(i), prevXprevYstr(i)) = nAllXprevY(x(i), prevXprevYstr(i)) + 1;
        nPrevXprevY(prevXprevYstr(i)) = nPrevXprevY(prevXprevYstr(i)) + 1;
        nAllXallY(x(i), prevXallYstr(i)) = nAllXallY(x(i), prevXallYstr(i)) + 1;
        nPrevXallY(prevXallYstr(i)) = nPrevXallY(prevXallYstr(i)) + 1;
        nCountedTimePoints = nCountedTimePoints + 1;
    end    
        
    lastXstr = floor(lastXstr/cardX) + (x(i) - 1)*cardX^(order - 1);
    lastYstr = floor(lastYstr/cardY) + (y(i) - 1)*cardY^(order - 1);
    lastXlastYstr = lastXstr + lastYstr*(cardX^order);
    
    if (i >= order+windowSize) %recompute nX each time
        condProbXAllY = bsxfun(@rdivide, nAllXallY, nPrevXallY);
        condProbXPrevY = bsxfun(@rdivide, nAllXprevY, nPrevXprevY);
        
        instantTransfer(i) = condEntropy(nAllXallY./nCountedTimePoints, condProbXAllY) - ...
            condEntropy(nAllXprevY./nCountedTimePoints, condProbXPrevY);
        
        % remove last symbols from the probability distribution
        j = i - windowSize + 1;
        if (isAvailable(j))
            nAllXprevY(x(j), prevXprevYstr(j)) = nAllXprevY(x(j), prevXprevYstr(j)) - 1;
            nPrevXprevY(prevXprevYstr(j)) = nPrevXprevY(prevXprevYstr(j)) - 1;
            nAllXallY(x(j), prevXallYstr(j)) = nAllXallY(x(j), prevXallYstr(j)) - 1;
            nPrevXallY(prevXallYstr(j)) = nPrevXallY(prevXallYstr(j)) - 1;
            nCountedTimePoints = nCountedTimePoints - 1;
        end             
    end
end
instantTransfer(1:order+windowSize) = instantTransfer(order+windowSize);
end

function value = condEntropy(probDistrFull, probDistrCond)
    value = nansum(nansum(probDistrFull.*log2(probDistrCond)));
end

%function value = entropyValue(p)
%  value = -sum(sum(p.*log2(p)));
%end
