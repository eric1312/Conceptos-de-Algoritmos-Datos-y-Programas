{La empresa de mensajeria correo Argentino de la ciudad de la Plata le enmendó de informatica
 un programa para llevar registro de las entregas de sus repartidores. La empresa tiene una lista
 fisica con 200 repartidores, de los que se conoce DNI, nombre, apellido y edad. A su vez, se dispone
 de una lista con todos los repartos realizados hasta la fecha, donde cada reparto contiene DNI del repartidor,
 fecha de entrega, nombre y apellido de la persona que lo recibe, ordenada por DNI del repartidor.

 Se solicita la sig informacion:
  1. Realizar un modulo que cargue a los empleados en una estructura de datos adecuada y la retorne.
  2. Realizar un modulo que recorra la lista de reaprtos y retorne:
     a) DNI del empleado que mas repartos realizados
     b) Cantidad de empleados con mas de 10 repartos
     c) DNI del empleado con menos repartos realizados

Finalmente, muestre en pantalla nombre y apellido del repartidor con mas repartos realizados
y el que menos repartos realizo, ademas de la cantidad de empleados con mas de 10 repartos.
}


 // escribir el paso a paso aca tambien del ejercicio 

         //La empresa tiene una lista
         //fisica con 200 repartidores, de los que se conoce DNI, nombre, apellido y edad.

         {debemos representar 200 repartidores ¿lista o arreglo? ¿de que tipo?
               Es un arreglo y de un tipo de registro

         ¿Como represento a cada repartidor?}


         {A su vez, se dispone de una lista con todos los repartos realizados hasta la fecha, 
            donde cada reparto contiene DNI del repartidor, fecha de entrega, nombre y apellido 
            de la persona que lo recibe, ordenada por DNI del repartidor (registro entrega)
            
            
            se DISPONE, dato interesante...
            
            
            nos habla de una lista, sabemos representarla ¿que tiene de interesante la misma?
                     La lista se encuentra ordenada por DNI del repartidor 
                     A su vez, es un corte de control
                     
                     
            
            
            1. Realizar un modulo que cargue a los empleados en una 
            
               estructura de datos adecuada y la retorne.
               
               
               Ya charlamos sobre esto¿se hacen una idea de como hacerlos?
                        .Es agregar elementos en un vector}



            {2. Realizar un modulo que recorra la lista de reaprtos y retorne:
                a) DNI del empleado que mas repartos realizados
                b) Cantidad de empleados con mas de 10 repartos
                c) DNI del empleado con menos repartos realizados
                
                
                debemos recorrer la lista ¿hay qye utilizar algun algoritmo que ya conozcan?
                  Con While}


            {El corte de control trabaja en grupo y siempre con el mismo numero o lo que sea, siempre va a 
            estar ordenada.}

Program Mensajeria;
const
   Max_repartidores = 200;
type
   Repartidor = record
      DNI:integer;
      nombre, apellido:string [40];
      edad:integer;
   end;
   
   vectorRepartidores = array [1..Max_repartidores] of repartidor;

   Entrega = record 
      dniRepartidor:integer;
      fechaDeEntrega:string [30];
      nombreReceptor, apellidoReceptor:string[50];
   end;

   ListaRepartos = ^Nodo;

   Nodo = record 
      dato:Entrega;
      sig: ListaRepartos;
   end;


//leer los datos del repartidro por teclado
procedure leerRepartidor (var repartidor:Repartidor);
begin
   writeln ("ingrese el nombre del repartidor:")
   readln (repartidor.nombre);

   writeln ("ingrese el apellido del repartidor:")
   readln (repartidor.apellido);

   writeln ("ingrese el DNI del repartidor:")
   readln (repartidor.dni);

   writeln ("ingrese el edad del repartidor:")
   readln (repartidor.edad);
end;


//cargando un vector 
procedure cargarVector(var vectorRepartidor:vectorRepartidores);
var  
   i:integer;
   repartidor:Repartidor;
begin
  for i := 1 to Max_repartidores do begin
      leerRepartidor(repartidor);
      vectorRepartidor[i]:=repartidor;
   end;
end;


// procedimiento de recorrer la lista
procedure recorrerLista (ListaRepartos:ListaRepartos var dniRepartidorMax, dniRepartidorMin, cantmasDiezRepartos:integer);
var 
   dniRepartidorActual, cantRepartosActual: integer;
   cantRepartosMin, cantRepartosMax: integer;

begin 
   cantRepartosMax := 0;
   cantRepartosMin := 9999;
   while (ListaRepartos <> nil) do begin
      cantRepartosActual := 0;
      dniRepartidorActual := ListaRepartos^.dato.dni;
      
      while ((ListaRepartos <> nil) and (ListaRepartos^.dato.dni = dniRepartidorActual)) dpo begin
             cantRepartosActual := cantRepartosActual + 1;
             ListaRepartos := ListaRepartos^.sig;
      end;
      
      if (cantRepartosActual > cantRepartosMax) then begin
         cantRepartosMax := cantRepartosActual;
         dniRepartidorMax := dniRepartidorActual;
      end;
      
      if (cantRepartosActual > 10) then
         cantmasDiezRepartos := cantmasDiezRepartos + 1;
      
      if (cantRepartosActual < cantRepartosMin) then begin 
         cantRepartosMin := cantRepartosActual;
         dniRepartidorMin := dniRepartidorActual;
   end;
end;

procedure encontrarRepartidorConMenosRepartos (dniRepartidorMin: integer; vectorRepartidor:vectorRepartidores);
var 
   i:integer;
   encontre:boolean;
   repartidor:Repartidor;
begin 
   i:= 1;
   encotre:=false:
   while (i < Max_repartidores) and (not encontre) do begin 
      if (vectorRepartidor[i].dni = dniRepartidorMin)then begin 
         encontre := true;
         repartidor := vectorRepartidor[i];
      end
      else
         i := i + 1;
   end;
   writeln ("El repartidor ", repartidor.nombre, repartidor.apellido, "realizo menos reparto");
end;

procedure encontrarRepartidorConMenosRepartos (dniRepartidorMax: integer; vectorRepartidor:vectorRepartidores);
var 
   i:integer;
   encontre:boolean;
   repartidor:Repartidor;
begin 
   i:= 1;
   encotre:=false:
   while (i < Max_repartidores) and (not encontre) do begin 
      if (vectorRepartidor[i].dni = dniRepartidorMax)then begin 
         encontre := true;
         repartidor := vectorRepartidor[i];
      end
      else
         i := i + 1;
   end;
   writeln ("El repartidor ", repartidor.nombre, repartidor.apellido, "realizo maximo reparto");
end;

// programa Principal 
var 
   ListaRepartos:ListaRepartos;
   vectorRepartidor:vectorRepartidores;
   dniRepartidorMin, dniRepartidorMax, cantmasDiezRepartos: integer;
begin
   cantmasDiezRepartos := 0;
   cargarLista(ListaRepartos);
   cargarVector (vectorRepartidor);
   recorrerLista (ListaRepartos, dniRepartidorMax, dniRepartidorMin, cantmasDiezRepartos);
   encontrarRepartidorConMenosRepartos(dniRepartidorMin, vectorRepartidor);
   encontrarRepartidorConMenosRepartos(dniRepartidorMax, vectorRepartidor);
   writeln ("La cantidad de repartidores con mas de 10 repartos son: ", cantmasDiezRepartos);
end.