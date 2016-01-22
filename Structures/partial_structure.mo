within DeSchipjesLin.Structures;
model partial_structure "Standaard woning de schipjes"

  //Extensions
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
      offsetAzi=frontAng,
      nLayWin=3,
      linearise=linearise,
      nWindow=2));

   // linearisation
  parameter Real corrCV=1 "Multiplication factor for the zone air capacity";
  parameter Real mSenFac=10
    "Factor for scaling the sensible thermal mass of the volume";

   parameter Boolean linearise=true "Linearises building model equations";
   parameter Boolean linearise_zone = true;

  // Orientations
   parameter Modelica.SIunits.Angle leftAng=63/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle rightAng=243/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle frontAng=153/180*Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle backAng=-27/180*Modelica.Constants.pi;

  parameter Modelica.SIunits.Length isolatieTest=0;

  parameter Modelica.SIunits.Area woonruimteA=21.73;
  parameter Modelica.SIunits.Area keukenA=7.32;
  parameter Modelica.SIunits.Area wcA=1.65;
  parameter Modelica.SIunits.Area slaapkamerA=10.79;
  parameter Modelica.SIunits.Area badkamerA=3.61;
  parameter Modelica.SIunits.Area nachthalA=3.23;

  // ----------------------  Interface
  replaceable package Medium = Modelica.Media.Air.DryAirNasa
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
      annotation (choicesAllMatching = true);

  parameter Integer nZones(min=1) =  1
    "Number of conditioned thermal zones in the building";
  parameter Integer nEmb(min=0) = 0
    "Number of embedded systems in the building";

  parameter Modelica.SIunits.Temperature[nZones] T_start = 293.15*ones(nZones)
    "Operative zonal start temperatures";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
    "Internal zone nodes for convective heat gains" annotation (Placement(
        transformation(extent={{90,10},{110,30}}),  iconTransformation(extent={{90,10},
            {110,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
    "Internal zones node for radiative heat gains" annotation (Placement(
        transformation(extent={{90,-30},{110,-10}}),  iconTransformation(extent={{90,-30},
            {110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSensor( quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{96,-70},{116,-50}}),
        iconTransformation(extent={{96,-70},{116,-50}})));
  //----------- Zones -------------------------------------------------------
protected
  IDEAS.Buildings.Linearisation.Components.LinZone keuken(
    V=17.13,
    redeclare package Medium = Medium,
    n50=2.87,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone,
    nSurf=3)
    annotation (Placement(transformation(extent={{28,-22},{48,-2}})));

  //----------- Internal walls -------------------------------------------------------

  //----------- Boundary walls -------------------------------------------------------

  //----------- Outer walls -------------------------------------------------------
  IDEAS.Buildings.Components.OuterWall keukenAchtergevel(
    AWall=7.56,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-172,-24},{-162,-4}})));

  //----------- Windows -------------------------------------------------------
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    inc=1.5707963267949,
    indexWindow=1)
    annotation (Placement(transformation(extent={{-122,-34},{-112,-14}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    inc=1.5707963267949,
    indexWindow=2)
    annotation (Placement(transformation(extent={{-104,-34},{-94,-14}})));

    // Linearisation
public
      IDEAS.Utilities.IO.heatPortPrescribedHeatFlow h2sRad[nZones] if linearise
    annotation (Placement(transformation(extent={{140,-30},{120,-10}})));
  IDEAS.Utilities.IO.heatPortPrescribedHeatFlow h2sCon1[nZones] if linearise
    annotation (Placement(transformation(extent={{140,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealInput QFlowCon[nZones](each start=100) if   linearise
    annotation (Placement(transformation(extent={{192,6},{152,46}})));
  Modelica.Blocks.Interfaces.RealInput QFlowRad[nZones](each start = 100) if linearise
    annotation (Placement(transformation(extent={{192,-32},{152,8}})));

equation
  // Linerization connections
  connect(keuken.TSensor, TSensor[1]) annotation (Line(points={{48.6,-12},{82,
          -12},{82,-60},{106,-60}},
                              color={0,0,127}));
  connect(keuken.gainCon, heatPortCon[1]) annotation (Line(points={{48,-15},{68,
          -15},{68,-16},{92,-16},{92,20},{100,20}},
                                             color={191,0,0}));
  connect(keuken.gainRad, heatPortRad[1]) annotation (Line(points={{48,-18},{68,
          -18},{88,-18},{88,-20},{100,-20}},
                                       color={191,0,0}));
  connect(h2sRad.port1, heatPortRad)
    annotation (Line(points={{120,-20},{100,-20}},           color={191,0,0}));
  connect(h2sCon1.port1, heatPortCon)
    annotation (Line(points={{120,20},{100,20}},          color={191,0,0}));
  connect(h2sRad.Q_flow,QFlowRad)  annotation (Line(points={{140.8,-13},{146.4,-13},
          {146.4,-12},{172,-12}}, color={0,0,127}));
  connect(QFlowCon, h2sCon1.Q_flow) annotation (Line(points={{172,26},{140.8,26},
          {140.8,27}}, color={0,0,127}));
  connect(keukenWindowLarge.propsBus_a, keuken.propsBus[1]) annotation (Line(
      points={{-112,-20},{-112,-6.66667},{28,-6.66667}},
      color={255,204,51},
      thickness=0.5));
  connect(keukenWindowSmall.propsBus_a, keuken.propsBus[2]) annotation (Line(
      points={{-94,-20},{-72,-20},{-72,-8},{28,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(keukenAchtergevel.propsBus_a, keuken.propsBus[3]) annotation (Line(
      points={{-162,-10},{-68,-10},{-68,-9.33333},{28,-9.33333}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -260},{140,100}}), graphics={
        Text(
          extent={{-194,-26},{-120,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="2: keuken")}),   Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={191,0,0}),
        Polygon(
          points={{54,18},{50,14},{-6,60},{-58,18},{-58,-42},{54,-42},{54,-50},{
              -66,-50},{-66,20},{-6,70},{54,18}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model allows comparing the simulation accuracy of the 
\"true\" linearised state space model with two reduced order models (ROMs).
</p>
<p>
Before running this model, 
you may need to run the following script in order to create the state space model:
</p>
<code>
OutputCPUtime:=false;<br/>
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(\"DeSchipjesLin.Structures.StructureH\");<br/>
writeMatrix(fileName=\"ssm_structureH.mat\",matrixName=\"A\",matrix=re.A);<br/>
writeMatrix(fileName=\"ssm_structureH.mat\",matrixName=\"B\",matrix=re.B, append=true);<br/>
writeMatrix(fileName=\"ssm_structureH.mat\",matrixName=\"C\",matrix=re.C, append=true);<br/>
writeMatrix(fileName=\"ssm_structureH.mat\",matrixName=\"D\",matrix=re.D, append=true);<br/>
OutputCPUtime:=true;</code>
</html>", revisions="<html>
<ul>
<li>
August, 2015 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    experiment(StopTime=1e+006),
    __Dymola_experimentSetupOutput);
end partial_structure;
