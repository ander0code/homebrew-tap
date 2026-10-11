cask "dictar" do
  version "1.5.0"
  sha256 "07b954c09277b68e43a8032729656d5a0e96032984dd59fa3e42e6d237235158"

  url "https://github.com/ander0code/homebrew-tap/releases/download/dictar-v#{version}/Dictar.dmg"
  name "Dictar"
  desc "Dictado por voz en local, sin subir nada a ningun servidor"
  homepage "https://github.com/ander0code/homebrew-tap"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Dictar.app"

  # macOS marca todo lo que llega de internet y bloquea lo que no esta
  # registrado en Apple. En las versiones nuevas ese bloqueo ni siquiera se
  # salta con clic derecho: hay que ir a Ajustes a mano. Quitando la marca
  # despues de instalar, la app abre sin mas.
  #
  # Con `postflight_steps`, que es lo que Homebrew pide ahora. La ruta va con
  # llaves dobles porque estas cadenas las resuelve Homebrew al instalar, no
  # Ruby al leer el archivo. Y no se exige que salga bien: si algun dia xattr
  # no encuentra nada que quitar, la instalacion no tiene por que fallar.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-c", "-r", "{{appdir}}/Dictar.app"],
        writable_paths: ["{{appdir}}/Dictar.app"],
        must_succeed:   false
  end

  zap trash: [
    "~/.cache/whisper-cpp",
    "~/Library/Preferences/pe.ttito.dictar.plist",
  ]

  caveats <<~TEXTO
    Dictar vive en la barra de menus, junto al reloj.

    La primera vez te pedira dos permisos:

      1. Microfono, desde el propio panel de la app.
      2. Accesibilidad, en Ajustes del sistema, Privacidad y seguridad.
         Despues de darlo pulsa Reiniciar en el menu de la barra: macOS
         solo lo aplica cuando el programa arranca.

    Y un modelo de voz de 466 MB que se baja desde el panel, una sola vez.

    En el menu hay un interruptor con dos modos. Individual graba solo tu voz
    y escribe donde tengas el cursor. Reunion graba ademas lo que suena en el
    Mac, o sea la otra persona de una llamada, y escribe el texto donde tengas
    el cursor, ademas de guardarlo en la ventana con cada linea marcada como
    Tu o Ellos.

    Para reunion macOS pedira un permiso mas, el de grabar el audio del Mac.
    Con auriculares sale mejor: con altavoces tu microfono oye tambien a la
    otra persona.

    El primer dictado tarda unos 20 segundos preparando la tarjeta grafica.
    Despues responde en menos de medio segundo.

    Como se usa: manten Control y habla, o pulsa fn+Espacio para empezar y
    otra vez para terminar. Escape corta siempre.

    El microfono se elige en el menu. En automatico usa el del sistema, pero
    nunca los virtuales de Zoom o Teams. Si algo deja de responder, el boton
    Reiniciar del menu lo arregla, y la app tambien se reinicia sola cuando
    detecta un fallo.
  TEXTO
end
