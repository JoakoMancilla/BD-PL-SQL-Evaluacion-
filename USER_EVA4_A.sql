---------------------------
-- Con el usuario CREADO --
---------------------------

--8.	Crear tablas del modelo relacional utilizando constraint.
create table arreglos_florales(
    id_arr number constraint pk_arr primary key,
    nom_arr Varchar(20),
    pre_arr number
);

create table detalles_compras(
id_det number constraint pk_det primary key,
pre_det number,
can_det number,
net_det number,
des_det number,
tot_det number,
id_arr constraint fk_id_arr references arreglos_florales(id_arr)
);

create table historial(
    id_his number constraint pk_his primary key,
    des_his Varchar2(100),
    usu_his Varchar2(100),
    fec_his date
);


--9.	Crear índices para campos FK de tablas del modelo relacional.
create index FK_ARR on detalles_compras(id_arr);

--10.	Crear secuencias para determinar los valores auto-incrementales de campos PK de las tablas del modelo:
--      ("SEC_ARR" y "SEC_DET" respectivamente). Las secuencias deben ser implementadas en los Triggers y en los Procedimientos Almacenados, según corresponda.
create sequence SEC_ARR start with 1 increment by 1 nomaxvalue;
create sequence SEC_DET start with 1 increment by 1 nomaxvalue;
create sequence SEC_HIS start with 1 increment by 1 nomaxvalue;

--11.	Crear Triggers para insertar datos en tabla Historial, que se ejecuten al insertar, modificar y eliminar datos: 
--      •	("Trig_Insertar_Arreglos",	"Trig_Insertar_Detalles").
--      •	("Trig_Modficicar_Arreglos",	"Trig_Modificar_Detalles").
--      •	("Trig_Eliminar_Arreglos",	"Trig_Eliminar_Detalles").

--Trigger Tabla Arreglos
create or replace trigger Trig_Insertar_Arreglos
after insert on arreglos_florales
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro AGREGADO En La Tabla Arreglos Florales',USER,SYSDATE);
end;

create or replace trigger Trig_Modficicar_Arreglos
after update on arreglos_florales
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro ACTUALIZADO En La Tabla Arreglos Florales',USER,SYSDATE);
end;

create or replace trigger Trig_Eliminar_Arreglos
after delete on arreglos_florales
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro ELIMINADO En La Tabla Arreglos Florales',USER,SYSDATE);
end;

--Trigger Tabla Detalles Compra
create or replace trigger Trig_Insertar_Detalles
after insert on detalles_compras
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro AGREGADO En La Tabla Detalles de Compra',USER,SYSDATE);
end;

create or replace trigger Trig_Modificar_Detalles
after update on detalles_compras
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro ACTUALIZADO En La Tabla Detalles de Compra',USER,SYSDATE);
end;

create or replace trigger Trig_Eliminar_Detalles
after delete on detalles_compras
begin
insert into historial (id_his, des_his, usu_his, fec_his) values
(SEC_HIS.nextVal,'Registro ELIMINADO En La Tabla Detalles de Compra',USER,SYSDATE);
end;

--12.	Crear Procedimientos Almacenados para insertar datos en las tablas del modelo relacional: 
create or replace procedure PA_Insertar_Arreglos(nom Varchar2, precio number)
as begin
    insert into arreglos_florales values (SEC_ARR.nextVal, nom, precio);
end;

create or replace procedure PA_Insertar_Detalles(arr number, precio number, can number, net number, descu number, tot number)
as begin
    insert into detalles_compras values (SEC_DET.nextVal, arr, precio, can, net, descu, tot);
end;

--13.	Ejecutar los Procedimientos Almacenados creados para insertar todos los datos en las tablas.
execute PA_Insertar_Arreglos ('CUADRO FLORAL', 49990);
execute PA_Insertar_Arreglos ('CORONA CIRCULAR',34990);
execute PA_Insertar_Arreglos ('RAMO DE ROSAS',24990);
execute PA_Insertar_Arreglos ('RAMO SIMPLE',4500);
execute PA_Insertar_Arreglos ('CAJA CON ROSAS',19990);
execute PA_Insertar_Arreglos ('ARREGLO CUMPLEAÑERO',14990);
execute PA_Insertar_Arreglos ('BANDA PERSONALIZADA',4990);
execute PA_Insertar_Arreglos ('RAMO CIRCULAR',44900);
execute PA_Insertar_Arreglos ('RAMO DE GRADUACION',44990);
execute PA_Insertar_Arreglos ('RAMO EXTENDIDO',74500);

execute PA_Insertar_Detalles(49999,5,249950,62488,187463,1);
execute PA_Insertar_Detalles(34990,1,34990,null,34990,2);
execute PA_Insertar_Detalles(19990,3,59970,null ,59970,5);
execute PA_Insertar_Detalles(49999,6,299940,74985,224955,1);
execute PA_Insertar_Detalles(4500,2,49980,null,49980,1);
execute PA_Insertar_Detalles(49999,5,22500,5625,16875,3);
execute PA_Insertar_Detalles(4990,7,34930,8733,26198,4);
execute PA_Insertar_Detalles(74500,4,29800,null ,298000,7);
execute PA_Insertar_Detalles(44990,3,44970,null,44970,10);
execute PA_Insertar_Detalles(4990,5,24950,6238,18713,6);
execute PA_Insertar_Detalles(4500,3,74970,null,74970,7);
execute PA_Insertar_Detalles(49999,6,27000,6750,20250,3);
execute PA_Insertar_Detalles(44900,10,449000,112250,336750,4);
execute PA_Insertar_Detalles(44990,4,179960,null,179960,8);
execute PA_Insertar_Detalles(49999,5,249950,62488,187463,9);
execute PA_Insertar_Detalles(49999,7,31500,7875,23625,1);
execute PA_Insertar_Detalles(74500,8,596000,149000,447000,4);
execute PA_Insertar_Detalles(44990,9,404910,101228,303683,9);

--14.	Crear una función que permita determinar si se encuentra o no un Arreglo Floral a partir de su ID,
--      presentando su ID, nombre y precio con el siguiente formato: "ID := (NOMBRE DE ARREGLO $PRECIO)".

create or replace function COMPROBAR_ARREGLO(id_buscado number)
return Varchar2
is
x number;
arr Varchar2(40);
precio number;
resultado varchar2(100);
begin
select COUNT(*) into x from arreglos_florales where id_arr=id_buscado;
if x=1 then
    select nom_arr, pre_arr into arr, precio from arreglos_florales where id_arr = id_buscado;
    resultado := 'Producto Encontrado! - ID: ' || id_buscado || ' - Nombre: ' || arr || ' - Precio: ' || precio;
else
    resultado := 'Producto NO Encontrado : ' || id_buscado;
end if;
return resultado;
Exception When No_Data_Found Then Return 'Error';
end;

select COMPROBAR_ARREGLO(1) from dual;
select COMPROBAR_ARREGLO(3) from dual;
select COMPROBAR_ARREGLO(10) from dual;
select COMPROBAR_ARREGLO(20) from dual;