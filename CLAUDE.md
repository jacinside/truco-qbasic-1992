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

## Problemas conocidos
- `AIRPLANE.VOC` faltaba en CANTOS/ - se creó copia de HIGHTECH.VOC
- Subrutina MUSICA (línea 666+) usa VOICE.EXE directo para algunos sonidos (líneas 671-676), puede colgar en DOSBox. Los BAT usan SBPLAY.EXE que funciona bien.
- SOUNDFX.EXE y MUSIC.EXE también pueden colgar en DOSBox

## DOSBox
- Launcher BAT en `D:\JACBASIC\TRUCO2\TRUCO.bat`
- Comando: `"C:\Program Files (x86)\DOSBox-0.74\DOSBox.exe" -c "mount c d:\JACBASIC\TRUCO2\TRUCO2" -c "c:" -c "QBASIC /MBF /RUN TRUCO.BAS"`
