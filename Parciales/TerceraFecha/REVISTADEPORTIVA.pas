{TEMA 1
UNA REVISTA DEPORTIVA DISPONE DE INFORMACION DE LOS JUGADORES DE FUTBOL PARTICIPANTES DE 
LA LIGA PORFESIONAL 2022. DE CADA JUGADOR SE CONOCE CODIGO DE JUGADOR, APELLIDO Y NOMBRES, 
CODIGO DE EQUIPO (1..28), AÑO DE NACIMIENTO Y LA CALIFICACION OBTENIDA PARA CADA UNA DE LAS 
27 FECHAS DEL TORNEO YA FINALIZADO. LA CALIFICACAION ES NUMERICA DE 0 A 10, DONDE EL VALOR 0
SIGINIFICA NO HA PARTICIPADO DE LA FECHA.

SE SOLICITA:
    A. INFORMAR PARA CADA EQUIPO LA CANTIDAD DE JUGADORES MAYORES A 35 AÑOS.
    B. INFORMAR LOS CODIGOS DE LOS 2 JUGADORES CON MEJOR CALIFICACION PROMEDIO EN LOS PARTIDOS
    EN LOS QUE PARTICIPO. SOLO DEBE CONSIDERARSE LOS JUGADORES QUE PARTICIPARON EN MAS DE 14 FECHAS.
    C. IMPLEMENTAR E INVOCAR UN MODULO QUE GENERE UNA LISTA CON LOS JUGADORES CUYO CODIGO EXACTAMENTE
    3 DIGITOS IMPARES Y HAYA NACIDO ENTRE 1983 Y 1990. LA LISTA DEBE ESTAR ORDENADA POR CODIGO 
    DE JUGADOR.}

program Jugadores;
Const
    equipos = 28;
    fechas = 27;
Type
    rango_equipos = 1..equipos;
    rango_fechas = 1.. fechas;

    vector_puntuaciones = array [rango_fechas] of integer;

    jugador = record    
        codigoJugador:integer;
        apellido: string;
        nombre: string;
        equipo: rango_equipos;
        añoNacimiento: integer;
        calificacionObtenida: vector_puntuaciones;
    end;

    listaJugador = ^nodo;

    nodo = record   
        dato: jugador;
        sig: listaJugador;
    end;

    vector_equipos = array [rango_equipos] of integer;    // vector contador para el inciso A


procedure cargarJugador (var L:listaJugador);  // se dipone

procedure inicilizarVector (var v: vector_equipos);
var
    i: integer;
begin
    for i := 1 to equipos do 
        v[i] := 0;
end;

procedure amanilizarPuntuaciones (v: vector_puntuaciones; var promedio: real; var fechas: integer);
var 
    i: rango_fechas;
    suma: integer;
begin
    suma := 0;
    fechas := 0;
    for i := 1 to fechas do begin 
        if (v[i] <> 0) then begin 
            suma:= suma + v[i];
            fechas := fechas + 1;
        end;
    end;
    promedio := suma / fechas;
end;

// procedimiento maximos
procedure actualizarMax(VAR jug1, jug2:integer; var prom1, prom2: real; jugador: integer; promedo: real);
begin
    if (promedio > prom1) then begin
        jug2 := jug1;
        prom2:= prom1;
        jug1:= jugador;
        prom1:= promedio;
    end
    else begin
        if (promedio > prom2) then begin
            prom2:= promedio;
            jug2:= jugador;
        end;
    end;
end;


procedure recorrer (L:listaJugador; var v:vector_equipos; var jug1, jug2: integer);
var
    promedio, prom_jug1, prom_jug2: real;
    cant: real;
begin
    prom_jug1:= -1;
    prom_jug2:= -1;
    while (L <> nil) do begin
        if (L^.dato.añoNacimiento > 35)then 
            v[L^.dato.equipo] := v[L^.dato.equipo] + 1;
        amanilizarPuntuaciones (L^.dato.calificacionObtenida, promedio, cant);
        if (cant > 14) then
            actualizarMax(jug1, jug2, prom_jug1, prom_jug2, L^.dato.codigoJugador, prom);
        L:= L^.sig;
    end;
end;


procedure imprimir (v: vector_equipos);
var 
    i:rango_equipos;
begin
    for i:= 1 to equipos do 
        writeln ("el equipo ",i,"tiene ", v[i], "jugadores de mas de 35 años");
end;

function contarImpares (x:integer): integer;
var 
    cant:integer;
begin
    cant := 0;
    while (x <> 0) do begin
        if (((x MOD 10 ) MOD 2) = 1) then  
            cant := cant + 1;
        X:= x DIV 10;
    end;
end;

procedure insertarOrdenado (var L:listaJugador; J:jugador);
var
  ant,act: lista;
  nue: lista;
begin
  new(nue);
  nue^.dato:= J;
  act:= L;
  ant:= L;
  While(act <> nil) and (j.codigoJugador > L^.dato.codigoJugador)do  //ascendente
    begin
      ant:= act;
      act:= act^.sig;
    end;
  if(act = ant)then
    L:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure armarLista35 (L:listaJugador; var L35:listaJugador);
begin
    while (L <> nil) do begin
        if (contarImpares(L^.dato.codigoJugador) = 3) and (L^.dato.añoNacimiento >= 1983) and (L^.dato.añoNacimiento <= 1990) then
                insertarOrdenado(L2, L^.dato);
    end;
end;


// programa principal
var 
    L, L35: listaJugador;
    v: vector_equipos;
    jug1, jug2: intger;
begin
    L := nil;
    L35 := nil 
    cargarJugador (L); // se dispone
    inicilizarVector (v);
    recorrer(L, v, jug1, jug2);
    imprimir (v);
    writeln (jug1, jug2);
    armarLista35(L, L35);
end.