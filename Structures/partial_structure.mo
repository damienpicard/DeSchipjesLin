within DeSchipjesLin.Structures;
model partial_structure "Standaard woning de schipjes"

  //Extensions
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
      nWindow=5,
      offsetAzi=frontAng,
      nLayWin=3,
      linearise=linearise));

  Real[ nZones] U_equivalent={woonruimte.U_equivalent, keuken.U_equivalent, wc.U_equivalent, slaapkamer.U_equivalent, badkamer.U_equivalent, nachthal.U_equivalent};
  Real[ nZones] ATraExt={woonruimte.ATraExt, keuken.ATraExt, wc.ATraExt, slaapkamer.ATraExt, badkamer.ATraExt, nachthal.ATraExt};
  Real U_value = sum(U_equivalent.*ATraExt)/ATraExtTot;
  Real ATraExtTot = sum(ATraExt);
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

  parameter Integer nZones(min=1) =  6
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nEmb] heatPortEmb
    "Construction nodes for heat gains by embedded layers" annotation (
      Placement(transformation(extent={{90,50},{110,70}}),  iconTransformation(
          extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSensor( quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{96,-70},{116,-50}}),
        iconTransformation(extent={{96,-70},{116,-50}})));
  //----------- Zones -------------------------------------------------------
protected
  IDEAS.Buildings.Linearisation.Components.LinZone woonruimte(
    V=70.1,
    nSurf=10,
    redeclare package Medium = Medium,
    n50=6.74,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{28,36},{48,56}})));
  IDEAS.Buildings.Linearisation.Components.LinZone keuken(
    V=17.13,
    nSurf=8,
    redeclare package Medium = Medium,
    n50=2.87,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{28,-22},{48,-2}})));
  IDEAS.Buildings.Linearisation.Components.LinZone wc(
    V=3.86,
    nSurf=7,
    redeclare package Medium = Medium,
    n50=3.36,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{28,-72},{48,-52}})));
  IDEAS.Buildings.Linearisation.Components.LinZone slaapkamer(
    V=24.17,
    nSurf=10,
    redeclare package Medium = Medium,
    n50=3.25,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{28,-120},{48,-100}})));
  IDEAS.Buildings.Linearisation.Components.LinZone badkamer(
    V=8.09,
    nSurf=7,
    redeclare package Medium = Medium,
    n50=3.33,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{30,-174},{50,-154}})));
  IDEAS.Buildings.Linearisation.Components.LinZone nachthal(
    V=7.24,
    nSurf=6,
    redeclare package Medium = Medium,
    n50=5.14,
    corrCV=corrCV,
    useFluidPorts=false,
    mSenFac=mSenFac,
    simplifyAirModel=sim.linearise or linearise_zone)
    annotation (Placement(transformation(extent={{32,-224},{52,-204}})));

  //----------- Internal walls -------------------------------------------------------
  IDEAS.Buildings.Components.InternalWall woonruimteKeuken(
    AWall=6.97,
    azi=leftAng,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949) annotation (Placement(transformation(
        extent={{-5,10},{5,-10}},
        rotation=180,
        origin={19,28})));
  IDEAS.Buildings.Components.InternalWall woonruimteHal(
    AWall=3.32,
    inc=0,
    azi=0,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType)
    annotation (Placement(transformation(
        extent={{5,-10},{-5,10}},
        rotation=270,
        origin={-61,30})));
  IDEAS.Buildings.Components.InternalWall woonruimteBad(
    AWall=3.61,
    inc=0,
    azi=0,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType)
    annotation (Placement(transformation(
        extent={{-5,10},{5,-10}},
        rotation=90,
        origin={-35,30})));
  IDEAS.Buildings.Components.InternalWall woonruimteSlaapkamer(
    AWall=10.79,
    inc=0,
    azi=0,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType)
    annotation (Placement(transformation(
        extent={{-5,10},{5,-10}},
        rotation=90,
        origin={-7,30})));
  IDEAS.Buildings.Components.InternalWall keukenWC(
    AWall=1.96,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949,
    azi=frontAng) annotation (Placement(transformation(
        extent={{5,-10},{-5,10}},
        rotation=0,
        origin={-9,-24})));
  IDEAS.Buildings.Components.InternalWall slaapkamerBadLiggend(
    AWall=4.26,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-50,-130},{-60,-110}})));
  IDEAS.Buildings.Components.InternalWall slaapkamerBadStaand(
    AWall=1.12,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-26,-130},{-36,-110}})));
  IDEAS.Buildings.Components.InternalWall slaapkamerHal(
    AWall=3.81,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-72,-130},{-82,-110}})));

  IDEAS.Buildings.Components.InternalWall badkamerHal(
    AWall=2.4,
     insulationThickness=0,
    redeclare Data.Constructions.Old.BinnenMuur  constructionType,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-88,-186},{-98,-166}})));

  //----------- Boundary walls -------------------------------------------------------
  IDEAS.Buildings.Components.BoundaryWall woonruimteGemeenschappelijk(
    AWall=17.10,
     insulationThickness=0,
    redeclare Data.Constructions.Old.GemeneMuur  constructionType,
    inc=1.5707963267949,
    azi=rightAng)
    annotation (Placement(transformation(extent={{-100,58},{-90,78}})));

  IDEAS.Buildings.Components.BoundaryWall keukenGemeenschappelijk(
    AWall=5.92,
     insulationThickness=0,
    redeclare Data.Constructions.Old.GemeneMuur  constructionType,
    inc=1.5707963267949,
    azi=leftAng) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-45,-24})));
  IDEAS.Buildings.Components.BoundaryWall WCGemeenschappelijk(
    AWall=2.85,
     insulationThickness=0,
    redeclare Data.Constructions.Old.GemeneMuur  constructionType,
    inc=1.5707963267949,
    azi=leftAng)
    annotation (Placement(transformation(extent={{-20,-84},{-10,-64}})));
  IDEAS.Buildings.Components.BoundaryWall slaapkamerGemeenschappelijk(
    AWall=10.27,
     insulationThickness=0,
    redeclare Data.Constructions.Old.GemeneMuur  constructionType,
    inc=1.5707963267949,
    azi=rightAng)
    annotation (Placement(transformation(extent={{-104,-130},{-94,-110}})));
  IDEAS.Buildings.Components.BoundaryWall halGemeenschappelijk(
    AWall=4.05,
     insulationThickness=0,
    redeclare Data.Constructions.Old.GemeneMuur  constructionType,
    inc=1.5707963267949,
    azi=rightAng)
    annotation (Placement(transformation(extent={{-44,-240},{-34,-220}})));

  //----------- Outer walls -------------------------------------------------------
  IDEAS.Buildings.Components.OuterWall woonruimteKoer(
    AWall=5.15,
    redeclare Data.Constructions.Renovated.GevelType2  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=leftAng)
    annotation (Placement(transformation(extent={{-150,58},{-140,78}})));
  IDEAS.Buildings.Components.SlabOnGround woonruimteVloer(
    PWall=18.92,
    inc=0,
    azi=0,
    AWall=woonruimteA,
    redeclare Data.Constructions.Renovated.Vloer1  constructionType,
     insulationThickness=0) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-105,28})));
  IDEAS.Buildings.Components.OuterWall woonruimteAchtergevel(
    AWall=13.23,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-126,58},{-116,78}})));
  IDEAS.Buildings.Components.OuterWall woonruimteVoorgevel(
    AWall=9.29,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    azi=frontAng,
    inc=1.5707963267949)
    annotation (Placement(transformation(extent={{-170,34},{-160,54}})));
  IDEAS.Buildings.Components.OuterWall keukenAchtergevel(
    AWall=7.56,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-172,-24},{-162,-4}})));
  IDEAS.Buildings.Components.SlabOnGround keukenVloer(
    AWall=7.27,
    PWall=11.16,
    inc=0,
    azi=0,
    redeclare Data.Constructions.Renovated.Vloer1  constructionType,
     insulationThickness=0) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-69,-24})));
  IDEAS.Buildings.Components.OuterWall keukenDak(
    AWall=keukenA,
    inc=0,
    azi=0,
    redeclare Data.Constructions.Old.DakBijBouw  constructionType,
     insulationThickness=0.08,
    redeclare Data.Insulation.RotsWolSKepers  insulationType) annotation (
      Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-143,2})));
  IDEAS.Buildings.Components.OuterWall WCKoer(
    AWall=2.83,
    redeclare Data.Constructions.Renovated.GevelType2  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=rightAng)
    annotation (Placement(transformation(extent={{-170,-74},{-160,-54}})));
  IDEAS.Buildings.Components.OuterWall WCVoorgevel(
    AWall=2.65,
    redeclare Data.Constructions.Renovated.GevelType3  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=frontAng)
    annotation (Placement(transformation(extent={{-134,-82},{-124,-62}})));
  IDEAS.Buildings.Components.SlabOnGround WCVloer(
    AWall=wcA,
    inc=0,
    azi=0,
    PWall=4.74,
     insulationThickness=0,
    redeclare Data.Constructions.Renovated.Vloer1  constructionType)
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-37,-70})));
  IDEAS.Buildings.Components.OuterWall WCDak(
    AWall=wcA,
    inc=0,
    azi=0,
     insulationThickness=0.08,
    redeclare Data.Constructions.Old.DakBijBouw  constructionType,
    redeclare Data.Insulation.RotsWolSKepers  insulationType) annotation (
      Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-79,-44})));
  IDEAS.Buildings.Components.OuterWall slaapkamerZijgevel(
    AWall=2.41,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=leftAng)
    annotation (Placement(transformation(extent={{-168,-120},{-158,-100}})));
  IDEAS.Buildings.Components.OuterWall slaapkamerVoorgevel(
    AWall=13.22,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=frontAng)
    annotation (Placement(transformation(extent={{-128,-130},{-118,-110}})));

  IDEAS.Buildings.Components.OuterWall halAchtergevel(
    AWall=1.06,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=backAng)
    annotation (Placement(transformation(extent={{-168,-224},{-158,-204}})));
  IDEAS.Buildings.Components.OuterWall halDak(
    AWall=6.89,
     insulationThickness=0.08,
    redeclare Data.Constructions.Old.DakHoofdGebouw  constructionType,
    redeclare Data.Insulation.RotsWolSpanten  insulationType,
    inc=0,
    azi=0) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-7,-200})));

  IDEAS.Buildings.Components.OuterWall slaapkamerDakRechts(
    AWall=14.05,
     insulationThickness=0.08,
    redeclare Data.Constructions.Old.DakHoofdGebouw  constructionType,
    redeclare Data.Insulation.RotsWolSpanten  insulationType,
    inc=0,
    azi=rightAng) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-27,-94})));

  IDEAS.Buildings.Components.OuterWall slaapkamerDakLinks(
    AWall=11.73,
    redeclare Data.Constructions.Old.DakHoofdGebouw  constructionType,
     insulationThickness=0.08,
    redeclare Data.Insulation.RotsWolSpanten  insulationType,
    inc=0,
    azi=leftAng) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-53,-94})));
  IDEAS.Buildings.Components.OuterWall badkamerAchtergevel(
    AWall=1.34,
    redeclare Data.Constructions.Renovated.GevelType1 constructionType,
    insulationThickness=0,
    azi=backAng,
    inc=1.5707963267949)
    annotation (Placement(transformation(extent={{-168,-176},{-158,-156}})));
  IDEAS.Buildings.Components.OuterWall badkamerZijgevel(
    AWall=4.05,
    redeclare Data.Constructions.Renovated.GevelType1  constructionType,
     insulationThickness=0,
    inc=1.5707963267949,
    azi=leftAng)
    annotation (Placement(transformation(extent={{-120,-186},{-110,-166}})));
  IDEAS.Buildings.Components.OuterWall badkamerDak(
    AWall=8.74,
     insulationThickness=0.08,
    redeclare Data.Constructions.Old.DakHoofdGebouw  constructionType,
    redeclare Data.Insulation.RotsWolSpanten  insulationType,
    inc=0,
    azi=rightAng) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=270,
        origin={-51,-150})));
  //----------- Windows -------------------------------------------------------
  IDEAS.Buildings.Linearisation.Components.LinWindow woonruimteWindow(
    A=5.78,
    frac=0.12,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    indexWindow=1,
    inc=1.5707963267949)
    annotation (Placement(transformation(extent={{-6,56},{4,76}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowLarge(
    A=4.57,
    frac=0.15,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    inc=1.5707963267949,
    indexWindow=2)
    annotation (Placement(transformation(extent={{-122,-34},{-112,-14}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow keukenWindowSmall(
    A=1.05,
    frac=0.25,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    inc=1.5707963267949,
    indexWindow=3)
    annotation (Placement(transformation(extent={{-104,-34},{-94,-14}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow raamwc(
    A=0.07,
    frac=0.89,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    indexWindow=4,
    inc=1.5707963267949)
    annotation (Placement(transformation(extent={{-76,-84},{-66,-64}})));
  IDEAS.Buildings.Linearisation.Components.LinWindow slaapkamerRaam(
    A=0.75,
    frac=0.21,
    redeclare Data.Glass.DubbelGlas  glazing,
    redeclare Data.Frames.LoofHout  fraType,
    azi=frontAng,
    indexWindow=5,
    inc=1.5707963267949)
    annotation (Placement(transformation(extent={{-18,-132},{-8,-112}})));

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
  connect(woonruimteHal.propsBus_a, woonruimte.propsBus[1]) annotation (Line(
      points={{-57,35},{-57,42},{-58,42},{-58,50},{28,50},{28,51.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteBad.propsBus_a, woonruimte.propsBus[2]) annotation (Line(
      points={{-31,35},{-31,51.4},{28,51.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteSlaapkamer.propsBus_a, woonruimte.propsBus[3]) annotation (
      Line(
      points={{-3,35},{-3,51},{28,51}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteKeuken.propsBus_a, woonruimte.propsBus[4]) annotation (Line(
      points={{14,32},{14,50},{-24,50},{-24,50.6},{28,50.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteGemeenschappelijk.propsBus_a, woonruimte.propsBus[5])
    annotation (Line(
      points={{-90,72},{-90,50.2},{28,50.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteVloer.propsBus_a, woonruimte.propsBus[6]) annotation (Line(
      points={{-109,33},{-110,33},{-110,49.8},{28,49.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteAchtergevel.propsBus_a, woonruimte.propsBus[7]) annotation (
     Line(
      points={{-116,72},{-116,49.4},{28,49.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteVoorgevel.propsBus_a, woonruimte.propsBus[8]) annotation (
      Line(
      points={{-160,48},{-132,48},{-132,49},{28,49}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteKoer.propsBus_a, woonruimte.propsBus[9]) annotation (Line(
      points={{-140,72},{-140,48.6},{28,48.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteKeuken.propsBus_b, keuken.propsBus[1]) annotation (Line(
      points={{24,32},{24,-4},{28,-4},{28,-6.25}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(woonruimteSlaapkamer.propsBus_b, slaapkamer.propsBus[1]) annotation (
      Line(
      points={{-3,25},{-3,18},{-6,18},{-6,10},{18,10},{18,-104.2},{28,-104.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(woonruimteBad.propsBus_b, badkamer.propsBus[1]) annotation (Line(
      points={{-31,25},{-31,6},{14,6},{14,-156},{30,-156},{30,-158.286}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteHal.propsBus_b, nachthal.propsBus[1]) annotation (Line(
      points={{-57,25},{-57,4},{-56,4},{-56,2},{10,2},{10,-204},{32,-204},{32,
          -208.333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(woonruimteWindow.propsBus_a, woonruimte.propsBus[10]) annotation (
      Line(
      points={{4,70},{4,48.2},{28,48.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWC.propsBus_a, keuken.propsBus[2]) annotation (Line(
      points={{-14,-20},{-14,-10},{28,-10},{28,-6.75}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWC.propsBus_b, wc.propsBus[1]) annotation (Line(
      points={{-4,-20},{22,-20},{22,-56.2857},{28,-56.2857}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenGemeenschappelijk.propsBus_a, keuken.propsBus[3]) annotation (
      Line(
      points={{-40,-20},{-40,-8},{28,-8},{28,-7.25}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenVloer.propsBus_a, keuken.propsBus[4]) annotation (Line(
      points={{-73,-19},{-73,-7.75},{28,-7.75}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(keukenWindowSmall.propsBus_a, keuken.propsBus[5]) annotation (Line(
      points={{-94,-20},{-94,-8.25},{28,-8.25}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenWindowLarge.propsBus_a, keuken.propsBus[6]) annotation (Line(
      points={{-112,-20},{-112,-8.75},{28,-8.75}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenDak.propsBus_a, keuken.propsBus[7]) annotation (Line(
      points={{-139,-3},{-140,-3},{-140,-9.25},{28,-9.25}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(keukenAchtergevel.propsBus_a, keuken.propsBus[8]) annotation (Line(
      points={{-162,-10},{-68,-10},{-68,-9.75},{28,-9.75}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(WCGemeenschappelijk.propsBus_a, wc.propsBus[2]) annotation (Line(
      points={{-10,-70},{-6,-70},{-6,-60},{28,-60},{28,-56.8571}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WCVloer.propsBus_a, wc.propsBus[3]) annotation (Line(
      points={{-41,-65},{-40,-65},{-40,-60},{28,-60},{28,-57.4286}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(raamwc.propsBus_a, wc.propsBus[4]) annotation (Line(
      points={{-66,-70},{-66,-60},{26,-60},{26,-58},{28,-58}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WCDak.propsBus_a, wc.propsBus[5]) annotation (Line(
      points={{-75,-49},{-75,-60},{28,-60},{28,-58.5714}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WCVoorgevel.propsBus_a, wc.propsBus[6]) annotation (Line(
      points={{-124,-68},{-90,-68},{-90,-60},{28,-60},{28,-59.1429}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WCKoer.propsBus_a, wc.propsBus[7]) annotation (Line(
      points={{-160,-60},{-86,-60},{-86,-59.7143},{28,-59.7143}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerDakLinks.propsBus_a, slaapkamer.propsBus[2]) annotation (
      Line(
      points={{-49,-99},{-49,-102},{-48,-102},{-48,-106},{28,-106},{28,-104.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerRaam.propsBus_a, slaapkamer.propsBus[3]) annotation (Line(
      points={{-8,-118},{-8,-106},{12,-106},{12,-105},{28,-105}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerHal.propsBus_a, slaapkamer.propsBus[4]) annotation (Line(
      points={{-82,-116},{-82,-105.4},{28,-105.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerBadStaand.propsBus_a, slaapkamer.propsBus[5]) annotation (
      Line(
      points={{-36,-116},{-36,-106},{-28,-106},{-28,-105.8},{28,-105.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerBadLiggend.propsBus_a, slaapkamer.propsBus[6]) annotation (
      Line(
      points={{-60,-116},{-60,-106.2},{28,-106.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerGemeenschappelijk.propsBus_a, slaapkamer.propsBus[7])
    annotation (Line(
      points={{-94,-116},{-94,-106.6},{28,-106.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerVoorgevel.propsBus_a, slaapkamer.propsBus[8]) annotation (
      Line(
      points={{-118,-116},{-118,-106},{28,-106},{28,-107}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerZijgevel.propsBus_a, slaapkamer.propsBus[9]) annotation (
      Line(
      points={{-158,-106},{28,-106},{28,-107.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerBadStaand.propsBus_b, badkamer.propsBus[2]) annotation (
      Line(
      points={{-26,-116},{-24,-116},{-24,-136},{14,-136},{14,-156},{30,-156},{
          30,-158.857}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerBadLiggend.propsBus_b, badkamer.propsBus[3]) annotation (
      Line(
      points={{-50,-116},{-50,-136},{14,-136},{14,-156},{30,-156},{30,-159.429}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(badkamerHal.propsBus_a, badkamer.propsBus[4]) annotation (Line(
      points={{-98,-172},{-98,-160},{30,-160}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(badkamerDak.propsBus_a, badkamer.propsBus[5]) annotation (Line(
      points={{-47,-155},{-47,-160.571},{30,-160.571}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(badkamerZijgevel.propsBus_a, badkamer.propsBus[6]) annotation (Line(
      points={{-110,-172},{-110,-161.143},{30,-161.143}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(badkamerAchtergevel.propsBus_a, badkamer.propsBus[7]) annotation (
      Line(
      points={{-158,-162},{-126,-162},{-126,-161.714},{30,-161.714}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(badkamerHal.propsBus_b, nachthal.propsBus[3]) annotation (Line(
      points={{-88,-172},{-88,-190},{10,-190},{10,-204},{32,-204},{32,-209.667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(slaapkamerHal.propsBus_b, nachthal.propsBus[2]) annotation (Line(
      points={{-72,-116},{-72,-140},{10,-140},{10,-204},{32,-204},{32,-209}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(halGemeenschappelijk.propsBus_a, nachthal.propsBus[4]) annotation (
      Line(
      points={{-34,-226},{-32,-226},{-32,-210.333},{32,-210.333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(halDak.propsBus_a, nachthal.propsBus[5]) annotation (Line(
      points={{-3,-205},{-3,-211},{32,-211}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(halAchtergevel.propsBus_a, nachthal.propsBus[6]) annotation (Line(
      points={{-158,-210},{32,-210},{32,-211.667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slaapkamerDakRechts.propsBus_a, slaapkamer.propsBus[10]) annotation (
      Line(
      points={{-23,-99},{-23,-102},{-24,-102},{-24,-106},{28,-106},{28,-107.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  // Linerization connections
  connect(woonruimte.TSensor, TSensor[1]) annotation (Line(points={{48.6,46},{
          82,46},{82,-68.3333},{106,-68.3333}},
                                             color={0,0,127}));
  connect(woonruimte.gainCon, heatPortCon[1]) annotation (Line(points={{48,43},
          {72,43},{72,44},{92,44},{92,11.6667},{100,11.6667}},color={191,0,0}));
  connect(woonruimte.gainRad, heatPortRad[1]) annotation (Line(points={{48,40},
          {88,40},{88,-28.3333},{100,-28.3333}},color={191,0,0}));
  connect(keuken.TSensor, TSensor[2]) annotation (Line(points={{48.6,-12},{82,-12},
          {82,-65},{106,-65}},color={0,0,127}));
  connect(keuken.gainCon, heatPortCon[2]) annotation (Line(points={{48,-15},{68,
          -15},{68,-16},{92,-16},{92,15},{100,15}},
                                             color={191,0,0}));
  connect(keuken.gainRad, heatPortRad[2]) annotation (Line(points={{48,-18},{68,
          -18},{88,-18},{88,-25},{100,-25}},
                                       color={191,0,0}));
  connect(wc.gainCon, heatPortCon[3]) annotation (Line(points={{48,-65},{72,-65},
          {72,-64},{92,-64},{92,18.3333},{100,18.3333}}, color={191,0,0}));
  connect(wc.TSensor, TSensor[3]) annotation (Line(points={{48.6,-62},{82,-62},
          {82,-61.6667},{106,-61.6667}},color={0,0,127}));
  connect(wc.gainRad, heatPortRad[3]) annotation (Line(points={{48,-68},{70,-68},
          {88,-68},{88,-21.6667},{100,-21.6667}}, color={191,0,0}));
  connect(slaapkamer.TSensor, TSensor[4]) annotation (Line(points={{48.6,-110},
          {82,-110},{82,-58.3333},{106,-58.3333}},
                                              color={0,0,127}));
  connect(slaapkamer.gainCon, heatPortCon[4]) annotation (Line(points={{48,-113},
          {70,-113},{70,-112},{88,-112},{88,21.6667},{100,21.6667}}, color={191,
          0,0}));
  connect(slaapkamer.gainRad, heatPortRad[4]) annotation (Line(points={{48,-116},
          {70,-116},{88,-116},{88,-18.3333},{100,-18.3333}}, color={191,0,0}));
  connect(badkamer.TSensor, TSensor[5]) annotation (Line(points={{50.6,-164},{82,
          -164},{82,-55},{106,-55}}, color={0,0,127}));
  connect(badkamer.gainCon, heatPortCon[5]) annotation (Line(points={{50,-167},{
          88,-167},{88,25},{100,25}}, color={191,0,0}));
  connect(badkamer.gainRad, heatPortRad[5]) annotation (Line(points={{50,-170},{
          92,-170},{92,-15},{100,-15}}, color={191,0,0}));
  connect(nachthal.TSensor, TSensor[6]) annotation (Line(points={{52.6,-214},{
          82,-214},{82,-51.6667},{106,-51.6667}},
                                               color={0,0,127}));
  connect(nachthal.gainCon, heatPortCon[6]) annotation (Line(points={{52,-217},
          {68,-217},{68,-218},{88,-218},{88,18},{88,18},{88,28.3333},{100,
          28.3333}},
        color={191,0,0}));
  connect(nachthal.gainRad, heatPortRad[6]) annotation (Line(points={{52,-220},
          {76,-220},{92,-220},{92,-11.6667},{100,-11.6667}},color={191,0,0}));
  connect(h2sRad.port1, heatPortRad)
    annotation (Line(points={{120,-20},{100,-20}},           color={191,0,0}));
  connect(h2sCon1.port1, heatPortCon)
    annotation (Line(points={{120,20},{100,20}},          color={191,0,0}));
  connect(h2sRad.Q_flow,QFlowRad)  annotation (Line(points={{140.8,-13},{146.4,-13},
          {146.4,-12},{172,-12}}, color={0,0,127}));
  connect(QFlowCon, h2sCon1.Q_flow) annotation (Line(points={{172,26},{140.8,26},
          {140.8,27}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -260},{140,100}}), graphics={
        Rectangle(
          extent={{-178,80},{68,16}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-178,16},{68,-36}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-178,-36},{68,-88}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-178,-88},{68,-142}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-178,-142},{68,-192}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-178,-192},{68,-244}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-184,26},{-110,16}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="1: woonteruimte"),
        Text(
          extent={{-194,-26},{-120,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="2: keuken"),
        Text(
          extent={{-202,-76},{-128,-86}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="3: wc"),
        Text(
          extent={{-186,-128},{-112,-138}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="4: slaapkamer"),
        Text(
          extent={{-188,-180},{-114,-190}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="5: badkamer"),
        Text(
          extent={{-188,-232},{-114,-242}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="6: nachthal")}), Icon(graphics={
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
