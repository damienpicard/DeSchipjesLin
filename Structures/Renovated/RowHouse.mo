within DeSchipjesLin.Structures.Renovated;
model RowHouse
  "Renovated house not in a corner. These houses include: 152, 154, 156, 148, 146, 144, 142, 140, 138"
  extends PartialRenovated(
    woonruimteHal(azi=0),
    woonruimteKeuken(azi=leftRad),
    woonruimteGemeenschappelijk(azi=rightRad),
    woonruimteAchtergevel(azi=backRad),
    woonruimteVoorgevel(azi=frontRad),
    woonruimteWindow(azi=frontRad),
    woonruimteKoer(azi=leftRad),
    keukenAchtergevel(azi=backRad),
    keukenWindowLarge(azi=frontRad),
    keukenWindowSmall(azi=frontRad),
    keukenGemeenschappelijk(azi=leftRad),
    keukenWC(azi=frontRad),
    WCKoer(azi=rightRad),
    WCVoorgevel(azi=frontRad),
    raamwc(azi=frontRad),
    WCGemeenschappelijk(azi=leftRad),
    slaapkamerZijgevel(azi=leftRad),
    slaapkamerVoorgevel(azi=frontRad),
    slaapkamerGemeenschappelijk(azi=rightRad),
    slaapkamerBadLiggend(azi=backRad),
    slaapkamerBadStaand(azi=backRad),
    slaapkamerDakLinks(azi=leftRad),
    slaapkamerDakRechts(azi=rightRad),
    slaapkamerHal(azi=backRad),
    slaapkamerRaam(azi=frontRad),
    badkamerAchtergevel(azi=backRad),
    badkamerZijgevel(azi=leftRad),
    badkamerHal(azi=rightRad),
    badkamerDak(azi=rightRad),
    WCDak(azi=0),
    halAchtergevel(azi=backRad),
    halGemeenschappelijk(azi=rightRad),
    halDak(azi=0),
    keukenDak(azi=0));

  parameter Real left = 63;
  parameter Real right = 243;
  parameter Real front = 153;
  parameter Real back = -27;

  final parameter Real leftRad=left/180*Modelica.Constants.pi;
  final parameter Real rightRad=right/180*Modelica.Constants.pi;
  final parameter Real frontRad=front/180*Modelica.Constants.pi;
  final parameter Real backRad=back/180*Modelica.Constants.pi;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{220,200}}), graphics));
end RowHouse;
