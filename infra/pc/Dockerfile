# Ordenador de un miembro del equipo: Ubuntu con Git y cliente SSH.
# Se construye una vez por persona (USUARIO=ana, USUARIO=luis…): al entrar con
# `docker exec -it pc-<usuario> bash` el prompt dice quién eres y en qué equipo estás.
# Su carpeta personal es una carpeta del workspace (home-<usuario>/), para editarla con VS Code:
# por eso el usuario tiene el mismo UID que el del Codespace (1000).
FROM ubuntu:24.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      git openssh-client less nano acl ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && userdel -r ubuntu 2>/dev/null || true \
 && echo 'umask 022' >> /etc/bash.bashrc

ARG USUARIO
ARG UID=1000
RUN useradd -m -u "$UID" -s /bin/bash "$USUARIO"

# nano solo como editor de Git de reserva (git commit sin -m); los archivos se editan con VS Code.
ENV LANG=C.UTF-8 EDITOR=nano
USER $USUARIO
WORKDIR /home/$USUARIO
# Al arrancar:
# - En Codespaces, /workspaces tiene ACL por defecto que dejan todo lo nuevo abierto a cualquiera
#   (y SSH rechaza una clave privada así): se quitan de la carpeta personal.
# - La carpeta personal llega vacía desde el workspace: se completa con los archivos de /etc/skel.
CMD ["sh", "-c", "setfacl -R -b -k \"$HOME\" 2>/dev/null; chmod 755 \"$HOME\"; cp -rn /etc/skel/. \"$HOME\"/ && exec sleep infinity"]
