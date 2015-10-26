within DeSchipjesLin.Structures.Data.Glass;
record VoorzetRaam = IDEAS.Buildings.Data.Interfaces.Glazing (
    nLay=3,
    mats={IDEAS.Buildings.Data.Materials.Glass(d=0.004),IDEAS.Buildings.Data.Materials.Air(d=0.04, epsLw_a=0.04),
        IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw=0.04)},
    SwTrans=[0, 0.521; 10, 0.524; 20, 0.517; 30, 0.508; 40, 0.495; 50, 0.472;
        60, 0.418; 70, 0.312; 80, 0.153; 90, 0.000],
    SwAbs=[0, 0.102, 0.0, 0.022; 10, 0.104, 0.0, 0.022; 20, 0.112, 0.0, 0.023;
        30, 0.117, 0.0, 0.023; 40, 0.119, 0.0, 0.025; 50, 0.123, 0.0, 0.026; 60,
        0.135, 0.0, 0.027; 70, 0.142, 0.0, 0.029; 80, 0.105, 0.0, 0.031; 90,
        0.000, 0.0, 0.000],
    SwTransDif=0.418,
    SwAbsDif={0.135,0.0,0.027},
    U_value=2.8,
    g_value=0.85) "Voorzet raam";
