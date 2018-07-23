#!/usr/bin/env nim
#
# nim e build_nim_telegram_bot.nims


echo "Building for Linux"
exec "nim c -d:release -d:ssl --app:console --opt:size --out:downloads/tinyslation src/translation.nim"
exec "strip --verbose -ss downloads/tinyslation"
# exec "upx --best --ultra-brute downloads/tinyslation"
exec "sha1sum --tag downloads/tinyslation > downloads/tinyslation.sha1"
exec "sha512sum --tag downloads/tinyslation > downloads/tinyslation.sha512"
# exec "keybase sign --infile downloads/tinyslation --outfile downloads/tinyslation.asc"

echo "Building for Windows"
exec "nim c --cpu:amd64 --os:windows --gcc.exe:/usr/bin/x86_64-w64-mingw32-gcc --gcc.linkerexe:/usr/bin/x86_64-w64-mingw32-gcc -d:release --opt:size --out:downloads/tinyslation.exe src/translation.nim"
exec "sha1sum --tag downloads/tinyslation.exe > downloads/tinyslation.exe.sha1"
exec "sha512sum --tag downloads/tinyslation.exe > downloads/tinyslation.exe.sha512"
# exec "keybase sign --infile downloads/tinyslation.exe --outfile downloads/tinyslation.exe.asc"

exec "chmod --verbose -w downloads/*"
