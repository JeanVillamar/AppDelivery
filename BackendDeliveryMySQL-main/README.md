# AppDelivery Backend

API REST y capa realtime del sistema AppDelivery.

## 1. Objetivo

Este modulo expone:

- Endpoints HTTP para usuarios, catalogo, direcciones, ordenes y pagos.
- Eventos Socket.IO para tracking en tiempo real.
- Integraciones con MySQL, Firebase Cloud Messaging, Mercado Pago y Google Cloud Storage.

## 2. Stack

- Node.js
- Express
- MySQL (`mysql2`)
- Passport JWT
- Socket.IO
- Multer
- Mercado Pago SDK
- Google Cloud Storage SDK

## 3. Estructura

```text
BackendDeliveryMySQL-main/
|- config/
|  |- config.js
|  |- env.js
|  |- keys.js
|  `- passport.js
|- controllers/
|- db/
|  `- db.sql
|- models/
|- routes/
|- sockets/
|- utils/
|- package.json
`- server.js
```

## 4. Requisitos

- Node.js 18+
- npm
- MySQL 8+
- Credenciales para Firebase, Mercado Pago y GCP Storage

## 5. Setup local

1. Instalar dependencias:

```bash
npm install
```

2. Crear base de datos:

```sql
CREATE DATABASE udemy_delivery;
```

3. Importar esquema:

```bash
mysql -u root -p udemy_delivery < db/db.sql
```

4. Ajustar conexion MySQL en `config/config.js`.

5. Agregar credenciales de GCP Storage:

- Archivo esperado: `serviceAccountKey.json` en la raiz de este modulo.

6. Ejecutar servidor:

```bash
node server.js
```

Servidor actual en codigo:

- Puerto: `3000`
- Host: `10.100.247.29` (ajustar para entorno local/red)

## 6. Configuracion sensible

Ubicaciones actuales de secretos/config sensible:

- `config/keys.js` (JWT secret)
- `controllers/pushNotificationsController.js` (FCM server key)
- `controllers/mercadoPagoController.js` y `server.js` (Mercado Pago access token)
- `config/config.js` (credenciales MySQL)

Recomendacion de equipo:

1. Migrar a variables de entorno.
2. Rotar credenciales expuestas.
3. Excluir secretos reales del control de versiones.

## 7. Seguridad

Autenticacion basada en Passport JWT.
Rutas privadas esperan header:

```http
Authorization: JWT <token>
```

## 8. Endpoints REST

### 8.1 Usuarios

- `GET /api/users/findDeliveryMen`
- `POST /api/users/create`
- `POST /api/users/createWithImage`
- `POST /api/users/login`
- `PUT /api/users/update`
- `PUT /api/users/updateWithoutImage`
- `PUT /api/users/updateNotificationToken`

### 8.2 Categorias

- `GET /api/categories/getAll`
- `POST /api/categories/create`

### 8.3 Productos

- `GET /api/products/findByCategory/:id_category`
- `GET /api/products/findByNameAndCategory/:id_category/:name`
- `POST /api/products/create`

### 8.4 Direcciones

- `GET /api/address/findByUser/:id_user`
- `POST /api/address/create`

### 8.5 Ordenes

- `GET /api/orders/findByStatus/:status`
- `GET /api/orders/findByDeliveryAndStatus/:id_delivery/:status`
- `GET /api/orders/findByClientAndStatus/:id_client/:status`
- `POST /api/orders/create`
- `PUT /api/orders/updateToDispatched`
- `PUT /api/orders/updateToOnTheWay`
- `PUT /api/orders/updateToDelivered`
- `PUT /api/orders/updateLatLng`

### 8.6 Pagos

- `POST /api/payments/create`

## 9. Convenciones de respuesta

Respuesta comun de exito:

```json
{
  "success": true,
  "message": "...",
  "data": {}
}
```

Respuesta comun de error:

```json
{
  "success": false,
  "message": "...",
  "error": {}
}
```

Nota: algunos endpoints retornan listas directas.

## 10. Realtime (Socket.IO)

Namespace:

- `/orders/delivery`

Eventos recibidos:

- `position` -> `{ id_order, lat, lng }`
- `delivered` -> `{ id_order }`

Eventos emitidos:

- `position/<id_order>` -> `{ id_order, lat, lng }`
- `delivered/<id_order>` -> `{ id_order }`

## 11. Modelo de datos

Tablas base definidas en `db/db.sql`:

- `users`
- `roles`
- `user_has_roles`
- `categories`
- `products`
- `address`
- `orders`
- `order_has_products`

Estados del pedido (logica actual):

```text
PAGADO -> DESPACHADO -> EN CAMINO -> ENTREGADO
```

## 12. Integraciones externas

- Firebase Cloud Messaging:
  - envio de push desde backend.
- Mercado Pago:
  - creacion de pago y persistencia de orden.
- Google Cloud Storage:
  - carga de imagenes de usuarios/productos.

## 13. Troubleshooting

### API no inicia

- Verificar conexion MySQL.
- Confirmar credenciales en `config/config.js`.
- Revisar puerto/host en `server.js`.

### Errores 401

- Confirmar envio correcto de JWT.
- Validar secreto en `config/keys.js`.

### Error en carga de imagenes

- Verificar `serviceAccountKey.json`.
- Confirmar bucket y permisos GCP.

### Notificaciones no enviadas

- Validar server key FCM.
- Revisar token de usuario en DB (`users.notification_token`).

## 14. Deuda tecnica

- Secretos hardcoded.
- Configuracion de host/puerto fija.
- Falta de scripts `start/dev` en `package.json`.
- Sin tests automatizados.

## 15. Comandos rapidos

```bash
npm install
node server.js
```

## 16. Referencias

- Doc general: [../README.md](../README.md)
- Frontend: [../flutter_delivery_mysql-master/README.md](../flutter_delivery_mysql-master/README.md)