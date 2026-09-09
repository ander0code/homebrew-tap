cask "dictar" do
  version "1.0.0"
  sha256 "a4a7082d0387411baa6c462e667a61fead6761b9cb1c4bd591a1e9bffc6aa2c6"

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
  # Se usa `postflight` aunque Homebrew avise de que esta anticuado: su
  # sustituto, `postflight_steps`, no permite ejecutar comandos ni conoce la
  # carpeta de aplicaciones, asi que no sirve para esto. El aviso es cosmetico.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-c", "-r", "#{appdir}/Dictar.app"],
                   sudo: false
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
