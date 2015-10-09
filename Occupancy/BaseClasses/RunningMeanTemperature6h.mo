within DeSchipjesLin.Occupancy.BaseClasses;
model RunningMeanTemperature6h
  "Calculate the running mean temperature of 6 previsous hours with waiting factors"

  parameter Real[6] TAveHourIni(unit="K", displayUnit="degC") = ones(6).* 283.15
    "initial running mean temperature";

  // Interface
   discrete Modelica.Blocks.Interfaces.RealOutput TRm(unit="K",displayUnit = "degC")
    "running mean average temperature"
     annotation (Placement(transformation(extent={{96,-10},{116,10}})));
   Modelica.Blocks.Interfaces.RealInput TIn(unit="K",displayUnit = "degC")
    "Temperature for which the running mean is calculated"
     annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));

protected
  discrete Real[6] TAveHour(unit="K",displayUnit = "degC")
    "Vector with the average hour temperatures of the previous nTermRm hours";
  parameter Real coeTRm[6] = {1, 0.9, 0.8, 0.7, 0.6, 0.5}./4.5
    "weighting coefficient for the running average";

  Real intTIn "integral of TIn";

equation
  der(intTIn) =  TIn;
algorithm
  when initial() then
    // initialization of the discrete variables
    TAveHour:=TAveHourIni;
    TRm:=TAveHour[1];
  elsewhen sample(3600,3600) then
    // Update of TAveDay
    for i in 2:6 loop
      TAveHour[i] := TAveHour[i-1];
    end for;
    TAveHour[1] := intTIn / 3600;
    // reinitialisation of the intTIn
    TRm :=TAveHour*coeTRm;
  end when;
equation
    // reinitialisation of the intTAmb
  when sample(3600,3600) then
    reinit(intTIn,0);
  end when;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=864000),
    __Dymola_experimentSetupOutput,
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,34},{100,-24}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(
          points={{0,100},{100,0},{0,-100},{0,-100}},
          color={0,0,0},
          smooth=Smooth.None)}));
end RunningMeanTemperature6h;
