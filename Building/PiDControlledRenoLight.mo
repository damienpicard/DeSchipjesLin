within DeSchipjesLin.Building;
model PiDControlledRenoLight
  extends Interfaces.partial_PidControlled(redeclare
      Structures.StruRenovatedLight                                     stru,
      ctrl(heaSysPar=DeSchipjesLin.HeatingSystems.HeaSysParRenoLight()));
  annotation (experiment(
      StopTime=1.5e+006,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Euler"), __Dymola_experimentSetupOutput);
end PiDControlledRenoLight;
