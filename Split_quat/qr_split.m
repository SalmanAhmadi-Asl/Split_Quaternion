function [Q,R]=qr_split(A)

Y=REALMAP(A);
[q,r]=qr(Y);
Q=ANTIREALMAP(q);
R=ANTIREALMAP(r);

end