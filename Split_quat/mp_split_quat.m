function Y=mp_split_quat(A)

Y=REALMAP(A);
Y=pinv(Y);
Y=ANTIREALMAP(Y);

end
