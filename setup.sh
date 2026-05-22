#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Iniciando la personalización de CachyOS...${NC}"

# 1. Verificar si paru está instalado (CachyOS lo trae por defecto)
if ! command -v paru &> /dev/null; then
    echo -e "${GREEN}Instalando paru...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg -si && cd .. && rm -rf paru
fi

# 2. Actualizar sistema e instalar paquetes
echo -e "${BLUE}Instalando paquetes necesarios...${NC}"
paru -Syu --needed - < packages.txt

# 3. Crear backups de la configuración actual
echo -e "${BLUE}Respaldando configuraciones actuales en ~/backup_configs...${NC}"
mkdir -p ~/backup_configs
for folder in hypr waybar kitty fish fastfetch; do
    if [ -d ~/.config/$folder ]; then
        cp -r ~/.config/$folder ~/backup_configs/
    fi
done

# 4. Aplicar nuevos dotfiles
echo -e "${BLUE}Aplicando nuevos dotfiles...${NC}"
cp -r dotfiles/.config/* ~/.config/

# 5. Configurar Fish como shell por defecto
if [[ $SHELL != "/usr/bin/fish" ]]; then
    echo -e "${BLUE}Cambiando shell a Fish...${NC}"
    chsh -s /usr/bin/fish
fi

# 6. Finalización
echo -e "${GREEN}¡Configuración completada! Recomiendo reiniciar el sistema.${NC}"
