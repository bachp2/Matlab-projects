% Name : Bach Phan
% Course : B ENGR  320  

function StiffMatrix
disp('case A')
caseA();
disp('case B')
caseB();
end

function caseA
A = [1 0 0 0; -1 1 0 0; 0 -1 1 0; 0 0 -1 1; 0 0 0 -1];
C = -2*diag([1 1 1 1 1]);
At = A';
M = At*C*A;
disp('stiffness matrix')
disp(M)


[V,D] = eig(M);
eigenvalues = diag(D);
frequencies = sqrt(-eigenvalues);
disp('First Eigenvalue')
disp(eigenvalues(1)) % eigenvalues along diagonal of D
disp('w1')
disp(frequencies(1))

disp('Second Eigenvalue')
disp(eigenvalues(2)) % eigenvalues along diagonal of D
disp('w2')
disp(frequencies(2))

disp('Third Eigenvalue')
disp(eigenvalues(3)) % eigenvalues along diagonal of D
disp('w3')
disp(frequencies(3))

disp('fourth Eigenvalue')
disp(eigenvalues(4)) % eigenvalues along diagonal of D
disp('w4')
disp(frequencies(4))


disp('First Eigenvector')
disp(V(:,1)) % eigenvectors columns of V

disp('Second Eigenvector')
disp(V(:,2)) % eigenvectors columns of V

disp('Third Eigenvector')
disp(V(:,3)) % eigenvectors columns of V

disp('Fourth Eigenvector')
disp(V(:,4)) % eigenvectors columns of V
end

function caseB
A = [1 0 0 0; -1 1 0 0; 0 -1 1 0; 0 0 -1 1; 0 0 0 0];
C = -2*diag([1 1 1 1 1]);
At = A';
M = At*C*A;
disp('stiffness matrix')
disp(M)


[V,D] = eig(M);
eigenvalues = diag(D);
frequencies = sqrt(-eigenvalues);
disp('First Eigenvalue')
disp(eigenvalues(1)) % eigenvalues along diagonal of D
disp('w1')
disp(frequencies(1))

disp('Second Eigenvalue')
disp(eigenvalues(2)) % eigenvalues along diagonal of D
disp('w2')
disp(frequencies(2))

disp('Third Eigenvalue')
disp(eigenvalues(3)) % eigenvalues along diagonal of D
disp('w3')
disp(frequencies(3))

disp('fourth Eigenvalue')
disp(eigenvalues(4)) % eigenvalues along diagonal of D
disp('w4')
disp(frequencies(4))


disp('First Eigenvector')
disp(V(:,1)) % eigenvectors columns of V

disp('Second Eigenvector')
disp(V(:,2)) % eigenvectors columns of V

disp('Third Eigenvector')
disp(V(:,3)) % eigenvectors columns of V

disp('Fourth Eigenvector')
disp(V(:,4)) % eigenvectors columns of V
end