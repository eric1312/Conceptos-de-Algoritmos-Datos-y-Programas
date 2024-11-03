{Enunciado TEMA 1
La catedra de CADP necesita un programa para generar el listado de los alumnos ingresantes
que rendiran el parcial. Para ello, se DISPONE de un listado con todos los alumnos que ingresaron
este año a la facultad. De cada alumno se conoce su DNI, nombre y apellido, nota obtenida
en curso de ingreso (entre 4 y 10), turno (entre 1 y 4) y si estuvo presente o ausente en 
cada una de las 12 clases de practica.

A) Realizar un modulo que reciba la informacion de los alumnos y retorne una nueva estructura
    de datos que contenga solo aquellos que podran rendir el parcial. Para poder rendir el parcial,
    los alumnos deben contar con al menos 8 asistencias en las 12 clases de practica.
B) Realizar un modulo que reciba la estructura de datos generada en el inciso anterior, e
    imprima en pantalla:
        1. Apellido y nombre y el dni de los alumnos que hayan obtenido nota 8 o superior
            en el ingreso
        2. Turno con mayor cantidad de alumnos en condiciones de redir el examen.
        3. Cantidad de alumnos que posean ningun digito cero en su DNI.

NOTA: Implentear el programa Principal.}

{PROBLEMA GENERAL

-SE DISPONE DE UNA LISTA DE ALUMNOS INGRESANTES
-EL ALUMNO ES UN REGISTRO CON UN CAMPO DE TIPO VECTOR (PARA ALMACENAR LAS ASISTENCIAS),
 ENTRE OTROS. NO ES NECESARIO TENER UNA DIMENSION LOGICA PARA EL VECTOR DE ASISTENCIAS
 YA QUE ESTA CARGADO POR COMPLETO.

SE PIDE:
    1. GENERAR UNA NUEVA LISTA CON LOS ALUMNOS QUE ESTAN EN CONDICIONES DE RENDIR EL PARCIAL
        (AL MENOS 8 ASISTENCIAS). LA LISTA A GENERAR ES DEL TIPO QUE LA QUE SE DISPONE
    
    LOS SIGUIENTES INCISOS SE DEBEN CALCULAR E INFORMAR RECORRIENDO UNA SOLA VEZ LA LISTA
    GENERADA:
    
    2. HACER UN WRITE DE NOMBRE, APELLIDO Y DNI DE LOS ALUMNOS CON >= 8. SE COMPARA LA NOTA
        Y SI SE CUMPLE SE IMPRIMEN LOS CAMPOS DEL REGISTRO.
    
    3. CALCULAR EL TURNO CON MAYOR CANTIDAD DE ALUMNOS EN CONDICIONES DE RENDIR. ES NECESARION
        USAR UN VECTOR CONTADOR. SE INICIALIZA A 0 Y SE INCREMENTA AL RECORRER LA LISTA. POR 
        ULTIM SE RECORRE EL VECTOR PARA OBTENER EL MAXIMO E IMPRIMIR EL TURNO.
    
    4. DESCOMPONER CADA DNI VERIFICANDO QUE NO TIENE EL DIGITO 0. SI ES ASI INCREMENTAMOS
        UNA VARIABLE. ESTE PUNTO SE CALCULA AL RECORRER LA LISTA Y SE IMPRIME UNA UNICA 
        VEZ AL FINAL.}

program CADP;
const   
    cant_clases = 12;
    cant_turnos = 4;
type
    rango_notas = 4..10;
    rango_turnos = 1..cant_turnos;
    rango_clases = 1..cant_clases;
    
    vector_clases = array [rango_clases] of boolean;

    alumno = record
        DNI:integer;
        nombre-Apellido:string;
        nota: rango_notas;
        turno:rango_turnos;
        asistencias:vector_clases;
    end;

    ListaAlum = ^nodo
    
    nodo = record
        dato: alumno;
        sig: ListaAlum;
    end;

    vector_turnos = array [rango_turnos] of integer; // vector contador

// Programa Principal

var 
    L1, L2: ListaAlum;
begin
    cargarAlumnos (L1);  // SE DISPONE
    precesarAlumnos (L1, L2); // PUNTO A
    procesarEImprimir (L2);  // PUNTO B
end.


procedure AgregarAdelante (var L: lista ; a:alumno);
var 
    aux:lista;
begin
    new(aux);
    aux^.dato := a;
    aux^.sig := L;
    L := aux;
end;

function cumple_condicion (asistencia: vector_clases):boolean;
var 
    i, cant: integer;
begin
    cant:= 0;
    i := 1;
    while (i <= 12) and (cant < 8) do begin
        if (asistencia [i])then 
            cant := cant + 1;
        i := i + 1;
    end;
    cumple_condicion := (cant = 8);
end;

procedure precesarAlumnos (L1:ListaAlum, var lista_rinden: ListaAlum);
var
    aux: alumno;
begin
    lista_rinden:= nil;
    while ( L1 <> nil) do begin
        aux := L1^.dato;
        if (cumple_condicion (aux.asistencias)) then  // vector de las 12 materias de asistencia
            AgregarAdelante (lista_rinden, aux);
        L1:= L1^.sig;
    end;
end;

procedure inicilizar (var v: vector_turnos);
var 
    i:rango_turnos;
begin
    for i:= 1 to cant_turnos do 
        v[i] := 0;
end;

function maximo (v:vector_turnos):boolean;
var 
    i, max_turno: rango_turnos;
    maxAlumnos:integer;
begin
    maxAlumnos := -1;
    for i := 1 to cant_turnos do 
        if (v[i] > maxAlumnos)then begin
            maxAlumnos := v[i];
            max_turno := i;
        end;
    maximo := max_turno;
end;

function tiene_ceros (num: integer): boolean;
var 
    encontre_un_cero: boolean;
    dig: integer;
begin
    encontre_un_cero := false;
    while (num <> 0) and (not encontre_un_cero)do begin
        dig := num MOD 10;
        if (dig = 0) then 
            encontre_un_cero := true
        else
            num := num DIV 10;
    end;
    tiene_ceros := encontre_un_cero;
end;

procedure procesarEImprimir (L2: lista);
var 
    turnos:vector_turnos;
    cantAlumnos: integer;
begin
    inicilizar(turnos);
    cantAlumnos:= 0;
    while ( L2 <> nil) do begin 
        if (L2^.dato.nota >=8)then  // INCISO 1
            writeln (L2^.dato.nombre-Apellido, L2^.dato.DNI)
        turnos [L2^.dato.turno] := turnos [L2^.dato.turno] + 1; //INCISO 2
        if (tiene_ceros (L2^.dato.dni) = 0)then // INCISO 3
            cantAlumnos := cantAlumnos + 1;
        L2 := L2^.sig;
    end;
    writeln (maximo (turnos));
    writeln (cantAlumnos);
end;

