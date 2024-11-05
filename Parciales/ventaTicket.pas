{TEMA 1- PRIMERA FECHA 10/06/2023
UNA EMPRESA DE VENTAS DE TICKETS DE TREN ESTA ANALIZANDO LA INFORMACION DE LOS VIAJES REALIZADOS
POR SUS TRENES DURANTE EL AÑO 2022. PARA ELLO. SE DISPONE DE UNA ESTRUCTURA DE DATOS CON LA INFORMACION 
DE TODOS LOS VIAJES. DE CADA VIAJE SE CONOCE EL CODIGO DE TREN, EL MES EN QUE SE REALIZO EL VIAJE (ENTRE 1 Y 12),
LA CANTIDAD DE PASAJEROS QUE VIAJARON, Y EL CODIGO DE LA CIUDAD DE DESTINO (ENTRE 1 Y 20). LA INFORMACION SE 
ENCUENTRA ORDENADA POR CODIGO DE TREN (ACLARACION = CORTE DE CONTROL).
ADEMAS, LA EMPRESA DISPONE DE UNA ESTRUCTURA DE DATOS CON INFORMACION DEL COSTO DEL TICKET POR CIUDAD DESTINO.

REALIZAR UN PROGRAMA QUE PROCESE LA INFORMACION DE LOS VIAJES Y:
    1. GENERE UNA LISTA QUE TENGA POR CADA CODIGO DEL TREN, LA CANTIDAD DE VIAJES REALIZADOS.
    2. INFORME EL MES CON MAYOR MONTO RECAUDADO.
    3. INFORME EL PROMEDIO DE PASAJEROS POR CADA TREN ENTRE TODOS SUS VIAJES.}

program Ticket;
Const
    meses = 12;
    ciudad_destino = 20;
Type    
    rangoMeses = 1..meses;
    rangoCiudades = 1.. ciudad_destino;

    viaje = record 
        codTren: integer;
        mes: rangoMeses;
        cantPasajeros: integer;
        ciudadDestino: rangoCiudades;
    end;

    listaViajes = ^nodo;

    nodo = record   
        dato: viaje;
        sig: listaViajes;
    end;

    vectorCostos = array [rangoCiudades] of real;

    infotren = record
        tren: integer;
        cant:integer,
    end;

    listaTrenes = ^nodotren

    nodotren = record
        dato: infotren;
        sig: listaTrenes;
    end;

    vectorRecaudaciones = array [rangoMeses] of real;

procedure cargarLista (var L: listaViajes);  // se dipone 
procedure cargarVector (var v: vectorCostos);  // se dispone

procedure inicilizarVector (recaudaciones: vectorRecaudaciones);
var 
    i: rangoMeses;
begin
    for i := 1 to rangoMeses do 
        recaudaciones [i] := 0;
end;

function maximo (recaudaciones: vectorRecaudaciones): real;
var 
    max: real;
    mesMax, i : rangoMeses;
begin
    max:= -1;
    for i := 1 to 12 do 
        if (recaudaciones[i] > max) then begin 
            max:= recaudaciones [i];
            mesMax := i;
        end;
    maximo := mesMax;
end;

procedure agregarAdelante (var L2: listaTrenes; info: infotren);
var 
    aux: listaTrenes;
begin
    new(aux);
    aux^.dato := info;
    aux^.sig := listaTrenes;
    listaTrenes := aux; 
end;

procedure procesarViajes (L:listaViajes; v: vectorCostos; var L2: listaTrenes; recaudaciones: vectorRecaudaciones );
var
    TrenACtual, cantViajes, cantPasajeros: integer;
    costo:real;
    tren: infotren;
begin
    while (L <> nil) do begin 
        TrenACtual:= L^.dato.codTren;
        cantViajes:= 0;
        cantPasajeros := 0;
        while (L <> nil) and (TrenACtual = L^.dato.codTren) do begin 
            cantViajes := cantViajes + 1;
            cantPasajeros := cantPasajeros + L^.dato.cantPasajeros;
            costo := v[L^.dato.ciudadDestino] * L^.dato.cantPasajeros;
            recaudaciones[L^.dato.mes] := recaudaciones[L^.dato.mes] + costo;

            L := L^.sig;
        end;
        infotren.tren := TrenACtual;
        infotren.cant := cantPasajeros;
        agregarAdelante (L2, infotren);
        writeln ("el promedio de pasajeros del tren ", TrenACtual, "es ", cantPasajeros/cantViajes);
end;

// programa principal 
var 
    L:listaTrenes;
    v: vectorCostos;
    trenes: listaTrenes;
    recaudaciones: vectorRecaudaciones;
begin
    cargarLista (L);  // se dispone
    cargarVector(V);  // se dipone
    listaTrenes := nil;

    inicializar vector (recaudaciones);
    procesarViajes (L, v, listaTrenes, recaudaciones);
    writeln ("El mes con mayor recaudacion fue ", maximo(recaudaciones));
end.