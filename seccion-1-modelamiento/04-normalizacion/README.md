# Normalización

---

### 1. Estudiantes y Cursos
* **Violaciones**: 1FN (Cursos Inscritos multivaluado), 2FN (Nombre depende parcialmente de ID Estudiante).
* **Esquema Relacional (3FN)**:
  * **Estudiantes**: `ID Estudiante` (PK), `Nombre`
  * **Inscripciones**: `ID Estudiante` (FK), `Curso Inscrito` (PK), `Fecha Inscripcion`

### 2. Pedidos
* **Violaciones**: 1FN (Productos multivaluado), 2FN (Cliente, Precio Total y Fecha Pedido dependen parcialmente de ID Pedido).
* **Esquema Relacional (3FN)**:
  * **Pedidos**: `ID Pedido` (PK), `Cliente`, `Precio Total`, `Fecha Pedido`
  * **Detalles_Pedido**: `ID Pedido` (FK), `Producto` (PK)

### 3. Empleados y Proyectos
* **Violaciones**: 2FN (Nombre depende parcialmente de ID Empleado; Supervisor depende parcialmente de Proyecto).
* **Esquema Relacional (3FN)**:
  * **Empleados**: `ID Empleado` (PK), `Nombre`
  * **Proyectos**: `Proyecto` (PK), `Supervisor`
  * **Asignaciones**: `ID Empleado` (FK), `Proyecto` (FK), `Horas Trabajadas`, `Fecha Asignacion`

### 4. Facturas de Compras
* **Violaciones**: 1FN (Campos multivaluados en listas paralelas), 2FN (Cliente y Total Factura dependen parcialmente de ID Factura).
* **Esquema Relacional (3FN)**:
  * **Facturas**: `ID Factura` (PK), `Cliente`, `Total Factura`
  * **Detalles_Factura**: `ID Factura` (FK), `Producto` (PK), `Cantidad`, `Precio Unitario`, `Descuento`

### 5. Cursos y Estudiantes
* **Violaciones**: 1FN (Listas de cursos, profesores y notas no atómicas), 2FN (Nombre depende de ID Estudiante; Profesor depende de Curso).
* **Esquema Relacional (3FN)**:
  * **Estudiantes**: `ID Estudiante` (PK), `Nombre`
  * **Cursos**: `Curso` (PK), `Profesor`
  * **Calificaciones**: `ID Estudiante` (FK), `Curso` (FK), `Calificacion`

### 6. Compras y Proveedores
* **Violaciones**: 1FN (Productos no atómicos), 2FN (Proveedor, Fecha Compra y Total Compra dependen de ID Compra).
* **Esquema Relacional (3FN)**:
  * **Compras**: `ID Compra` (PK), `Proveedor`, `Fecha Compra`, `Total Compra`
  * **Detalles_Compra**: `ID Compra` (FK), `Producto` (PK)

### 7. Clientes y Servicios
* **Violaciones**: 1FN (Servicios multivaluados), 2FN (Nombre y detalles dependen parcialmente de ID Cliente), 3FN (Dependencia transitiva entre ID Cliente -> Tipo Servicio -> Monto).
* **Esquema Relacional (3FN)**:
  * **Clientes**: `ID Cliente` (PK), `Nombre`
  * **Suscripciones**: `ID Cliente` (PK/FK), `Tipo Servicio`, `Monto`, `Fecha Contratacion`
  * **Servicios_Contratados**: `ID Cliente` (FK), `Servicio` (PK)

### 8. Alumnos y Actividades
* **Violaciones**: 1FN (Actividades multivaluado), 2FN (Nombre depende parcialmente de ID Alumno).
* **Esquema Relacional (3FN)**:
  * **Alumnos**: `ID Alumno` (PK), `Nombre`
  * **Participaciones_Actividades**: `ID Alumno` (FK), `Actividad` (PK), `Fecha Participacion`
