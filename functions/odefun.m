function thetaDot = odefun(t,y,Aij)
nosc= length(Aij);
thetaDot = zeros(nosc,1);
for i = 1:nosc
    for j = 1:nosc
        thetaDot(i) = thetaDot(i)+Aij(i,j)*(y(j)-y(i));
    end
end
end