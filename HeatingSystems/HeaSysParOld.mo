within DeSchipjesLin.HeatingSystems;
record HeaSysParOld
  extends partial_heaSysPar(powerZones = 70.*{70,17.13,3.86,25,8,7.24} .* {0.6,0.8,1,0.8,
            0.8,0.5});
end HeaSysParOld;
