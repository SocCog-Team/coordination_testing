isError = zeros(1,400);
memoryLength = 2;
x = [ones(1,100), zeros(1,100), ones(1,100), zeros(1,100)];
y = [zeros(1,100), ones(1,100), zeros(1,100), ones(1,100)];
instantTransferToX = calc_instant_transfer(x, y, memoryLength, isError, length(x));
instantTransferToY = calc_instant_transfer(y, x, memoryLength, isError, length(x));
transferValue = [instantTransferToX(1), instantTransferToY(1)]

x = [ones(1,50), zeros(1,50), ones(1,50), zeros(1,50), ones(1,50), zeros(1,50), ones(1,50), zeros(1,50)];
y = [zeros(1,50), ones(1,50), zeros(1,50), ones(1,50), zeros(1,50), ones(1,50), zeros(1,50), ones(1,50)];
instantTransferToX = calc_instant_transfer(x, y, memoryLength, isError, length(x));
instantTransferToY = calc_instant_transfer(y, x, memoryLength, isError, length(x));
transferValue = [instantTransferToX(1), instantTransferToY(1)]

x = [ones(1,100), zeros(1,100), ones(1,100), zeros(1,100)];
y = [zeros(1,99), ones(1,100), zeros(1,100), ones(1,101)];
instantTransferToX = calc_instant_transfer(x, y, memoryLength, isError, length(x));
instantTransferToY = calc_instant_transfer(y, x, memoryLength, isError, length(x));
transferValue = [instantTransferToX(1), instantTransferToY(1)]

x = ones(1,400);
x(2:2:length(x)) = 0;
y = [0,x(1:399)];
instantTransferToX = calc_instant_transfer(x, y, memoryLength, isError, length(x));
instantTransferToY = calc_instant_transfer(y, x, memoryLength, isError, length(x));
transferValue = [instantTransferToX(1), instantTransferToY(1)]


x = randi(2, 1, 10000);
y = 3 - x;
z = randi(2, 1, 10000);
t = calc_conditional_instant_transfer(x, y, z, 2, 1000);

