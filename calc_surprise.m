function surprize = calc_surprise(x, order, minSampleNum)
  % x - is sequance of integer numbers starting from 1 
  x = x - min(x) + 1; %make numbers in x start from 1 if it was not so
  N = max(x); %compute size of alphabet
  
  nX = (1/N)*ones(N, N^order);
  nPrevXstr = ones(1, N^order);
  
  lengthX = length(x);
  prevXstr = zeros(1, lengthX);
   
  surprize = zeros(1, lengthX);
  lastXstr = sum((x(1:order) - 1).*(N.^(0:order-1)));
  for i = order+1:lengthX
    prevXstr(i) = lastXstr + 1;    
    nX(x(i), prevXstr(i)) = nX(x(i), prevXstr(i)) + 1;
    nPrevXstr(prevXstr(i)) = nPrevXstr(prevXstr(i)) + 1;    
    lastXstr = floor(lastXstr/N) + (x(i) - 1)*N^(order - 1);    
    
    if (i >= order+minSampleNum) %recompute nX each time
      pX = bsxfun(@rdivide, nX, nPrevXstr);
      if (i == order+minSampleNum) %compute surprise for first samples
        for j = order+1:i-1
          surprize(j) = -log2(pX(x(j), prevXstr(j)));
        end  
      end  
      iOld = i - minSampleNum + 1;
      nX(x(iOld), prevXstr(iOld)) = nX(x(iOld), prevXstr(iOld)) - 1;
      nPrevXstr(prevXstr(iOld)) = nPrevXstr(prevXstr(iOld)) - 1; 
      
      surprize(i) = -log2(pX(x(i), prevXstr(i)));
    end
    
    %recompute nX each time
  end  
end
