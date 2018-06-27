function coordinationStruct = check_coordination_RT(isOwnChoice, sideChoice, releaseTime, reachTime, alpha)
% check_coordination_RT tests whether there is a coordination between two players.
% The test is compound and consists of 7 subtests based on choices only 
% (these are performed by check_coordination) and 4 additional tests taking
% into account reaction times. They are
%
% 1-4) Tests of target choice independendence on (1, 2) release and (3,4) reach time 
%      for each Player:
%    Fisher test on contingency table (rows: own/other choice, columns leading/following role)
%    rejecting null hypothesis is an indication of coordination.
%    Outcome: pValue. pValue > alpha => independent choices;
%                     pValue < alpha => coordinated choices.
%    if both tests show no dependence, players probably were not influenced
%    by being "leader" or "follower"

% 5-6) Tests of bias in role distribution:
%    Two-tailed binomial test:
%    is probability of being leader higher for Player 1 than chance (0.5)? 
%    Role is defined by release (5) or reach (6) times
%    Outcome: zScore. zScore > epsilon => Player 1 was a leader more often;
%                     epsilon > zScore > -epsilon => no preference;
%                     zScore < -epsilon => Player 2 was a leader more often.

% 7-10) Tests of selfishness for each player when being Leaders:
%    Two-tailed binomial test:
%    is proportion of OWN choices when being leader (7,8 by release; 9,10 by reach) 
%    higher than chance (0.5) for Players 1 and 2 respectively?
%    Outcome: zScore. zScore > epsilon => selfish choices;
%                     epsilon > zScore > -epsilon => may indicate fair coordination;
%                     zScore < -epsilon => self-sacrificing choices.

%
% INPUT
%   - isOwnChoice - 2xN array of booleans,
%     isOwnChoice(i,j) = 1 indicated that player i at trial j selected own target;
%   - sideChoice - 2xN array of booleans,
%     sideChoice(i,j) = 1 indicated that player i at trial j selected side 1;
% OPTIONAL INPUT
%  - alpha - significance level (by default alpha = 0.05)
%
% OUTPUT:
%   coordinationStruct - a structure with fields:
%   - releaseOrderIndependence - 1x2 array of pValues for independence of 
%     Players target choices on being first/last on release;
%   - reachOrderIndependence - 1x2 array of pValues for independence of 
%     Players target choices on being first/last on reach;
%   - player1FirstReleaseScore - zScore for proportion of Player 1
%     releasing first computed for the mean of 50%;
%   - player1FirstReachScore - zScore for proportion of Player 1
%     reaching first computed for the mean of 50%;
%   - ownPreferenceWhenFirstReach - 1x2 array of zScores for proportions of 
%     OWN choices of each player when releasing first, computed for the mean of 50%;
%   - ownPreferenceWhenFirstRelease - 1x2 array of zScores for proportions of
%     OWN choices of each player when reaching target first, computed for the mean of 50%;




%   - SummaryString - test results condensed to a single-line string; 
%   - SummaryCell - test results condensed to a cell array (multi-line string);
%   - shortOutcome - 1x7 array with short description of players' interaction:
%        shortOutcome[1] = 1 for coordinated target choice, 0 otherwise
%        shortOutcome[2] = 1 for coordinated side choice, 0 otherwise
%        shortOutcome[3] = 1 for joint prefernce of choosing same, 0 otherwise
%        shortOutcome[4-5] = 1 for own target preference,
%                           -1 for other side preference,
%                            0 otherwise (one value for each player)
%        shortOutcome[6-7] = 1 for matching avoidence, 0 otherwise (one value for each players)
%
% EXAMPLE of use
%{
 N = 200;
 target1 = randi(2, 1, N) - 1; %random choices
 side1 = randi(2, 1, N) - 1; %random choices
 target2 = (~target1) | side1; %P2 selects own target if P1 selects other target
                               %or P1 selects right target
 side2 = xor(side1, ~xor(target1, target2));
 isOwnChoice = [target1; target2];
 sideChoice = [side1; side2];
 coord = check_coordination(isOwnChoice, sideChoice);
 % expected outcomes:
 % coord.targetChoiceIndependence, coord.sideChoiceIndependence - almost 0;
 % coord.noSamePreference - almost 0;
 % coord.ownPreference[1] in [-1, 1], coord.ownPreference[2] > 2;
 % coord.noMatchingAvoidance - almost 1;
 % coord.shortOutcome
%}

% REFERENCES
% [1] Schmolesky MT, Wang Y, Hanes DP, Thompson KG, Leutgeb S, Schall JD, Leventhal AG. 
%     Signal timing across the macaque visual system. 
%     Journal of neurophysiology. 1998; 79(6):3272-8.
%
% [2] Nowak LG, Bullier J. 
%     The timing of information transfer in the visual system. 
%     In Extrastriate cortex in primates 1997 (pp. 205-241). Springer, Boston, MA.
%

if (nargin >= 5) && isnumeric(alpha) && (alpha >= 0) && (alpha <= 1)
    % nothing to do we just accept the given alpha as valid
else
    alpha = 0.05;
end

% Tests 1-7
coordinationStruct = check_coordination(isOwnChoice, sideChoice, alpha);

% preparation
isFirstRelease = [(releaseTime(1, :) - releaseTime(2, :) < -deltaRT), ...  
                  (releaseTime(1, :) - releaseTime(2, :) > deltaRT)];
isFirstReach = [(reachTime(1, :) - reachTime(2, :) < -deltaRT), ...  
                (reachTime(1, :) - reachTime(2, :) > deltaRT)];


% Test 1-4: target choice independendence on release/reach order
firstReleaseOwn = nnz(isOwnChoice & isFirstRelease);
firstReleaseOther = nnz(~isOwnChoice & isFirstRelease);
secondReleaseOwn = nnz(isOwnChoice & ~isFirstRelease);
secondReleaseOther = nnz(~isOwnChoice & ~isFirstRelease);

firstReachOwn = nnz(isOwnChoice & isFirstReach);
firstReachOther = nnz(~isOwnChoice & isFirstReach);
secondReachOwn = nnz(isOwnChoice & ~isFirstReach);
secondReachOther = nnz(~isOwnChoice & ~isFirstReach);

coordinationStruct.releaseOrderIndependence = zeros(2,1);
coordinationStruct.reachOrderIndependence = zeros(2,1);
for iPlayer = 1:2
  contMatrix = [firstReleaseOwn(iPlayer), firstReleaseOther(iPlayer);...
                secondReleaseOwn(iPlayer), secondReleaseOther(iPlayer)];
  [~, coordinationStruct.releaseOrderIndependence(iPlayer)] = fishertest(contMatrix);
  contMatrix = [firstReachOwn(iPlayer), firstReachOther(iPlayer);...
                secondReachOwn(iPlayer), secondReachOther(iPlayer)];
  [~, coordinationStruct.reachOrderIndependence(iPlayer)] = fishertest(contMatrix);
end 


% Test 5-6: selfishness for each player
pChance = 0.5;
nP1Leader = [firstReleaseOwn(1) + firstReleaseOther(1),  firstReachOwn(1) + firstReachOther(1)];
nTotal = nP1Leader + [secondReleaseOwn(1) + secondReleaseOther(1),  secondReachOwn(1) + secondReachOther(1)];
zScore = (nP1Leader - pChance*nTotal)./sqrt(pChance*(1-pChance)*nTotal);
coordinationStruct.player1FirstReleaseScore = zScore(1);
coordinationStruct.player1FirstReachScore = zScore(2);

% Test 7-10: matching avoidance for each player
for iPlayer = 1:2
  nLeaderOwn = [firstReleaseOwn(iPlayer),  firstReachOwn(iPlayer)];
  nLeaderTotal = nP1Leader + [firstReleaseOther(iPlayer), firstReachOther(iPlayer)];
  zScore = (nLeaderOwn - pChance*nLeaderTotal)./sqrt(pChance*(1-pChance)*nLeaderTotal);
  coordinationStruct.ownPreferenceWhenFirstReach(iPlayer) = zScore(1);
  coordinationStruct.ownPreferenceWhenFirstRelease(iPlayer) = zScore(2);
end 

% Total outcome in simplified form
coordinationStruct.shortOutcome = zeros(1, 10);
coordinationStruct.shortOutcome(1:2) = coordinationStruct.releaseOrderIndependence < alpha;
coordinationStruct.shortOutcome(3:4) = coordinationStruct.reachOrderIndependence < alpha;

zCritical = -norminv(alpha/2);
coordinationStruct.shortOutcome(5:6) = 0;
if (coordinationStruct.player1FirstReleaseScore > zCritical)
  coordinationStruct.shortOutcome(5) = 1;
elseif (coordinationStruct.player1FirstReleaseScore < -zCritical)
  coordinationStruct.shortOutcome(5) = -1; 
end
if (coordinationStruct.player1FirstReachScore > zCritical)
  coordinationStruct.shortOutcome(5) = 1;
elseif (coordinationStruct.player1FirstReachScore < -zCritical)
  coordinationStruct.shortOutcome(5) = -1; 
end

ownPreferenceTestOutcomeWhenFirstRelease = zeros(1, 2);
ownPreferenceTestOutcomeWhenFirstRelease(coordinationStruct.ownPreferenceWhenFirstRelease > zCritical) = 1;
ownPreferenceTestOutcomeWhenFirstRelease(coordinationStruct.ownPreferenceWhenFirstRelease < -zCritical) = -1;
coordinationStruct.shortOutcome(7:8) = ownPreferenceTestOutcomeWhenFirstRelease;

ownPreferenceTestOutcomeWhenFirstReach = zeros(1, 2);
ownPreferenceTestOutcomeWhenFirstReach(coordinationStruct.ownPreferenceWhenFirstReach > zCritical) = 1;
ownPreferenceTestOutcomeWhenFirstReach(coordinationStruct.ownPreferenceWhenFirstReach < -zCritical) = -1;
coordinationStruct.shortOutcome(9:10) = ownPreferenceTestOutcomeWhenFirstReach;

%{
% now create a textual representation of the data
outString = ['Coordination summary: ', num2str(coordinationStruct.shortOutcome), ' ; significance threshold: ', num2str(alpha), ...
    ';p(TargetChoiceCoord): ', num2str(coordinationStruct.targetChoiceIndependence), '; p(sideChoiceCoord): ', num2str(coordinationStruct.sideChoiceIndependence), ...
    '; p(SameChoiceCoord): ', num2str(coordinationStruct.noSamePreference), '; Selfishness Zcrit: ', num2str(zCritical),'; Selfishness A Z: ', num2str(zScore(1)), '; Selfishness B Z: ', num2str(zScore(2)), ...
    '; p(MatchAvoidance) A: ', num2str(coordinationStruct.noMatchingAvoidance(1)), '; p(MatchAvoidance) B: ', num2str(coordinationStruct.noMatchingAvoidance(2))];



% multi line outout
outCell = {['Coordination summary: ', num2str(coordinationStruct.shortOutcome), ' ; significance threshold ', num2str(alpha), ' uncorrected.']; ...
    ['p(TargetChoiceCoord): ', num2str(coordinationStruct.targetChoiceIndependence), '; p(sideChoiceCoord): ', num2str(coordinationStruct.sideChoiceIndependence), ...
    '; p(SameChoiceCoord): ', num2str(coordinationStruct.noSamePreference)]; ...
    ['Selfishness Zcrit: ', num2str(zCritical),'; Selfishness A Z: ', num2str(zScore(1)), '; Selfishness B Z: ', num2str(zScore(2)), ...
    '; p(MatchAvoidance) A: ', num2str(coordinationStruct.noMatchingAvoidance(1)), '; p(MatchAvoidance) B: ', num2str(coordinationStruct.noMatchingAvoidance(2))]};
coordinationStruct.SummaryString = outString;
coordinationStruct.SummaryCell = outCell;
%}
end
