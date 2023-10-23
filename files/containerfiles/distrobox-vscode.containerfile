FROM registry.fedoraproject.org/fedora-minimal:latest

ENV SUMMARY="Visual Studio Code distrobox/toolbox image" \
    DESCRIPTION="Visual Studio Code is a lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux."

ENV NAME=distrobox-vscode \
    VERSION=1 \
    FEDORA_VERSION=38 \
    RELEASE=1 \
    ARCH=x86_64

LABEL summary="$SUMMARY" \
      io.github.containers.toolbox="true" \
      description="$DESCRIPTION" \
      name="$NAME-$FEDORA_VERSION-$RELEASE" \
      version="$VERSION" \
      usage="distrobox create --image cuintle/distrobox-visualvscodium-studio-code --name code --home path-to-custom-home && distrobox enter code" \
      maintainer="Cuintle <cuintle@duck.com>"


RUN echo "fastestmirror=1" >>  /etc/dnf/dnf.conf \
    && echo "install_weak_deps=0" >>  /etc/dnf/dnf.conf \
    && echo "max_parallel_downloads=6" >>  /etc/dnf/dnf.conf \
    && sed -i '/enabled/s/enabled=1/enabled=0/' /etc/yum.repos.d/fedora-cisco-openh264.repo \
    && sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-updates-testing.repo \
    && rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg \
    && printf "[codium_repo]\nname=Codium\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscodium.repo \
    && rpm --import https://packages.microsoft.com/keys/microsoft.asc \
    && sh -c 'echo -e "[code_repo]\nname=VS Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
    && microdnf install --assumeyes --nodocs \
    sudo \
    bc \
    curl \
    diffutils \
    findutils \
    less \
    ncurses \
    passwd \
    pinentry \
    procps-ng \
    shadow-utils \
    util-linux \
    wget \
    vte-profile \
    libxkbfile \
    xdg-utils \
    cairo \
    cairo-gobject \
    desktop-file-utils \
    git-core \
    gtk3 \
    harfbuzz \
    libicu \
    pango \
    perl-libs \
    python3-libs \
    systemd \
    libX11-xcb \
    mesa-dri-drivers \
    vulkan-loader \
    mesa-vulkan-drivers \
    nss \
    libwayland-server \
    libdrm \
    code

RUN groupadd --gid 1000 vscode_group \
    && useradd --uid 1000 --gid 1000 -m vscode_user 

RUN microdnf clean all

USER vscode_user

ENTRYPOINT ["/usr/bin/bash"]
CMD ["code"]

