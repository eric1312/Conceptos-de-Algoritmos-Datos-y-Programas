{El productor musical Bizarrap organiza sesiones musicales con diferentes artista. Implementar
un programa que lea y almacene informacion de dichas sesiones. De cada sesión se lee: 
titulo de sesión, nombre del artista, genero musical(1: trap latino, 2:reggeaton, 3: urban,
4:electronica, 5:pop Rap) y cantidad de visualizaciones en YouTube. La lectura finaliza
cuando se lee la sesion del artista con nombre "Peso Pluma", la cual debe procesarse. La
informacion debe quedar almacenada en un estructura de datos ordenada por titulo de sesion
de forma ascendente

Una vez leida y almacenada la informacion, se pide:

A. informar los dos codigos de genero musical con mayor cantidad de visualizaciones en 
youtube.

B. Informar la cantidad de sesiones del genero "Reggeaton" cuya cantidad de visiualizaciones
contiene la misma cantidad de digitos pares que impares.
C. Completo: Realizar un modulo que reciba un titulo de sesion y elimine dicha sesion
de la estructura. el titulo de sesion puede no existir. Invocar el modulo desarrollado
en el programa principal con un titulo leido por teclado.
} 

Program ParcialSesion;
const
    Dimf = 5;
type    
    sesion = record
        TituloSesion: string [50];
        NombreArtista: string [40];
        GeneroMusical: 1..Dimf;
        CantVisualizaciones:integer;
    end;

    ListaSecion = ^nodo 

    nodo = record
        dato:sesion;
        sig: ListaSecion;
    end;

    //vectorGenero = array [Dimf] of GeneroMusical;
    VectorVisualizaciones = array [1..Dimf] of integer;

procedure LeerSesion (var s:sesion);
begin 
    writeln ("El titulo de la sesion: ");
    readln (s.TituloSesion);

    writeln ("El nombre del artista es: ");
    readln(s.NombreArtista);

    writeln("El genero musical es: ");
    readln (s.GeneroMusical);
    
    writeln ("la cantidad de visiualizaciones es: ");
    readln (s.CantVisualizaciones);
end;


procedure InsertarOrdenado (var LSecion: ListaSecion; S:secion);
var 
    nue, ant, act: LSecion;

begin 
    new(nue);
    nue^.dato := S;
    nue^.sig := nil;
    if (LSecion = nil) then begin 
        LSecion := nue; 
    end
    else begin
        ant := LSecion;
        act := LSecion;

        while (act <> nil) and (act^.dato.TituloSesion < S.TituloSesion) do begin    //recorre hasta que una de las dos condiciones se cumpla y ascendente
            ant := act;
            act := act^.sig;
        end;
        if (act = LSecion) then begin   // estamos en el primer nodo 
            nue^.sig := LSecion;
            LSecion := nue;
        end
        else begin
            if (act = nil) then begin   // significa que recorrio toda la lista y hay que agregarlo al final
                ant^.sig := nue;
            end
            else begin   // caso cuando tengo que insertar entre dos nodos
                ant^.sig := nue;
                nue^.sig := act;
            end;
        end;
    end;
end;

procedure ArmarLista(var LSecion: ListaSecion);
var 
    S:secion;
begin   
    repeat 
        LeerSesion(S);   //carga registro de sesiones
        InsertarOrdenado (LSecion; S);   // inserta la sesion en la lista, de forma ordenada y ascendente
    until (S.secion = "Peso Pluma");
end;

procedure InicializarV (var VV:VectorVisualizaciones);
var 
    i:integer;
begin
    for i:= 1 to Dimf do 
        VV[i]:=0;
end;

function descomponer (unaCantidad:integer):boolean;
var 
    dig, CantPar, CantImpar:integer;
begin 
    CantPar:=0;
    CantImpar:=0;
    while (unaCantidad <> 0) do begin   
        dig:= unaCantidad MOD 10;
        if(dig MOD 2 = 0)then     // significa que es par 
            CantPar := CantPar + 1
        else     // sino es impar
            CantImpar := CantImpar + 1;
        unaCantidad := unaCantidad div 10;
    end;
    descomponer := CantPar = CantImpar;
end;

procedure RecorrerLista (LSecion:ListaSecion var VV:VectorVisualizaciones);
var 
    contador:integer;
    cumple:boolean;
begin   
    contador := 0;
    while (LSecion <> nil) do begin 
        VV[LSecion^.dato.GeneroMusical] := VV[LSecion^.dato.GeneroMusical] + LSecion^.dato.CantVisualizaciones;
        if (LSecion^.dato.GeneroMusical = 2)then   // significa que es reggeaton
            cumple := descomponer (LSecion^.dato.CantVisualizaciones);
        if (cumple)then 
            contador := contador + 1;
        LSecion:= LSecion^.sig;
    end;
    writeln ("La cantidad de sesiones de reggeaton con la misma cantidad de digitos pares que impares es: ", contador); 
end;

procedure buscarMaximos (VV:VectorVisualizaciones);
var 
    i, Max1, Max2, CodMax1, CodMax2: integer;

begin 
    Max1 := -1;
    Max2 := -1;
    for i := 1 to Dimf do begin
         if (VV [i] > Max1)then begin
            Max2:= Max1;
            CodMax2:= CodMax1;
            Max1 := VV[i];
            CodMax1 := i;
         end
         else begin
            if(VV[i] > Max2)then begin
                Max2 := VV[i];
                CodMax2 := i;
            end;
        end;    
    end;
    writeln ("El codigo de genero con mas visualizaciones es: ", CodMax1);
    writeln ("El codigo de genero con mas visualizaciones es: ", CodMax2);
end;  

procedure EliminarSesion (var LSecion:ListaSecion; TituloSesion: string);
var 
    ant, act: ListaSecion;
    ok: boolean;
begin
    ant:= LSecion;
    act:= LSecion;
    while (LSecion <> nil) and (TituloSesion <> act^.dato.TituloSesion)do begin  // mientras no se encuentre el titulo y no termine la lista
        ant:= act;
        act:= act^.sig;
    end;
    if (act <> nil) then begin //no es vacia la lista y encontre el nodo a eliminar
         ok:= true;
         if (act = LSecion)then   // el elemento a eliminar es el primero 
            LSecion := act^.sig
        else     // el elemento es algun otro, pero no el primero 
            ant^.sig := act^.sig;
        dispose (act);  // se elimina el actual
    end;
end;

end;

// programa principal
var 
    LSecion:lista;
    VV:VectorVisualizaciones;
    TituloSesion: string [50];
begin 
    LSecion := nil;
    ArmarLista(LSecion);
    InicializarV (VV);  //vector contador
    recorrerLista (LSecion; VV);
    buscarMaximos(VV); 
    writeln ("ingrese un titulo para eliminar: " );
    readln (TituloSesion);
    EliminarSesion (LSecion, TituloSesion);
end.