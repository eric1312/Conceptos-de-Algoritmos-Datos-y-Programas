
// el 13 y 14 se van a resolver con la misma logica 
// si se hace declarando un for o un while y cargando en un vector de registros para despues recorrerlo esta mal
// vos tenes 1000 proyectos y en cada [i] de proyecto no sabes cuantos desarrolladores se van a leer

{
El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
CÓDIGO                  ROL DEL DESARROLLADOR                 VALOR/HORA (USD)

1                       Analista Funcional                        35,20
2                       Programador                               27,45
3                       Administrador de bases de datos           31,03
4                       Arquitecto de software                    44,28
5                       dministrador de redes y seguridad         39,87


Nota: los valores/hora se incluyen a modo de ejemplo

Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
  a) El monto total invertido en desarrolladores con residencia en Argentina.
  b) La cantidad total de horas trabajadas por Administradores de bases de datos.
  c) El código del proyecto con menor monto invertido.
  d) La cantidad de Arquitectos de software de cada proyecto.
}








































//para hacer esto necesitas un vector de vectores y algo parecido a listas 
//se tendria que implementar algo de esta indole, terminar de pensar como funcionaria si no se pueden vector de vectores ni listas hasta este punto

Program prueba;

Type 
  mil = 1..1000;

  data = Record
    nombre: string;
    cod: mil;
  End;


  vProyectos = array[1..1000] Of data;

  vDevs = array[1..5] Of integer; {represanta cuantos devs tiene Resetear i}
  vContadorDevs = array[1..1000] Of devs; {vas a tener un vector de mil  q cada proyecto[i] va guardar un vector de 1 a 5}


Procedure cargaVector(Var dimL: integer);

Var 
  i: integer;
Begin
  For i:= 1 To 1000 Do
    Begin
      leerDatos(r);
      While (r.cod <> -1 ) Do
        Begin
          dimL := dimL +1;
          leerDatos(r);
          v[i]
        End;
    End;
End;

Var 
  i: integer;
  dimL: integer;
Begin
  dimL := 0;
  cargaVector(dimL);

End.














//--------------------------------------programEze------------------------------------------------------------------





{14. 
El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:

CÓDIGO        ROL DEL DESARROLLADOR                     VALOR/HORA (USD)
1             Analista Funcional                        35,20
2             Programador                               27,45
3             Administrador de bases de datos           31,03
4             Arquitecto de software                    44,28
5             Administrador de redes y seguridad        39,87

Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:

a) El monto total invertido en desarrolladores con residencia en Argentina.
b) La cantidad total de horas trabajadas por Administradores de bases de datos.
c) El código del proyecto con menor monto invertido.
d) La cantidad de Arquitectos de software de cada proyecto.}

Program eje14;

Const 
  dimF = 1000;

Type 

  REG_participante = Record
    pais,nomProyecto: string;
    cod, rol: integer;
    cantHoras: real;
  End;
{---------vector herramienta-------------------}
  REG_vector = Record
    montoDesarrollador,cantHoras,menorMonto: real;
    cantRol: integer;
  End;

  vector = array [1..dimF] Of REG_vector;
  {-------------------------------------------}
  vectorP = array [1..5] Of real;

  // ========= C. INICIALIZACION DE VECTORES ==========
Procedure inicializarVector (Var v: vector);

Var 
  x: integer;
Begin
  For x:= 1 To dimF Do
    Begin
      v[x].montoDesarrollador := 0;
      v[x].cantHoras := 0;
      v[x].menorMonto := 0;
      v[x].cantRol := 0;
    End;
End;

Procedure inicializarPrecios (Var vp: vectorP);
Begin
  vp[1] := 35.20;
  //Analista Funcional
  vp[2] := 27.45;
  //Programador
  vp[3] := 31.03;
  //Administrador de bases de datos
  vp[4] := 44.28;
  //Arquitecto de software 
  vp[5] := 39.87;
  //Administrador de redes y seguridad 
End;
// ========= F. INICIALIZACION DE VECTORES ==========


// ========= C. CARGA DE VECTORES ==========
Procedure cargarVector (Var v: vector; r: REG_participante; vp: vectorP);
Begin
  //Inciso A
  If (r.pais = 'argentina') Then
      {por aca para calcular el monto invertido tambien necesitas la cantidad d hs trabajadas y a eso multiplcar tu vector de precios}
    v[r.cod].montoDesarrollador := v[r.cod].montoDesarrollador + vp[r.rol];

  //Inciso B
  If (r.rol = 3) Then
    v[r.cod].cantHoras := v[r.cod].cantHoras + r.cantHoras;

  //Inciso C
  v[r.cod].menorMonto := v[r.cod].menorMonto + vp[r.rol];

  //Inciso D
  If (r.rol = 4) Then
    v[r.cod].cantRol := v[r.cod].cantRol + 1;
End;

Procedure leer(Var v: vector; vp: vectorP);

Var 
  r: REG_participante;
Begin
  write ('Codigo proyecto: ');
  readln(r.cod);
    {aca si no te ingresan el -1, se rompe al pasar la dimF}
  While (r.cod <> -1) Do
    Begin
      write ('Pais: ');
      readln(r.pais);
      write ('Nombre Proyecto: ');
      readln(r.nomProyecto);
      write ('Rol en el proyecto (1 a 5): ');
      readln(r.rol);
      write ('Cantidad de horas trabajadas: ');
      readln(r.cantHoras);
        {aca cargas solo los datos q te interesan}
      cargarVector(v,r,vp);

      write ('Codigo proyecto: ');
      readln(r.cod);
    End;
End;
// ========= F. CARGA DE VECTORES ==========

// ========= C. IMPRIMIR ==========
{d) La cantidad de Arquitectos de software de cada proyecto.}
Procedure imprimir (v: vector);

Var 
  x: integer;
  montoDesarrollador,cantHoras,menorMonto: real;
  codigo: integer;
Begin
  montoDesarrollador := 0;
  cantHoras := 0;
  menorMonto := 32767;
  For x:=1 To dimF Do
    Begin
      montoDesarrollador := montoDesarrollador + v[x].montoDesarrollador;
      cantHoras := cantHoras + v[x].cantHoras;
      If (v[x].menorMonto < menorMonto) Then
        Begin
          menorMonto := v[x].menorMonto;
          codigo := x;
        End;
      writeln('La cantidad de Arquitectos de software de cada proyecto: ',v[x].cantRol,'.');
    End;
  writeln('El monto total invertido en desarrolladores con residencia en Argentina es: ',montoDesarrollador:5:2,'.');
  writeln('La cantidad total de horas trabajadas por Administradores de bases de datos: ',cantHoras:5:2,'.');
  writeln('El código del proyecto con menor monto invertido: ',codigo,'.');
End;
// ========= F. IMPRIMIR ==========

//Programa principal

Var 
  v: vector;
  vp: vectorP;
Begin
  {vector De precios}
  inicializarPrecios(vp);
  {vector de registros tipo contador H}
  inicializarVector(v);





{leerDatos y lo cargas en un vector Herramientas / problema con la dimF del While / calculo de montos no es correcto necesitas calcular el precio*la cantidad de horas trabajadas
  y eso guardar en el vector herramienta}
  leer(v,vp);
  {x}
  imprimir(v);
End.





















//lo de abajo esta mal

{
El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
CÓDIGO                  ROL DEL DESARROLLADOR                 VALOR/HORA (USD)

1                       Analista Funcional                        35,20
2                       Programador                               27,45
3                       Administrador de bases de datos           31,03
4                       Arquitecto de software                    44,28
5                       dministrador de redes y seguridad         39,87


Nota: los valores/hora se incluyen a modo de ejemplo

Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
  a) El monto total invertido en desarrolladores con residencia en Argentina.
  b) La cantidad total de horas trabajadas por Administradores de bases de datos.
  c) El código del proyecto con menor monto invertido.
  d) La cantidad de Arquitectos de software de cada proyecto.
}

Program ejercicio14;

Const 
  mil = 1000;
  cinco = 5;

Type 
  str20 =  string[20];
  rango1k = 1..mil;
  rango1a5 = 1..cinco;

  participante = Record
    pais: str20;
    codProyecto: rango1k;
    nombreProyecto: str20;
    rol: rango1a5;
    cantHorasTrabajadas: real;
  End;

  vProyectos = array[1..mil] Of participante;


Procedure leerDatos(Var r: participante);
Begin
  Writeln('Ingrese el pais de residencia: ');
  readln(r.pais);
  Writeln('Ingrese el codigo de proyecto: ');
  readln(r.codProyecto);
  If (r.codProyecto <> -1 )Then
    Begin
      Writeln('Ingrese el nombre del proyecto: ');
      readln(r.nombreProyecto);
      Writeln('Ingrese el rol del participante rango de 1  a 5: ');
      readln(r.rol);
      Writeln('Ingrese la cantidad de horas trabajadas: ');
      readln(r.cantHorasTrabajadas);
    End;
End;

Procedure cargarVector(Var vProy: vProyectos;Var dimL: integer);

Var 
  r: participante;
Begin
  leerDatos(r);
  While (r.codProyecto <> -1 ) And (dimL <= mil) Do
    Begin
      dimL := dimL+1;
      vProy[dimL] := r;
      leerDatos(r);
    End;
End;

//se invoca para calcular unicamente el valor x
Function dataTable(num: rango1a5): real;
Begin
  Case num Of 
    1: dataTable := 35.20;
    2: dataTable := 27.45;
    3: dataTable := 31.03;
    4: dataTable := 44.28;
    5: dataTable := 39.87;
    // -1: dataTable:= Writeln('Finalizo la carga ');
    Else Writeln('Ingresaste un codigo fuera de rango');
  End;
End;

Function gastoDev(horas: real; codProyecto: integer): real;
Begin
  gastoDev := (dataTable(codProyecto) * horas)
End;


Procedure proyectoMenorInversion(gasto: real; cod: integer; Var min1: real; Var codMinBs: rango1k);

Var 

Begin
  If (gasto < min1)Then
    Begin
      min1 := gasto;
      codMinBs := cod;
    End;
End;

Procedure recorrerVector(vProy: vProyectos; dimL: integer;Var gastoDevArg,cantHsBd: real;Var codMinBs: rango1k);

Var 
  i: integer;
  min1: real;
  cod: rango1k;
Begin
  min1 := 9999;
  For i:=  1 To dimL Do
    Begin
      If (vProy[i].pais = 'Argentina')Then
        gastoDevArg := gastoDev(vProy.cantHorasTrabajadas,vProy[i].codProyecto);
      If (vProy[i].codProyecto = 3) Then
        cantHsBd := cantHsBd + vProy[i].cantHorasTrabajadas;
      cod := vProy[i].codProyecto;
      proyectoMenorInversion(gastoDev(vProy[i].cantHorasTrabajadas,vProy[i].codProyecto),cod,min1,codMinBs);
    End;
End;

Procedure procesarDatos(Var montoTotalInvertidoDevsArg,cantHorasTolalAdmBd: real; Var codProyectoMenorInversion: rango1k;Var  cantArqDeSoftDcadaProy: integer);

Var 
  vProy: vProyectos;
  dimL: integer;
Begin
  dimL := 0;
  cantHorasTolalAdmBd := 0;
  cargarVector(vProy,dimL);
  recorrerVector(vProy,dimL,montoTotalInvertidoDevsArg,cantHorasTolalAdmBd,codProyectoMenorInversion)
End;

Var 
  montoTotalInvertidoDevsArg,cantHorasTolalAdmBd: real;
  codProyectoMenorInversion: rango1k;
  cantArqDeSoftDcadaProy,anho: integer;

Begin
  Writeln('Ingresa el anho ');
  readln(anho);
  If (anho = 2017)Then
    Begin
      procesarDatos(montoTotalInvertidoDevsArg,cantHorasTolalAdmBd,codProyectoMenorInversion,cantArqDeSoftDcadaProy);
      Writeln('El monto total invertido en desarrolladores con residencia en Argentina es: ',montoTotalInvertidoDevsArg:2:2);
      Writeln('La cantidad total de horas trabajadas por Administradores de bases de datos es: ',cantHorasTolalAdmBd:2:2);
      Writeln('El código del proyecto con menor monto invertido: ',codProyectoMenorInversion);
      Writeln('La cantidad de Arquitectos de software de cada proyecto: ',cantArqDeSoftDcadaProy);
    End;
End.
