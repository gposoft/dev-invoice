# Aplicación de conocimientos

## Formula

<p align="center">
  <a href="#" target="blank"><img src="./documents/images/formula.png" width="600" alt="Nest Logo" /></a>
</p>

## Cliente

<p align="center">
  <a href="#" target="blank"><img src="./documents/images/cliente.png" width="400" alt="Nest Logo" /></a>
</p>

- Operaciones

  - create
  - update
  - getByCode

- Validación

  - Que no exista código repetido

- Observaciones
  - Id autogenerada
  - código único en base de datos

### Create

```ts
//ejemplo
const client = {
  code: "200",
  first_name: "Lopez",
  second_name: "Martinez",
  name: "Mariana",
};
```

```sql

  const input = {
    register: client,
  }

  -- Instrucción SQL
  SELECT providers.client_create($1);

  -- Retorno: Array de objeto de tipo client
```

### Update

```ts
//ejemplo
const client = {
  code: "200",
  first_name: "Lopez",
  second_name: "Martinez",
  name: "Mariana",
};
```

```sql

  const id = client.id

  const input = {
    register: client,
  }

  -- Instrucción SQL
  SELECT providers.client_update($1, $2);

  -- Retorno: Array de objeto de tipo client
```

### GetByCode

```sql

  const code = client.code

  -- Instrucción SQL
  SELECT * from providers.client_get_by_code($1);

  -- Retorno: Array objeto de tipo client
```

## Factura

<p align="center">
  <a href="#" target="blank"><img src="./documents/images/factura.png" width="600" alt="Nest Logo" /></a>
</p>

- Operaciones

  - create
  - update
  - getById
  - getAll
  - updateStateByID

- Validaciones

  - Validar que el folio no exista
  - El registro de la factura debe cuadrar con el total de la factura impresa (simulación) es decir debe recibir como parámetro el total impreso.
  - Solo puede existir diferencia a nivel de decimales.

- Observaciones
  - Aplicar la estrategia de ajuste de decimales solo si existe diferencia
  - getAll se debe especificar que estado de los datos requiero (all, active, delete)

### Create

```ts
//ejemplo
const invoice = {
  id: "1",
  state: "active",
  folio: "F200",
  date: "2024-03-14",
  client_code: "200",
  concept: "Mi primera factura...!",
  details: [
    { cant: 10, concept: "concepto 1", amount: 100.8 },
    { cant: 1, concept: "concepto 2", amount: 1000.5 },
  ],
};
```

```sql
  const input = {
    register: invoice,
  }

  -- Instrucción SQL
  SELECT providers.invoice_create($1);

  -- Retorno: Array objeto de tipo  invoice
```

### Update

```ts
//ejemplo
const invoice = {
  id: "1",
  state: "active",
  folio: "F200",
  date: "2024-03-14",
  client_code: "200",
  concept: "Mi primera factura...!",
  details: [
    { cant: 10, concept: "concepto 1", amount: 100.8 },
    { cant: 1, concept: "concepto 2", amount: 1000.5 },
  ],
};
```

```sql

  const id = invoice.id

  const input = {
    register: invoice
  }

  -- Instrucción SQL
  SELECT providers.invoice_update($1, $2);

  -- Retorno: Array objeto de tipo invoice
```

### GetById

```sql

  const id = invoice.id

  -- Instrucción SQL
  SELECT providers.invoice_get_by_id($1);

  -- Retorno: Array objeto de tipo invoice
```

### GetByAll

```sql

  const state = "all" | "active" | "delete"

  -- Instrucción SQL
  SELECT providers.invoice_get_by_all($1);

  -- Retorno: Array objeto de tipo invoice
```

### UpdateStateById

```sql

  const id = invoice.id
  const state = "all" | "active" | "delete"

  -- Instrucción SQL
  SELECT providers.invoice_update_state_by_id($1, $2);

  -- Retorno: 1 : actualizo, 0 : no actualizo
```

## Arquitectura

<p align="center">
  <a href="#" target="blank"><img src="./documents/images/arquitectura.png" width="200" alt="Nest Logo" /></a>
</p>

## Planificación

- Aplicar principios SOLID

- Se debe aplicar arquitectura

- Aplicar los test unitarios correspondientes
  - system/tools/...
  - modules/cliente/...
  - modules/factura/...

## Clonación

[Repositorio - https://github.com/gposoft/dev-invoice](https://github.com/gposoft/dev-invoice)

```bash
  git clone https://github.com/gposoft/dev-invoice.git

  # entrar a la carpeta
  cd dev-invoice

  #Crear la rama para no afectar la rama principal

  #Developer 1
  git checkout -b feature/dev-1-practice

  #Developer 2
  git checkout -b feature/dev-2-practice
```

## Upload changes

```bash

  git add .
  git commit -m "mensaje del commit"
  git push origin feature/dev-1-practice

```

## Update Remote -> Local (Solo en caso que requieras actualizar lo ultimo del repositorio)

`Nota:` se debe tener cuidado ya que pudiera remplazar tus archivos, para evitar eso se debe revisar bien los cambios antes de actualizar 

```bash
  git branch
  git checkout main
  git pull origin main
  git checkout feature/dev-3-practice
  git merge main / git rebase main

```

Para poder correr el proyecto se debe hacer primero la instalación de los paquetes

```bash
  npm install
```

# Restaurar base de datos 

<video controls width="900">
    <source src="./documents/videos/respaldo.mp4" type="video/mp4">
    Tu navegador no soporta la reproducción de videos.
</video>

