within DeSchipjesLin.Building;
model HeatCurveControlledOld
  extends Interfaces.HeatCurveControlled(redeclare Structures.StruOld
      stru, ctrl(redeclare DeSchipjesLin.HeatingSystems.HeaSysParOld heaSysPar));
end HeatCurveControlledOld;
