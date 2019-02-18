function pSee = computeProbabilitiesToSee(reactionTime, minDRT)
k = 0.08;

nTrial = length(reactionTime);
dRT = reactionTime(1,:) - reactionTime(2,:);
player1SeesIndex = (dRT > 0);
player2SeesIndex = (dRT < 0);
pSeeBothPlayers = zeros(1, nTrial);
pSeeBothPlayers(player1SeesIndex) =  1./(1 + exp(-k*(dRT(player1SeesIndex) - minDRT)));
pSeeBothPlayers(player2SeesIndex) = -1./(1 + exp(-k*(minDRT - dRT(player2SeesIndex))));
pSee = [pSeeBothPlayers;-pSeeBothPlayers];
pSee(pSee < 0) = 0;