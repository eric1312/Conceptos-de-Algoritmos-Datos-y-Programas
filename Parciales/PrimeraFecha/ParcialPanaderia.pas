{Una panaderia artesanal de La Plata vende productos de elaboracion propia. La panaderia
agrupa a sus productos en 26 categorias (por ej: 1: Pan, 2:medialunas; 3: Masas finas, etc).
Para cada categoria se conoce su nombre y el precio por kilo del producto.
La panaderia DISPONE de informacion de todas las compras realizadas en el ultimo año. De cada
compra se conoce el DNI del cliente, la categoria del producto (entre 1 y 26) y la cantidad de kilos
comprados. La informacion se encuentra ordenada por DNI del cliente(no es necesario agregar un insertarOrdenado).
    A) Realizar un modulo que retorne la informacion de las categorias en una estructura 
       de datos adecuada. La informacion se lee por tecaldo sin ningun orden. De cada categoria
       se lee el nombre, el codigo (1 a 26) y el precio por kilo.
    B) Realizar un modulo que reciba informacion de todas las compras, la informacion de las
       categorias, y retorne:
        1. DNI del cliente que mas compras ha realizado.
        2. Monto total recaudado por categoria.
        3. cantidad total de compras de clientes con DNI compuesto por, al menos, 3 digitos
           pares.
           
ACLARACION: se pide tambien implementar el programa principal.}



Program Panaderia;
const 
    cantCategoria = 26;

type
    categoria = record
        nombre:string;
        precio: real;
    end;
    RangoCategorias = 1..cantCategoria;
    vectorCategorias = array [RangoCategorias] of categoria;

    compras = record
        DNICliente: integer;
        categoriaProd : RangoCategorias;
        CantKilos : integer;
    end;

    ListaCompras = ^nodo

    nodo = record
        dato: compras;
        sig: ListaCompras;
    end;

    vectorMonto = array [RangoCategorias] of real;

// programa principal
var 
    LCompras: ListaCompras;
    Vec : vectorCategorias;
    DNIMax, CantCompras: integer;
    Monto: vectorMonto;
begin
    cargarLista(LCompras); // SE DISPONE
    cargarCategorias (Vec);
    procesarCompras (LCompras, Vec, DNIMax, Monto, CantCompras);
end.

procedure InicializarVector (var Monto:vectorMonto);
var
    i:integer;
begin
    for i:= 1 to RangoCategorias do 
        Monto[i]:= 0;
end;


function TienealMenos3pares(num: integer): boolean;
var 
    cantPar, dig: integer;
begin
  cantPar := 0;
  while (num <> 0) and (cantPar < 3) do begin
    dig:= num MOD 10;
    if ((dig MOD 2) = 0) then   
        cantPar := cantPar + 1;
    num := num DIV 10;
  end;
  TienealMenos3pares := (cantPar = 3);
  {if (cantPar = 3) then 
    TienealMenos3pares := true
  else  
    TienealMenos3pares := false;}
end;

procedure actualMax (DNIActual, cantComprasActual:integer; var DNIMax, cantComprasMax: integer);
begin
    if (cantComprasActual > cantComprasMax) then begin
        cantComprasMax:= cantComprasActual;
        DNIMax := DNIActual;
    end;
end;

procedure procesarCompras (LCompras: ListaCompras; Vec:vectorCategorias; var DNIMax:integer; var Monto:vectorCategorias; var CantCompras:integer;);
var
    cantComprasMax:integer;
    DNIActual, cantComprasActual: integer;
begin
    CantCompras := 0;
    InicializarVector(Monto);
    cantComprasMax:= 0;

    while (LCompras <> nil) do begin
        DNIActual := LCompras^.dato.DNICliente;
        cantComprasActual := 0;
        while (LCompras <> nil) and (LCompras^.dato.DNICliente = DNIActual) do begin
            cantComprasActual := cantComprasActual + 1;
            Monto [LCompras^.dato.categoria] := Monto [LCompras^.dato.categoria] + (LCompras^.dato.CantKilos * Vec[LCompras^.dato.categoria].precio);
            if (TienealMenos3pares(LCompras^.dato.DNICliente)) then 
                CantCompras := CantCompras + 1;
            LCompras := LCompras^.sig;
        end;
        actualMax(DNIActual, cantComprasActual, DNIMax, cantComprasMax);
    end;
end;

// INCISO A
procedure leerCategoria (var cat:categoria; var cod: RangoCategorias);
begin  
    readln (cat.nombre);
    readln (cat.precio);
    readln (cod);
end;
//INCISO A
procedure cargarCategorias (var Vec:vectorCategorias);
var 
    i, cod:RangoCategorias;
    cat: categoria;
begin 
    for i := 1 to cantCategoria do begin
        leerCategoria(cat,cod);
        Vec[i] := cat;
    end;
end;
