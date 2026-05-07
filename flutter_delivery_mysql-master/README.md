# AppDelivery Frontend (Flutter)

Cliente movil Flutter para AppDelivery.

## 1. Objetivo

Este modulo implementa la experiencia de usuario de la plataforma:

- Login y registro.
- Seleccion de rol.
- Catalogo y carrito/pedido.
- Pago.
- Tracking en mapa.
- Flujos operativos para cliente, restaurante y repartidor.

## 2. Stack

- Flutter + Dart
- GetX
- GetStorage
- HTTP / GetConnect
- Socket.IO client
- Google Maps (`google_maps_flutter`)
- Geolocalizacion (`geolocator`, `geocoding`, `location`)
- Firebase (`firebase_core`, `firebase_messaging`)
- `flutter_local_notifications`
- `flutter_credit_card`

## 3. Estructura

```text
flutter_delivery_mysql-master/
|- lib/
|  |- main.dart
|  `- src/
|     |- environment/
|     |- models/
|     |- pages/
|     |- providers/
|     |- utils/
|     `- widgets/
|- android/
|- ios/
|- web/
|- pubspec.yaml
`- README.md
```

## 4. Requisitos

- Flutter 3.x
- Dart 3.x
- Android SDK
- Java 17
- Proyecto Firebase configurado
- API Key de Google Maps
- Backend AppDelivery operativo

## 5. Setup local

1. Instalar dependencias:

```bash
flutter pub get
```

2. Configurar variables en:

- `lib/src/environment/environment.dart`

3. Verificar archivos Firebase:

- `android/app/google-services.json`
- `lib/src/utils/firebase_config.dart`

4. Ejecutar app:

```bash
flutter run
```

## 6. Configuracion (`environment.dart`)

Campos clave:

- `API_URL`: URL base del backend (ejemplo: `http://<ip>:3000/`).
- `API_URL_OLD`: host:puerto usado por endpoints multipart.
- `API_KEY_MAPS`: clave de Google Maps.
- `ACCESS_TOKEN`: token de Mercado Pago.
- `PUBLIC_KEY`: clave publica de Mercado Pago.

Nota:

- Si pruebas en emulador/dispositivo fisico, confirmar que la IP del backend sea accesible desde la red del dispositivo.

## 7. Navegacion y roles

Routing principal definido en `lib/main.dart` con GetX.

Rutas base por rol:

- Cliente: `/client/...`
- Restaurante: `/restaurant/...`
- Repartidor: `/delivery/...`

Ruta inicial actual:

- Si hay sesion: decide entre `/roles` o `/client/home` segun cantidad de roles.
- Sin sesion: `/` (login).

## 8. Providers y contratos

Providers clave:

- `users_provider.dart`
- `categories_provider.dart`
- `products_provider.dart`
- `address_provider.dart`
- `orders_provider.dart`
- `mercado_pago_provider.dart`
- `push_notifications_provider.dart`

Convencion de autenticacion:

- Header esperado en rutas privadas:

```http
Authorization: JWT <token>
```

Socket realtime (tracking):

- Namespace backend: `/orders/delivery`
- Eventos consumidos/emitidos para posicion y entrega por `id_order`.

## 9. Flujos funcionales

### Cliente

1. Login/registro.
2. Seleccion de productos.
3. Gestion de direccion.
4. Pago.
5. Seguimiento de orden en mapa.

### Restaurante

1. Gestion de categorias/productos.
2. Visualizacion de ordenes pendientes.
3. Asignacion de repartidor.

### Repartidor

1. Recepcion de orden asignada.
2. Cambio de estado (`EN CAMINO`).
3. Envio de posicion en tiempo real.
4. Confirmacion de entrega.

## 10. Integraciones externas

- Google Maps: mapa, marcadores, rutas.
- Firebase Messaging: push y notificaciones locales.
- Mercado Pago: tokenizacion de tarjeta, cuotas y pago.

## 11. Testing y validacion

Estado actual:

- No hay suite funcional automatizada completa.

Pruebas recomendadas antes de merge:

1. Login correcto y fallido.
2. Navegacion por roles.
3. Flujo de pedido y pago en sandbox.
4. Tracking en mapa con actualizacion de estado.
5. Recepcion de notificaciones push.

Comando base de tests:

```bash
flutter test
```

## 12. Troubleshooting

### App no conecta al backend

- Revisar `API_URL` y `API_URL_OLD`.
- Validar que backend este corriendo y accesible por red.

### Error de Firebase

- Verificar `google-services.json`.
- Revisar valores en `firebase_config.dart`.

### Error en Maps

- Confirmar `API_KEY_MAPS` activa y con APIs habilitadas.

### Build falla

```bash
flutter clean
flutter pub get
flutter run
```

## 13. Deuda tecnica

- Variables sensibles en archivo fuente.
- Dependencia de IP fija para backend.
- Falta de pruebas automatizadas de regresion.

## 14. Referencias

- Doc general: [../README.md](../README.md)
- Backend: [../BackendDeliveryMySQL-main/README.md](../BackendDeliveryMySQL-main/README.md)
