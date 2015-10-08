within DeSchipjesLin;
package Building

  model pid

    Structures.StructureH structureH(linearise=false)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    HeatingSystems.PrescribedHeat_pid prescribedHeat_pid
      annotation (Placement(transformation(extent={{0,-12},{20,8}})));
    Occupancy.Occupant occupant
      annotation (Placement(transformation(extent={{-20,-48},{0,-28}})));
  equation
    connect(prescribedHeat_pid.portCon, structureH.heatPortCon) annotation (
        Line(points={{0,4},{-10,4},{-10,2},{-20,2}}, color={191,0,0}));
    connect(prescribedHeat_pid.portRad, structureH.heatPortRad)
      annotation (Line(points={{0,-2},{-10,-2},{-20,-2}}, color={191,0,0}));
    connect(structureH.TSensor, prescribedHeat_pid.TZones) annotation (Line(
          points={{-19.4,-6},{-12,-6},{-12,-8},{-1,-8}}, color={0,0,127}));
    connect(occupant.TZoneSetUpLow, prescribedHeat_pid.TSet)
      annotation (Line(points={{1,-40},{10,-40},{10,-13}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=3.15e+007,
        __Dymola_NumberOfIntervals=50000,
        __Dymola_fixedstepsize=40,
        __Dymola_Algorithm="Euler"),
      __Dymola_experimentSetupOutput);
  end pid;
end Building;
