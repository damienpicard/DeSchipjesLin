within DeSchipjesLin.Building;
model HeatCurveControlledReno
  extends Interfaces.HeatCurveControlled(redeclare Structures.StruRenovated
      stru, ctrl(redeclare DeSchipjesLin.HeatingSystems.HeaSysParReno heaSysPar));
end HeatCurveControlledReno;
