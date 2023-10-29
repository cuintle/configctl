#!/usr/bin/env sh

workapps=(
  "flatpak run org.gnome.Geary &"
  "flatpak run org.qbittorrent.qBittorrent &"
  "flatpak run com.bitwarden.desktop --ozone-platform-hint=auto --enable-gpu-rasterization --enable-zero-copy --enable-features=Vulkan &"
  "flatpak run org.telegram.desktop &"
  "flatpak run com.rtosta.zapzap &"
  "flatpak run io.freetubeapp.FreeTube --ozone-platform-hint=auto --enable-gpu-rasterization --enable-zero-copy --enable-features=Vulkan &"
  "flatpak run re.sonny.Tangram &"
  "flatpak run com.raggesilver.BlackBox &"
  "flatpak run io.gitlab.librewolf-community &"
  "gnome-text-editor &"
  "exec /home/cuintle/.local/bin/distrobox enter code -- env HOME=/home/cuintle/.local/share/distrobox_homes/Code XDG_CONFIG_HOME=/home/cuintle/.local/share/distrobox_homes/Code/.config code --enable-features=Vulkan --enable-gpu-rasterization --enable-zero-copy --unity-launch"
)

parallel --progress --jobs 3 --delay 3 --timeout 120 --shuf "sh -c {}" ::: "${workapps[@]}"
