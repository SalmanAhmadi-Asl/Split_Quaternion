function [u,sig,v]=svd_split(A)

[m,n]=size(A);
n=min(m,n);

Y=REALMAP(A);
[u,s,v]=svd(Y);
u=ANTIREALMAP(u);
% s=ANTIREALMAP(s);

ss=s(:);
nz=nnz(ss);

for i=1:nz
s_(i)=SplitQuaternionMatrix(0.5*(ss(i)+ss(i+n)),0,0.5*(ss(i)-ss(i+n)),0);
end

for i=1:nz

    s(i,i)=s_(i);

end

v=ANTIREALMAP(v);

end