#!/bin/bash
# Matar instancias existentes de forma silenciosa
pkill -x waybar

# Esperar un segundo para asegurar que se cerró
sleep 0.5

# Lanzar waybar
waybar &
