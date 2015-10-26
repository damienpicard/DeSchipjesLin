within DeSchipjesLin.Structures.Renovated.Examples.BaseClasses;
model SingleRoom_lin
  replaceable package Medium = Buildings.Media.GasesConstantDensity.SimpleAir
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  inner Modelica.Fluid.System system
  annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Zone nachthal(
     V=7.24,
    redeclare package Medium = Medium,
    linearize=linearize.k,
    n50=0*0.5*20,
    nSurf=3)
    annotation (Placement(transformation(extent={{-4,44},{16,24}})));
   IDEAS.Buildings.Components.OuterWall halAchtergevel(
      AWall=1.06,
     insulationThickness=0.15,
     linearize=linearize.k,
    inc=1.5707963267949,
    azi=4.1015237421867)
     annotation (Placement(transformation(extent={{-66,38},{-56,58}})));
  IDEAS.Buildings.Components.BoundaryWall halGemeenschappelijk(
     AWall=4.05,
    final insulationThickness=0,
    redeclare final Data.Constructions.Old.GemeneMuur
      constructionType,
    inc(displayUnit="rad") = IDEAS.Constants.Wall,
    azi=0.95993108859688)
    annotation (Placement(transformation(extent={{-66,12},{-56,32}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(nPorts=1, redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{36,-18},{16,2}})));
  inner IDEAS.SimInfoManager sim(offsetAzi=0.95993108859688)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  Modelica.Blocks.Sources.BooleanConstant linearize(k=k)
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
   IDEAS.Buildings.Components.LinearizableWindow
                                     keukenWindowLarge(
      A=4.57,
     frac=0.15,
     redeclare Data.Frames.LoofHout fraType,
     redeclare IDEAS.Buildings.Components.Shading.None shaType,
     linOut=false,
     linearize=linearize.k,
    inc=1.5707963267949,
    azi=4.1015237421867)
     annotation (Placement(transformation(extent={{-66,-16},{-56,4}})));

  input IDEAS.BoundaryConditions.WeatherData.Bus weaBus1(numSolBus=sim.numAzi +
        1)
    annotation (Placement(transformation(extent={{-110,54},{-90,74}})));
  input IDEAS.Buildings.Components.Interfaces.WinBus winBus1[1]( each nLay=
         keukenWindowLarge.glazing.nLay) if                linearize.k
     annotation (Placement(transformation(extent={{-116,-38},{-84,-12}}),
         iconTransformation(
         extent={{-16,-13},{16,13}},
         rotation=90,
         origin={-100,-17})));

  Modelica.Blocks.Interfaces.RealOutput TSensor
    "Sensor temperature of the zone, i.e. operative temeprature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Boolean k=true "True if linearize";

  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-92,-60},{-72,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=nachthal.senTem.T)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(halGemeenschappelijk.propsBus_a, nachthal.propsBus[1]) annotation (
      Line(
      points={{-56,26},{-30,26},{-30,28.6667},{-4,28.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
   connect(halAchtergevel.propsBus_a, nachthal.propsBus[2]) annotation (Line(
       points={{-56,52},{-44,52},{-44,30},{-4,30}},
       color={255,204,51},
       thickness=0.5,
       smooth=Smooth.None));
  connect(boundary.ports[1], nachthal.flowPort_In) annotation (Line(
      points={{16,-8},{8,-8},{8,24}},
      color={0,127,255},
      smooth=Smooth.None));
   connect(keukenWindowLarge.propsBus_a, nachthal.propsBus[3]) annotation (Line(
       points={{-56,-2},{-30,-2},{-30,31.3333},{-4,31.3333}},
       color={255,204,51},
       thickness=0.5,
       smooth=Smooth.None));
  connect(nachthal.weaBus, weaBus1) annotation (Line(
      points={{-4,34.2},{-18,34.2},{-18,34},{-32,34},{-32,64},{-100,64}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
   connect(keukenWindowLarge.winBus, winBus1[1]) annotation (Line(
       points={{-54.6,-12},{-36,-12},{-36,-25},{-100,-25}},
       color={255,204,51},
       thickness=0.5,
       smooth=Smooth.None));
   connect(const.y, keukenWindowLarge.Ctrl) annotation (Line(
       points={{-71,-50},{-64,-50},{-64,-16}},
       color={0,0,127},
       smooth=Smooth.None));
  connect(realExpression.y, TSensor) annotation (Line(
      points={{81,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=100000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Run script to linearize:</p>
<pre>OutputCPUtime:=false; 
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(&QUOT;DeSchipjes.Dwellings.Structures.Renovated.Examples.SingleRoom&QUOT;);
writeMatrix(fileName=&QUOT;ssm.mat&QUOT;,matrixName=&QUOT;A&QUOT;,matrix=re.A);
writeMatrix(fileName=&QUOT;ssm.mat&QUOT;,matrixName=&QUOT;B&QUOT;,matrix=re.B, append=true);
writeMatrix(fileName=&QUOT;ssm.mat&QUOT;,matrixName=&QUOT;C&QUOT;,matrix=re.C, append=true);
writeMatrix(fileName=&QUOT;ssm.mat&QUOT;,matrixName=&QUOT;D&QUOT;,matrix=re.D, append=true);
OutputCPUtime:=true; </pre>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end SingleRoom_lin;
