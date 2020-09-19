Cosas que se deben tomar en cuenta a la hora de correr el proyecto2:

- Debe poseerse la version de MARS facilitada por el profesor
  (Puesto que es la version que tiene implementada el timer)

- Por motivos esteticos decidimos que las manzanas seran
  representadas por el simbolo "@" (@pple) en vez de "$"

- Se debe jugar con la pantalla y teclado proveidos en la opcion:
  Tools > Keyboard and Display MMIO Simulator.

- Se Debe cambiar el font a Liberation Mono (pues otro tipo de font
  se comporta de manera extrana con la pantalla), se recomienda
  ademas usar un tamano de letra superior a 13, y clickear la opcion de
  bold text para una mejor impresion.

- Aunque los valores de la forma del mapa (anchura y altura) se
  pueden modificar directamente en el archivo Glob_vars.asm
  si se corre el programa con los valores originales se recomienda
  usar un tamano de pantalla de 117x28.

- Se recomienda usar un Delay length de 5 instrucciones en el
  Keyboard and Display MMIO.

- El juego se puede correr con cualquier programa de fondo,
  nuestro programa recomendado es: inf.asm, el cual
  posee solamente un bucle infinito.

- Recordar que se deben seleccionar el archivo de excepciones
  (Settings > Exception Handler ) y se debe seleccionar
  el archivo de excepciones dentro de la carpeta del proyecto2
  (myexceptions.s)

- Es fuertemente recomendado colocar el Run speed de MIPS en
  maximo (no interaction), pues los valores de velocidad
  se ajustaron para trabajar mejor con esa opcion.

- Recordar que se puede cambiar los valores del juego
  modificando el archivo Glob_vars.asm

- Note que debido a la simplicidad del juego, el
  refrescamiento se toma como la velocidad de la
  serpiente (pues es la variable que determina el
  cada cuanto cambia la pantalla).

- Actualmente el juego empieza en el nivel clasico
 (sin paredes internas ni pasadizos), y despues de
 una cierta cantidad de manzanas pasa al siguiente
 nivel.

- En vez de tener un conjunto de niveles finitos,
  decidimos generar las "paredes" (obstaculos) y
  pasadizos internos de manera pseudo aleatoria
  para asi tener niveles infinitos.
