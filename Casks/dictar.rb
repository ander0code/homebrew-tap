cask "dictar" do
  version "1.0.3"
  sha256 "ee979ef953019663db9bc6ac61bc26c4cba7a110a13525ef8c08273906df4fcb"

  url "https://github.com/ander0code/homebrew-tap/releases/download/dictar-v#{version}/Dictar.dmg"
  name "Dictar"
  desc "Dictado por voz en local, sin subir nada a ningun servidor"
  homepage "https://github.com/ander0code/homebrew-tap"

  depends_on macos: :sonoma
  depends_on arch: :arm64

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

  caveats <<~TEXTO
    Dictar vive en la barra de menus, junto al reloj.

    La primera vez te pedira dos permisos:

      1. Microfono, desde el propio panel de la app.
      2. Accesibilidad, en Ajustes del sistema, Privacidad y seguridad.
         Despues de darlo hay que CERRAR Y ABRIR la app: macOS solo lo
         aplica cuando el programa arranca.

    Y un modelo de voz de 466 MB que se baja desde el panel, una sola vez.

    El primer dictado tarda unos 20 segundos preparando la tarjeta grafica.
    Despues responde en menos de medio segundo.

    Como se usa: manten Control y habla, o pulsa fn+Espacio para empezar y
    otra vez para terminar. Escape corta siempre.
  TEXTO

  zap trash: [
    "~/Library/Preferences/pe.ttito.dictar.plist",
    "~/.cache/whisper-cpp",
  ]
end
