<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> c07945e1de025c259e1d6dfe98bbaaa260634ffb
nRand = 10^7;
nTrial = 100;
alpha = 0.0001;
binaryWeightArray = 2.^(0:6);
resDistr = zeros(1, 128);
for iRand = 1:nRand
  isOwnChoice = randi(2,2,nTrial) - 1;
  sideChoice = randi(2,2,nTrial) - 1;

  coordinationStruct = check_coordination(isOwnChoice, sideChoice, alpha);
  index = 1 + sum(abs(coordinationStruct.shortOutcome).*binaryWeightArray);
  resDistr(index) = resDistr(index) + 1;
<<<<<<< HEAD
=======
=======
nRand = 10^7;
nTrial = 100;
alpha = 0.0001;
binaryWeightArray = 2.^(0:6);
resDistr = zeros(1, 128);
for iRand = 1:nRand
  isOwnChoice = randi(2,2,nTrial) - 1;
  sideChoice = randi(2,2,nTrial) - 1;

  coordinationStruct = check_coordination(isOwnChoice, sideChoice, alpha);
  index = 1 + sum(abs(coordinationStruct.shortOutcome).*binaryWeightArray);
  resDistr(index) = resDistr(index) + 1;
>>>>>>> 9cc00846176e9388f7e6a657e0733ee144b47251
>>>>>>> c07945e1de025c259e1d6dfe98bbaaa260634ffb
end  