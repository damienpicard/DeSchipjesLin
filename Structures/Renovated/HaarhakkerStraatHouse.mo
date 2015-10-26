within DeSchipjesLin.Structures.Renovated;
model HaarhakkerStraatHouse "House in the direction of the Haarhakkerstraat"
  extends RowHouse(
    right=243,
    left=63,
    front=153,
    back=-27);

    annotation (Placement(transformation(extent={{210,170},{190,190}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,-100},{220,
            200}})));
end HaarhakkerStraatHouse;
