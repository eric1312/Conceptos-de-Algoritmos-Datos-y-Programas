{Realice un programa que lea de teclado la información de ciudades turísticas
(provincia, nombre de ciudad, cantidad de actividades, cantidad de visitantes),
ORDENADA POR PROVINCIA, que termina con la provincia ‘fin’.

Obtener cuál es la provincia con más visitantes a sus ciudades turísticas.}

program Turistico;
Type
    tciudad = record
        provincia:string;
        nombre:string;
        cantActividades:integer;
        cantVisitantes: integer;
    end;

// programa principal
var 
    ciudadTur:tciudad;
    max,cantidad: integer;
    nomMax, provActual: string;
begin
    nomMax:= "";
    max:= -1;
    leer(ciudadTur);    // se lee el primer registro 
    While (ciudadTur.provincia <> "fin") do begin 
        provActual := ciudadTur.provincia;
        cantidad := 0;
        while (ciudadTur.provincia = provActual) do begin   // corte control 
            cantidad := cantidad + ciudadTur.cantVisitantes;
            leer(ciudadTur);   // se lee otro registro
        end;
        actualizarMax (cantidad, provActual, max, nomMax);
    end;
    writeln ("La provincia con mayor cantidad de visitantes es: ", nomMax);
end;

Procedure leer (var c: tciudad);
begin 
    readln (c.provincia);
    if (c.provincia <> "fin") thn begin 
        readln (c.nombre);
        readln (c.cantActividades);
        readln (c.cantVisitantes);
    end;
end;

Procedure actualizarMax (cantidad: integer; provActual: string; var max: integer; var nomMax:string);
begin
    if(cantidad > max) then begin
        max := cantidad;
        nomMax := provActual;
end;
