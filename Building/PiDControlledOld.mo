within DeSchipjesLin.Building;
model PiDControlledOld
  extends Interfaces.partial_PidControlled(redeclare Structures.StruOld stru,
      ctrl(heaSysPar=DeSchipjesLin.HeatingSystems.HeaSysParOld()));
  annotation (experiment(
      StopTime=1.5e+006,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Euler"), __Dymola_experimentSetupOutput);
end PiDControlledOld;
