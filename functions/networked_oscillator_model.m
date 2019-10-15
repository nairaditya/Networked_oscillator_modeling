function Aij = networked_oscillator_model(nt,nosc,theta_pert,theta_dot_pert)

%% Construct basis

Theta = zeros(nt,nosc-1); % basis function
Aij = zeros(nosc,nosc);   % adjacency matrix
for i = 1:nosc
    counti = 1;
    for j = 1:nosc
        if (i~=j)
            Theta(:,counti) = theta_pert(:,j)-theta_pert(:,i);
            counti = counti +1;
        end
    end
    dXdt = theta_dot_pert(:,i);
    Xi = Theta\dXdt;      % regression procedure
    countii = 1;
    for jj = 1:nosc
        if (i~=jj)
            Aij(i,jj) = Xi(countii);
            countii = countii +1;
        end
    end
end
end
