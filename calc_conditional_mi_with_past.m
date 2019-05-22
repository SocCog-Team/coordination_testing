function condMI = calc_conditional_mi_with_past(x, z, order, windowSize)
% calc_transfer_entropy computes  conditional entropy (cCE) conditioned on a different signal.
% Given integer-valued signals x and z, cCE(x, z) characterizes average causal
% influence past x  values on present x conditioned to z (strictly speaking: the amount of uncertainty reduced 
% in present values of x by knowing the past values of x given present and past values of z.)
%
% INPUT
%   - x - 1xN array of positive integers representing the signal under study;   
%   - z - 1xN array of positive integers representing the known conditions;   
%   - order - number of points in the past taken into account.
% OPTIONAL INPUT
%   - windowSize - length of the sliding window used for estimating probabilities of 
%     x and y; by default windowSize = 5*cardX^(order+1)*cardY^(order) is
%     used, since this length provides reliable estimation of probabilities
%
% OUTPUT:
%   condEntropy - values of conditional entropy. 
%   - values condEntropy(order:order+windowSize) are computed for probabilities 
%     calculated for x(1:order+windowSize) and z(1:order+windowSize); 
%   - values condEntropy(i) for i > order+windowSize are computed for 
%     probabilities calculated in x(i-order-windowSize:i), z(i-order-windowSize:i); 
%
%
% EXAMPLE of use 
%{
 x = [ones(1, 40), zeros(1, 40), ones(1, 40), zeros(1, 40)];
 y = ones(1, 160);
 CE = calc_conditional_mi_with_past(x, y, 1, 30);
 plot(CE);

 x = [1,0,1,0,1];
 y = [1,0,1,0,1];
 CE = calc_conditional_mi_with_past(x, y, 1, 5);
 plot(CE);


% result: signal with 3 rounded peaks of width 30 centered at 55, 95 and 135
%}
  x = x - min(x); %make numbers in x start from 0 if it was not so
  z = z - min(z); %make numbers in z start from 0 if it was not so
  cardX = max(x) + 1; %compute size of alphabet
  cardZ = max(z) + 1; %compute size of alphabet
  lengthX = length(x);
  
  if (~exist('windowSize', 'var'))
    windowSize = 5*(cardX^(order+1))*(cardZ^(order+1));
  end
  if (windowSize > lengthX - order)
    windowSize = lengthX - order;
  end 
  
  presentOfProcess = x((order+1):lengthX);
  pastOfProcess = zeros(1, lengthX-order);
  zWithHistory = ones(1, lengthX-order);
  for iOrder = 0:order
      indexForOrder = order+1-iOrder:lengthX-iOrder;
      zContribution = (cardZ^iOrder)*z(indexForOrder);
      zWithHistory = zWithHistory + zContribution;
      presentOfProcess = presentOfProcess + cardX*zContribution;
      pastOfProcess = pastOfProcess + (cardX^order)*zContribution;  
      if (iOrder > 0)
        pastOfProcess = pastOfProcess + (cardX^(iOrder-1))*x(indexForOrder);  
      end  
  end
  
  nonzeroCorrection = 0.001;
  nZ = nonzeroCorrection*(1/cardZ^(order+1))*ones(cardZ^(order+1), 1);
  zEntropy = zeros(1, lengthX-order);
  for i = 1:lengthX - order 
    % add new symbols to the probability distribution
    nZ(zWithHistory(i)) = nZ(zWithHistory(i)) + 1;         
    
    if (i >= windowSize) %recompute distribution of zWithHistory current window
      pZ = nZ/(windowSize+nonzeroCorrection);
      zEntropy(i) = -sum(pZ.*log2(pZ));
     
      % remove last symbols from the probability distribution
      j = i - windowSize + 1;
      nZ(zWithHistory(j)) = nZ(zWithHistory(j)) - 1;   
    end
  end  
  zEntropy(1:windowSize-1) = zEntropy(windowSize);
  
  condMI = calc_mutual_information(presentOfProcess, pastOfProcess, windowSize) - zEntropy;
  condMI = [condMI(1), condMI];