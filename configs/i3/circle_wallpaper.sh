#!/usr/bin/env bash

# Укажи здесь правильный путь к своей папке с обоями
WALLPAPER_DIR="/home/rysia/Pictures/bg/"
STATE_FILE="$HOME/.current_wallpaper"

# 1. Собираем список всех картинок в папке по алфавиту
MAPFILE=()
while IFS= read -r line; do
    MAPFILE+=("$line")
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | sort)

TOTAL_WALLPAPERS=${#MAPFILE[@]}

# Если папка пустая, пишем ошибку и выходим
if [ $TOTAL_WALLPAPERS -eq 0 ]; then
    echo "Обои не найдены в папке $WALLPAPER_DIR"
    exit 1
fi

# 2. Определяем, какую картинку ставить следующей
if [ ! -f "$STATE_FILE" ] || ! grep -q "^$(cat "$STATE_FILE")$" <(printf '%s\n' "${MAPFILE[@]}"); then
    # Если скрипт запущен впервые, берем самую первую картинку
    NEW_WALL="${MAPFILE[0]}"
else
    CURRENT_WALL=$(cat "$STATE_FILE")
    # Ищем индекс текущих обоев и берем строго следующий по кругу
    for i in "${!MAPFILE[@]}"; do
        if [[ "${MAPFILE[$i]}" == "$CURRENT_WALL" ]]; then
            NEXT_INDEX=$(( (i + 1) % TOTAL_WALLPAPERS ))
            NEW_WALL="${MAPFILE[$NEXT_INDEX]}"
            break
        fi
    done
fi

# 3. Сохраняем имя новых обоев в файл состояния
echo "$NEW_WALL" > "$STATE_FILE"

# 4. Моментально меняем обои через feh
feh --bg-fill "$NEW_WALL"

echo "Обои успешно сменены на: $(basename "$NEW_WALL")"
