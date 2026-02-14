# Truco QBasic (1992)

## Directorios - IMPORTANTE
Este proyecto tiene DOS copias de los archivos fuente:

- **Repo Git (WSL):** `/home/javier/truco-qbasic-1992/`
- **Originales (Windows D:):** `/mnt/d/JACBASIC/TRUCO2/TRUCO2/`

DOSBox ejecuta el juego desde `D:\JACBASIC\TRUCO2\TRUCO2\`.
**Al editar código, SIEMPRE aplicar los cambios en ambas ubicaciones.**
Si solo se edita la copia WSL, DOSBox no verá los cambios.

## Archivos clave
- `TRUCO.BAS` - Código fuente principal (~790 líneas)
- `TRUCO.BAR` - Versión anterior (backup, usa VOICE.EXE en vez de SBPLAY)
- `CANTOS/` - Archivos VOC de voz grabados por Javier y sus hermanos
- `*.BAT` - Scripts de reproducción de sonido usando SBPLAY.EXE
- `LISTA` - Tabla de puntajes altos
- `HACER.BAT` - Launcher original (referencia C:\MOUSE\MOUSE.COM, no usar)
- `*.CMF`, `*.MID` - Música (entre manos, victoria)

## Personajes/Voces
- JAC, GAC, MFC - iniciales de Javier y sus hermanos
- `clave$` (0, 1, 2) selecciona set de voces
- ~40 archivos VOC con 3 variantes cada uno

## Lógica del juego
- Jerarquía: 1esp(13) > 1bas(12) > 7esp(11) > 7oro(10) > 3(9) > 2(8) > 12(6) > 11(5) > 7(4) > 6(3) > 5(2) > 4(1)
- Cálculo de envido en GOSUB 500
- Valuación de cartas en GOSUB 640
- IA con bluff probabilístico, adaptativa al puntaje
- Cheat code: CTRL+C habilita CAON (ver cartas rival) y CATR (auto-ganar)
- Modo attract: muestra high scores tras idle

## Versión web (js-dos + GitHub Pages)
- URL: https://jacinside.github.io/truco-qbasic-1992/
- Usa **js-dos v8.3.20** (pinned via jsDelivr CDN) con `kiosk: true`
- Archivos en `docs/`: `index.html` + `truco.jsdos` (bundle ZIP)
- El bundle se construye desde `/tmp/truco-jsdos/` con todos los archivos del juego + `.jsdos/dosbox.conf`

### Bundle .jsdos
- Es un ZIP que contiene: QBASIC.EXE, TRUCO.BAS, SBPLAY.EXE, VOICE.EXE, MUSIC.EXE, SOUNDFX.EXE, CT-VOICE.DRV, CANTOS/*.VOC, *.BAT, *.MID, *.CMF, LISTA, `.jsdos/dosbox.conf`
- Config DOSBox del bundle: sbtype=sb1, memsize=16, core=normal, cycles=3000, MIXER SB 25
- Para rebuildar: copiar archivos a `/tmp/truco-jsdos/`, crear ZIP con Python

### Cambios en TRUCO.BAS para versión web
- MUSICA: protegida con TIMER STOP/TIMER ON alrededor de SHELL para evitar colisiones que crashean WASM
- MUSICA: removidos AIRPLANE.VOC y HIGHTECH.VOC (110KB c/u, causaban crashes)
- MUSICA: solo 6 sonidos pequeños (TELE, CAR, DOORBELL, TOILET, BUBBLES, SPLASH)
- Todos los ON TIMER cambiados a 15 segundos
- Input: agregado UCASE$ en 9 puntos de entrada + filtro LEN(X$)>1
- VOICE.EXE reemplazado por SBPLAY en MUSICA

### Audio mobile
- Monkey-patch de AudioContext **antes** de cargar js-dos, pasando `options` al constructor real (crítico: sampleRate, latencyHint)
- Captura de CommandInterface via `onEvent: "ci-ready"` para llamar `unmute()` al volver de foco
- Listener `statechange` en cada AudioContext para auto-resume desde estado "interrupted" (iOS Safari)
- Resume en cada interacción del usuario (touchstart, touchend, click, pointerdown), no solo la primera
- Listeners en visibilitychange + focus + pageshow

### Gamepad on-screen (mobile)
- Botones numéricos 0-9 (2 filas de 5) para cartas y puntos de envido
- Botones de cantos: E/A/F/T/R/V/Q/N/M + ENTER + ESC
- Envía KeyboardEvent al document vía `sendKey()`

### Problemas resueltos
- **WASM crash "RuntimeError: unreachable"**: causado por SHELL concurrentes (MUSICA timer + juego). Fix: TIMER STOP/ON + remover VOCs grandes
- **Audio roto con monkey-patch pre-carga**: no se pasaban `options` al constructor. Fix: `new RealAC(options)`
- **Audio pierde en mobile al cambiar foco**: AudioContext queda suspended/interrupted. Fix: solución combinada (monkey-patch + CI unmute + statechange + multi-evento resume)
- **Sidebar js-dos**: kiosk:true la oculta. CSS agresivo rompe audio, no usar
- **Cache del bundle**: usar ?v=N en la URL del .jsdos para cache busting

### Lo que NO funciona / no intentar
- **js-dos v6.22**: extract_zip buggy (exit() en C), syncSleep/Asyncify crashea al apretar teclas
- **js-dos v7**: keyboard focus lost tras tab switch, doRewind crashea
- **backend "dosboxX"**: no funciona con js-dos v8
- **CSS `display:none` en sidebar**: mata el audio
- **AIRPLANE.VOC / HIGHTECH.VOC en MUSICA**: 110KB crashean WASM

## Problemas conocidos
- `AIRPLANE.VOC` faltaba en CANTOS/ - se creó copia de HIGHTECH.VOC
- Subrutina MUSICA (línea 666+) usa VOICE.EXE directo para algunos sonidos (líneas 671-676), puede colgar en DOSBox. Los BAT usan SBPLAY.EXE que funciona bien.
- SOUNDFX.EXE y MUSIC.EXE también pueden colgar en DOSBox

## DOSBox (local)
- Launcher BAT en `D:\JACBASIC\TRUCO2\TRUCO.bat`
- Comando: `"C:\Program Files (x86)\DOSBox-0.74\DOSBox.exe" -c "mount c d:\JACBASIC\TRUCO2\TRUCO2" -c "c:" -c "QBASIC /MBF /RUN TRUCO.BAS"`
