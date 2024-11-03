{Una panaderia artesanal de La Plata vende productos de elaboracion propia. La panaderia
agrupa a sus productos en 20 categorias (por ej: 1: Pan, 2:medialunas; 3: Masas finas, etc).
Para cada categoria se conoce su nombre y el precio por kilo del producto.
La panaderia DISPONE de informacion de las categorias. 
    A) Realizar un modulo que retorne, en una estructura de datos adecauada la informacion de 
        todas las commpras efectuadas em el ultimo año. Dicha informacion se le desde teclado
        ordenada por DNI del cliente. De cada compra se lee, DNI del cliente, categoria del 
        producto (entre 1 y 20) y cnatidad de kilos comprados. La lectura finaliza cuando se ingresa 
        el dni -1(el cual no debe procesarse).
    B) Realizar un modulo que reciba la informacion de las categorias y la de todas las
        compras y retorne:
            1. DNI del cleinte que menos dinero ha gastado.
            2. cantidad de compras por categoria.
            3. cantidad total de compras de cliente con DNI compuesto por, a lo sumo, 5 
                digitos impares.
            
        
ACLARACION: se pide tambien implementar el programa principal.}



Program Panaderia;
const 
    cantCategoria = 20;

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

    vectorMonto = array [RangoCategorias] of integer;

// programa principal
var 
    LCompras: ListaCompras;
    Vec : vectorCategorias;
    DNIMax, CantCompras: integer;
    Monto: vectorMonto;
begin
    cargarLista(LCompras); 
    cargarCategorias (Vec); // SE DISPONE
    procesarCompras (LCompras, Vec, DNIMax, Monto, CantCompras);
end.

procedure leerCompra (var c: commpras);
begin
    readln (c.DNICliente);
    readln (c.categoriaProd);
    readln (c.CantKilos);
end;

procedure AgregarAdelante (var LCompras:ListaCompras, c:commpras);
var 
    aux:LCompras;
begin
    new(aux);
    aux^.dato:= c;
    aux^.dato:= LCompras;
    LCompras := aux;
end;


procedure cargarLista (var LCompras: ListaCompras);
var
    c:compras;
begin
    L:= nil;
    leerCompra(c);
    while (c.DNICliente <> -1) do begin 
        AgregarAdelante (LCompras, c);
        leerCompra(c);
    end;
end;

procedure InicializarVector (var Monto:vectorMonto);
var
    i:integer;
begin
    for i:= 1 to RangoCategorias do 
        Monto[i]:= 0;
end;


function TienealMenos3pares(num: integer): boolean;
var 
    CantImpar, dig: integer;
begin
  CantImpar := 0;
  while (num <> 0) and (CantImpar <= 5) do begin
    dig:= num MOD 10;
    if ((dig MOD 2) = 0) then   
        CantImpar := CantImpar + 1;
    num := num DIV 10;
  end;
  TienealMenos3pares := (cantPar <= 5);
  {if (cantPar = 3) then 
    TienealMenos3pares := true
  else  
    TienealMenos3pares := false;}
end;

procedure actualMax (DNIActual, GastosActual:integer; var DNIMin, gastoMin: integer);
begin
    if (GastosActual < gastoMin) then begin
        gastoMin := GastosActual;
        DNIMin := DNIActual;
    end;
end;


procedure procesarCompras (LCompras: ListaCompras; Vec:vectorCategorias; var DNIMin:integer; var Monto:vectorCategorias; var CantCompras:integer;);
var
    DNIActual:integer;
    GastosActual, gastoMin: real;
begin
    CantCompras := 0;
    InicializarVector(Monto);
    gastoMin := 9999;

    while (LCompras <> nil) do begin
        DNIActual := LCompras^.dato.DNICliente;
        GastosActual := 0;
        while (LCompras <> nil) and (LCompras^.dato.DNICliente = DNIActual) do begin
            GastosActual :=  GastosActual + (LCompras^.dato.CantKilos * vec [LCompras^.dato.categoria].precio);
            Monto [LCompras^.dato.categoria] := Monto [LCompras^.dato.categoria] + 1;
            if (TienealMenos3pares(LCompras^.dato.DNICliente)) then 
                CantCompras := CantCompras + 1;
            LCompras := LCompras^.sig;
        end;
        actualMin(DNIActual, GastosActual, DNIMin, gastoMin);
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
