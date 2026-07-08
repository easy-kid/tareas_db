# Actividad 06 — Normalizacion Avanzada

Proceso de normalizacion detallado paso a paso para los 6 ejercicios avanzados, identificando dependencias funcionales, violaciones a las formas normales y descomposicion hasta 3FN.

---

## Resolucion de Ejercicios de Normalizacion Avanzada

### 1. Citas en una Clinica Dental

* Dependencias funcionales:
  - {No. Dentista, Fecha Cita, Hora Cita} -> No. Paciente
  - No. Dentista -> Nombre Dentista
  - No. Paciente -> Nombre Paciente
  - {No. Dentista, Fecha Cita} -> No. Consultorio

* Violaciones detectadas:
  - 1FN: Cumple (todos los valores son atomicos).
  - 2FN: Violacion por dependencias parciales. Nombre Dentista depende parcialmente de la PK a traves de No. Dentista. No. Consultorio depende parcialmente a traves de {No. Dentista, Fecha Cita}.
  - 3FN: Violacion por dependencia transitiva. Nombre Paciente depende de No. Paciente, el cual depende de la PK completa.

* Descomposicion 3FN:
  - Dentistas: No. Dentista (PK), Nombre Dentista
  - Pacientes: No. Paciente (PK), Nombre Paciente
  - Consultorios_Asignados: No. Dentista (PK/FK), Fecha Cita (PK), No. Consultorio
  - Citas: No. Dentista (PK/FK), Fecha Cita (PK/FK), Hora Cita (PK), No. Paciente (FK)

---

### 2. Agencia de Personal Hotelero

* Dependencias funcionales:
  - {NIF, No. Contrato} -> Horas/Semana
  - NIF -> Nombre Empleado
  - No. Contrato -> No. Hotel, Ciudad Hotel, Categoria Hotel
  - No. Hotel -> Ciudad Hotel, Categoria Hotel

* Violaciones detectadas:
  - 1FN: Cumple.
  - 2FN: Violacion por dependencias parciales. Nombre Empleado depende de NIF. Los datos del hotel y contrato dependen de No. Contrato.
  - 3FN: Violacion por dependencia transitiva en los datos del contrato. Ciudad Hotel y Categoria Hotel dependen de No. Hotel, que a su vez depende de No. Contrato.

* Descomposicion 3FN:
  - Empleados: NIF (PK), Nombre Empleado
  - Hoteles: No. Hotel (PK), Ciudad Hotel, Categoria Hotel
  - Contratos: No. Contrato (PK), No. Hotel (FK)
  - Asignaciones: NIF (PK/FK), No. Contrato (PK/FK), Horas/Semana

---

### 3. Catalogo de Peliculas

* Dependencias funcionales:
  - {Titulo, Año} -> Duracion, Tipo, Estudio
  - Estudio -> Direccion Estudio
  - {Titulo, Año, Actor} -> Rol

* Violaciones detectadas:
  - 1FN: Cumple.
  - 2FN: Violacion por dependencias parciales. Duracion, Tipo y Estudio dependen de la PK compuesta a traves de {Titulo, Año}, sin participacion del Actor.
  - 3FN: Violacion por dependencia transitiva. Direccion Estudio depende de Estudio, que no es clave.

* Descomposicion 3FN:
  - Peliculas: Titulo (PK), Año (PK), Duracion, Tipo, Estudio (FK)
  - Estudios: Estudio (PK), Direccion Estudio
  - Reparto: Titulo (PK/FK), Año (PK/FK), Actor (PK), Rol

---

### 4. Tienda de Abarrotes — Inventario y Proveedores

* Dependencias funcionales:
  - Codigo Producto -> Producto, Departamento, Pasillo, Precio, Unidad, Proveedor, Costo, Margen
  - Departamento -> Pasillo

* Violaciones detectadas:
  - 1FN: Cumple.
  - 2FN: Cumple (la PK es simple: Codigo Producto).
  - 3FN: Violacion por dependencia transitiva. Pasillo depende del Departamento, el cual no es clave en la relacion original.

* Descomposicion 3FN:
  - Departamentos: Departamento (PK), Pasillo
  - Productos: Codigo Producto (PK), Producto, Departamento (FK), Precio, Unidad, Proveedor, Costo, Margen

---

### 5. Registro Escolar — Alumnos, Materias y Casas

* Dependencias funcionales:
  - Matricula -> Nombre Alumno, Direccion, Casa
  - Casa -> Color Casa
  - Materia -> Costo Materia, Profesor
  - Profesor -> Depto. Profesor
  - {Matricula, Materia} -> Calificacion

* Violaciones detectadas:
  - 1FN: Cumple.
  - 2FN: Violacion por dependencias parciales. Nombre Alumno, Direccion y Casa dependen de la PK compuesta solo a traves de Matricula. Costo Materia y Profesor dependen solo de Materia.
  - 3FN: Violacion por dependencias transitivas multiples. Color Casa depende de Casa, y Depto. Profesor depende de Profesor.

* Descomposicion 3FN:
  - Alumnos: Matricula (PK), Nombre Alumno, Direccion, Casa (FK)
  - Casas: Casa (PK), Color Casa
  - Materias: Materia (PK), Costo Materia, Profesor (FK)
  - Profesores: Profesor (PK), Depto. Profesor
  - Inscripciones: Matricula (PK/FK), Materia (PK/FK), Calificacion

---

### 6. Galeria de Arte — Ventas y Reventas

* Dependencias funcionales:
  - No. Cliente -> Nombre Cliente, Telefono, Direccion Cliente, Ciudad
  - No. Artista -> Nombre Artista
  - {No. Artista, Título Obra} -> Tecnica
  - {No. Cliente, No. Artista, Título Obra, Fecha Venta} -> Precio Venta

* Violaciones detectadas:
  - 1FN: Cumple.
  - 2FN: Violacion por dependencias parciales. Nombre, Telefono, Direccion Cliente y Ciudad dependen solo de No. Cliente. Nombre Artista depende solo de No. Artista. Tecnica depende solo de {No. Artista, Título Obra}.
  - 3FN: Cumple.

* Descomposicion 3FN:
  - Clientes: No. Cliente (PK), Nombre Cliente, Telefono, Direccion Cliente, Ciudad
  - Artistas: No. Artista (PK), Nombre Artista
  - Obras: No. Artista (PK/FK), Título Obra (PK), Tecnica
  - Ventas: No. Cliente (PK/FK), No. Artista (PK/FK), Título Obra (PK/FK), Fecha Venta (PK), Precio Venta
