--------------------------------------
-- Con el usuario SYSTEM (Parte 1): --
--------------------------------------

--1.	Habilitar auditoría tradicional cambiando a "DB" el estado del parámetro "audit_trail".
show parameter audit_trail

alter SYSTEM set audit_trail=DB scope=spfile;

-- 2.	Reiniciar el servicio de Oracle.

shutdown immediate;

startup

show parameter audit;

--3.	Configurar monitoreo de inicios de sesión de usuarios.

audit session;

audit session by SYSTEM;

--4.	Crear usuario nuevo llamado USER_EVA4_A indicando contraseña eva1234.
alter session set "_ORACLE_SCRIPT"=true;

create user USER_EVA4_A identified by eva1234 quota unlimited on SYSTEM;

--5.	Asignar rol "dba" al usuario USER_EVA4_A.
grant dba to USER_EVA4_A;

--6.	Configurar auditoría tradicional de inicio de sesión y de creación de objetos de usuario USER_EVA4_A:
--     	•   Tablas, secuencias, triggers y procedimientos almacenados.
audit session by USER_EVA4_A;
audit create table by USER_EVA4_A;
audit create sequence by USER_EVA4_A;
audit create trigger by USER_EVA4_A;
audit create procedure by USER_EVA4_A;



--7.	Configurar auditoría tradicional de acciones DML  del usuario USER_EVA4_A:
--      •	"insert", "update" y "delete"
audit insert table by USER_EVA4_A by access;
audit update table by USER_EVA4_A by access;
audit delete table by USER_EVA4_A by access;


--------------------------------------
-- Con el usuario SYSTEM (Parte 2): --
--------------------------------------

--15.	Desactivar auditorías especificadas para el usuario USER_EVA4_A, indicadas en las instrucciones 6 y 7.
noaudit session by USER_EVA4_A;
noaudit create table by USER_EVA4_A;
noaudit create sequence by USER_EVA4_A;
noaudit create trigger by USER_EVA4_A;
noaudit insert table by USER_EVA4_A;
noaudit update table by USER_EVA4_A;
noaudit delete table by USER_EVA4_A;

--16.	Eliminar usuario creado USER_EVA4_A.
drop user USER_EVA4_A cascade;

--17.	Deshabilitar auditoría tradicional cambiando a "NONE" el estado del parámetro "audit_trail".
alter system set audit_trail=none scope=spfile;

shutdown immediate;

startup;

show parameter audit_trail;