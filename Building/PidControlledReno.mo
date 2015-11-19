within DeSchipjesLin.Building;
model PidControlledReno
  extends Interfaces.partial_PidControlled(redeclare Structures.StruRenovated
      stru, ctrl(heaSysPar=DeSchipjesLin.HeatingSystems.HeaSysParReno()));
  annotation (experiment(
      StopTime=1.5e+006,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Euler"), __Dymola_experimentSetupOutput);
end PidControlledReno;
