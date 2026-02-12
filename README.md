# El Truco - QBasic (1992)

Juego de Truco argentino escrito en QBasic por **Javier A. Cordero**, a los 16 años, en una PC 286 con placa Sound Blaster.

![QBasic](https://img.shields.io/badge/QBasic-MS--DOS-blue)
![Year](https://img.shields.io/badge/A%C3%B1o-1992-green)
![Platform](https://img.shields.io/badge/Platform-DOS%20%2F%20DOSBox-orange)

## Screenshots

| Pantalla de inicio | Partida en juego | Truco cantado |
|---|---|---|
| ![Intro](TRUCO2-intro.png) | ![Juego 1](TRUCO2-juego1.png) | ![Juego 2](TRUCO2-juego2.png) |

## Sobre el juego

Un juego completo de Truco argentino contra la computadora, con:

- **Inteligencia artificial** que evalua la fuerza de las cartas, decide estrategicamente cual jugar, y usa aleatoriedad para no ser predecible
- **Voces reales** grabadas con microfono y placa Sound Blaster - son las voces del autor y sus hermanos
- **Todas las jugadas**: envido, real envido, falta envido, truco, retruco, quiero vale cuatro, me voy al mazo
- **Deteccion de mentiroso**: si mientes sobre tus puntos de envido, la computadora te descubre, te insulta y te quita los puntos
- **Tabla de records** con persistencia en disco
- **Sistema de niveles** con dificultad progresiva
- **3 personajes** con voces distintas (JAC, GAC, MFC)
- **Musica de fondo** con archivos MIDI
- **Efectos de sonido** ambientales (telefono, bocina, timbre, aplausos, risas...)

## Contexto historico

Este juego fue creado alrededor de 1992 en Argentina, en una epoca sin internet, sin Stack Overflow, sin tutoriales online. La unica motivacion fue que la familia pudiera jugar y divertirse. La IA del juego implementa bluffing probabilistico, estrategia adaptativa segun el puntaje, y manejo completo de todas las reglas del truco argentino - todo escrito por un adolescente de 16 anos en QBasic.

Las voces fueron grabadas por el autor y sus hermanos usando el microfono de la placa Sound Blaster, en formato VOC de Creative Labs.

## Como jugar

### Requisitos

- [DOSBox](https://www.dosbox.com/) (recomendado) o DOSBox-X

### Ejecucion rapida

En Windows, crear un acceso directo o .bat con:

```
"C:\Program Files (x86)\DOSBox-0.74\DOSBox.exe" -c "mount c ." -c "c:" -c "QBASIC /MBF /RUN TRUCO.BAS"
```

O abrir DOSBox manualmente y escribir:

```
mount c <ruta-a-la-carpeta-del-juego>
c:
QBASIC /MBF /RUN TRUCO.BAS
```

### Controles

| Tecla | Accion |
|-------|--------|
| 1 | Tirar primera carta |
| 2 | Tirar segunda carta |
| 3 | Tirar tercera carta |
| E | Envido |
| A | Real envido |
| F | Falta envido |
| T | Truco |
| R | Quiero retruco |
| V | Quiero vale cuatro |
| Q | Quiero |
| N | No quiero |
| M | Me voy al mazo |
| ESC | Salir |
| CTRL+N | Partido nuevo |

## Estructura del proyecto

```
TRUCO.BAS       - Codigo fuente principal (~790 lineas de QBasic)
TRUCO.BAR       - Version anterior del codigo (backup)
CANTOS/         - Archivos de voz (.VOC) grabados por la familia
*.BAT           - Scripts para reproducir sonidos via SBPLAY
*.MID / *.CMF   - Musica de fondo
QBASIC.EXE      - Interprete QBasic de MS-DOS
SBPLAY.EXE      - Reproductor de audio Sound Blaster
LISTA           - Tabla de records (top 10)
```

## Aspectos tecnicos destacados

- **Jerarquia de cartas**: Implementacion correcta de la valoracion del truco argentino (1 espada > 1 basto > 7 espada > 7 oro > 3 > 2 > 12 > 11 > 7 > 6 > 5 > 4)
- **Calculo de envido**: Manejo de todos los casos (dos del mismo palo, tres del mismo palo, carta suelta)
- **IA con estrategia**: La computadora ordena sus cartas de mayor a menor, decide cual jugar segun la situacion, y varia su agresividad con el puntaje
- **Bluffing**: La IA decide probabilisticamente si cantar envido, subir la apuesta, o irse al mazo, con umbrales que cambian segun el contexto

## Licencia

MIT License - Copyright (c) 1992 Javier A. Cordero. Ver [LICENSE](LICENSE).
