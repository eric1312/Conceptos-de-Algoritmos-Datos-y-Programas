{La catedra de CADP esta organizando el parcial, y necesita un programa para obtener informacion
sobre los alumnos recursantes que rendiran.

 A) Realizar un modulo que retorne la informacion de los alumnos en una estructura de datos
 adecuada. Dicha informacion se lee por teclado sin ningun orden. De cada alumno se lee DNI, nombre,
 apellido, año de ingreso, y nota obtenida (entre 0 y 10), en cada una de las 10 autoevaluaciones. En
 caso de realizar alguna autoevaluacion, se asigna la nota -1. La lectura finaliza cuando se ingresa 
 el DNI 33016244 (que debe procesarse).
 
 B) Realizar un modulo que reciba la estructura de datos generada en el inciso anterior, e Imprima
 en pantalla:
    1. DNI de los alumnos que podran rendir el parcial de CADP. Para poder rendir, los alumnos deben
    haber realizadoal menos 8 autoevaluaciones y deben haber aprobado (nota 6 o superior) al 
    menos 4 evaluaciones.
    
    2. El porcentaje de alumnos que hayan ingresado en el año 2020 y que se hayan presentado a todas
    las autoevaluaciones, sobre el total de alumnos.
    
    3. Apellido y Nombre de aquellos alumnos donde la suma de los digitos del DNI es par.}

{PROBLEMA GENERAL 

SE PIDE: 
    A. LEER LA INFORMACION DE CADA ALUMNO Y ALMACENARLA EN UNA LISTA. EL ALUMNO ES UN REGISTRO
    CON UN CAMPO DE TIPO VECTOR (PARA LAS AUTOEVALUACNOES), ENTRE OTROS. NO ES NECESARIO TENER
    DIMENSION LOGICA PARA EL VECTOR DE AUTOEVALUACIONES YA QUE SIEMPRE ESTA CARGANDO POR COMPLETO.
    
    LA INFORMACION SE LEE DESORDENADA Y NO SE REQUIERE ALMACENAR EN NINGUN ORDEN ESPECIFICO.
    DEBERIAMOS HACER UN INSERTAR ADELANTE O ATRAS QUE SON LOS MAS SIMPLE Y EFICIENTE.
    
    EL CORTE DE FIN ES 33016244 Y DEBE PROCESARSE POR LO TANTO HAY QUE USAR UN REPEAT UNTIL
    PARA LA LECTURA.
    
    B. LOS SIGUIENTES INCISOS SE DEBEN CALCULAR E INFORMAR RECORRIENDO UNA SOLA VEZ LA LISTA:
        
        1. IMPRIMIR EL DNI DE LOS ALUMNOS CON CANTIDAD DE AUTOEVALUACIONES REALIZADAS >= 8 Y
        APROBARON (NOTA >= 6) AL MENOS 4. ES NECESARION RECORRER EL VECTOR DE AUTOEVALUACIONES. SI 
        LA NOTA ES -1 SIGNIFICA QUE NO REALIZO LA AUTOEVALUACION.
        
        2. IMPRIMIR PORCENTAJE DE ALUMNOS CUYO AÑO ES INGRESO ES 202O Y QUE NO SE HAYAN PRESENTADO A
        TODAS LAS AUTOEVALUACIONES. ES NECESARIO RECORRER EL VECTOR DE AUTOEVALUACIONES VERIFICANDO QUE 
        NO HAYA NINGUN -1 (AUSENTE). HAY QUE RECORRER LA LISTA Y SE IMPRIME UNA UNICA VEZ AL FINAL.
        
        3. IMPRIMIR NOMBRE Y APELLIDO DE LOS ALUMNOS CUYA SUMA DE DIGITOS DEL DNI ES PAR. DESCOMPONER CADA
        DNI SUMADNO SUS DIGITOS EN UNA VARIABLE. VERIFICAR QUE EL RESULTADO SEA PAR.}

program recursantes;
Const
    cant_evaluacion = 10;
Type 
    rango_eval = 1..cant_evaluacion;

    vector_eval = array [rango_eval] of integer;

    alumno = record
        dni:integer;
        nombre-apellido: string;
        ingreso: integer;
        autoevaluacion: vector_eval;
    end;

    listaAlum = ^nodo
    nodo = record
        dato: alumno;
        sig: listaAlum;
    end;

// programa pricipal
var 
    LA: listaAlum;
begin
    cargarAlumnos(LA); // inciso A
    procesarEImprimir (LA); // inciso B
end.

procedure leer_auto_eval (var v:vector_eval);
var 
    i:integer;
begin 
    for i := q to cant_evaluacion do    
        readln (v[i]);
end;

procedure leerAlumno (var a:alumno);
begin 
    readln (a.dni);
    readln (a.nombre-apellido);
    readln (a.ingreso);
    leer_auto_eval (a.autoevaluacion);
end;

// agrego el agregar adelante
procedure AgregarAdelante (var LA:listaAlum; a:alumno);
var 
    aux: listaAlum;
begin 
    new(aux);
    aux^.dato := a;
    aux^.sig := LA;
    LA := aux;
end;

procedure cargarAlumnos (var LA:listaAlum);
var 
    a:alumno;
begin 
    LA := nil;
    REPEAT
        leer_auto_eval (a);
        AgregarAdelante (LA, a);
    UNTIL(a.dni = 33016244)
end;

procedure procesarEImprimir (LA: listaAlum);
var 
    aprobadas, presentes, cant_alumnos, cant_total_Al : integer;
begin 
    cant_alumnos := 0;
    cant_total_Al := 0;
    while (LA <> nil) do begin
        cant_total_Al := cant_total_Al + 1;
        contar_auto_eval (LA^.dato.autoevaluacion, aprobadas, presentes);
        // INCISO B1
        if (aprobadas >= 4) and (presentes >= 8)then
            writeln (LA^.dato.dni);
        
        //INCISO B2
        if (cumple_condicion(LA^.dato.ingreso, presentes))then 
            cant_alumnos := cant_alumnos + 1;
        
        //INCISO B3
        if (suma_digitos(LA^.dato.dni) MOD 2 = 0)then 
            writeln (LA^.dato.nombre-apellido);
    end;
    writeln (porcentaje (cant_alumnos, cant_total_Al));
end;

procedure contar_auto_eval (v:vector_eval; var aprobadas, presentes:integer);
var 
    i:integer;
begin
    presentes := 0;
    aprobadas := 0;
    for i := 1 to cant_evaluacion do 
        if (v[i] >= 0) then begin 
            presentes := presentes + 1;
            if (v[i] >= 6) then 
                aprobadas := aprobadas + 1;
        end;
end;

procedure cumple_condicion (ingreso, presentes: integer): boolean;
begin 
    cumple_condicion := (ingreso = 2020) and (presentes = cant_evaluacion);
end;

function suma_digitos (num:integer):boolean;
var 
    suma:integer;
begin 
    suma := 0;
    while ( num <> 0) do begin 
        suma := suma + (num MOD 10);  // sumo el ultimo digito de num
        num := num DIV 10;
    end;
end;

function porcentaje (num1, num2: integer):real;
begin 
    porcentaje := (num1 * 100 / num2);
end;