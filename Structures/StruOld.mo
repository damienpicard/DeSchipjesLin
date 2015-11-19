within DeSchipjesLin.Structures;
model StruOld
  extends partial_structure(
    woonruimte(n50=14.7),
    keuken(n50=6),
    wc(n50=6.78),
    slaapkamer(n50=7.02),
    badkamer(n50=6.96),
    nachthal(n50=10.73),
    woonruimteKoer(redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType,
      insulationThickness=isolatieTest),
    woonruimteVloer(redeclare Data.Constructions.Old.Vloer
        constructionType,
      insulationThickness=isolatieTest),
    woonruimteAchtergevel(redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType,
      insulationThickness=isolatieTest),
    woonruimteVoorgevel(redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType,
      insulationThickness=isolatieTest),
    keukenAchtergevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    woonruimteWindow(
      frac=0.12,
      redeclare Data.Glass.VoorzetRaam                                 glazing,
      redeclare Data.Frames.LoofHout                                 fraType,
      redeclare IDEAS.Buildings.Components.Shading.None shaType),
    keukenWindowLarge(
      frac=0.15,
      redeclare Data.Frames.LoofHout                                 fraType,
      redeclare IDEAS.Buildings.Components.Shading.None shaType,
      redeclare Data.Glass.DubbelGlas                                 glazing),
    keukenWindowSmall(
      frac=0.25,
      redeclare Data.Glass.DubbelGlas                                 glazing,
      redeclare Data.Frames.LoofHout                                 fraType),
    keukenVloer(
      insulationThickness=0, redeclare Data.Constructions.Old.Vloer
        constructionType),
    WCKoer(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDun
        constructionType),
    raamwc(
      frac=0.89,
      redeclare Data.Glass.DubbelGlas                                 glazing,
      redeclare Data.Frames.LoofHout                                 fraType),
    WCVoorgevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    WCVloer(
      insulationThickness=0, redeclare Data.Constructions.Old.Vloer
        constructionType),
    slaapkamerZijgevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    slaapkamerVoorgevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    slaapkamerRaam(
      frac=0.21,
      redeclare Data.Glass.VoorzetRaam                                 glazing,
      redeclare Data.Frames.LoofHout                                 fraType),
    badkamerAchtergevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    badkamerZijgevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType),
    halAchtergevel(
      insulationThickness=0, redeclare Data.Constructions.Old.BuitenMuurDik
        constructionType));
        annotation (   Documentation(info="<html>
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
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(\"DeSchipjesLin.Structures.StruOld\");<br/>
writeMatrix(fileName=\"StruOld.mat\",matrixName=\"A\",matrix=re.A);<br/>
writeMatrix(fileName=\"StruOld.mat\",matrixName=\"B\",matrix=re.B, append=true);<br/>
writeMatrix(fileName=\"StruOld.mat\",matrixName=\"C\",matrix=re.C, append=true);<br/>
writeMatrix(fileName=\"StruOld.mat\",matrixName=\"D\",matrix=re.D, append=true);<br/>
OutputCPUtime:=true;</code>
</html>", revisions="<html>
<ul>
<li>
August, 2015 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"));
end StruOld;
