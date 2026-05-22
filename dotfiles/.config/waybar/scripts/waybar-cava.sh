#!/bin/bash

# Crear configuración temporal para cava
CONFIG_FILE="/tmp/cava_config_waybar"
cat > "$CONFIG_FILE" <<EOF
[general]
bars = 10
sleep_timer = 0

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Ejecutar cava y transformar la salida en barras de texto
cava -p "$CONFIG_FILE" | while read -r line; do
    echo "$line" | sed 's/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
done
