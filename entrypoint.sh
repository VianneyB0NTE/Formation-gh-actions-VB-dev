#!/bin/sh

SAY="${1:-moooow}"
EYES="${2:-O-O}"

echo "🐄 Cow says: $SAY"
echo "👀 With eyes: $EYES"

# Use cowsay if available, otherwise just echo
if command -v cowsay >/dev/null 2>&1; then
    cowsay -e "$EYES" "$SAY"
else
    echo "     ___________________"
    echo "    < $SAY >"
    echo "     -------------------"
    echo "            \\   ^__^"
    echo "             \\  ($EYES)\\_______"
    echo "                (__)\\       )\\/\\"
    echo "                    ||----w |"
    echo "                    ||     ||"
fi