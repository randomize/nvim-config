

rem use with Unity use pythonw (not python to hide window)
rem "C:\Program Files\Python36\Scripts\nvr" --servername 127.0.0.1:7777  "$(File)" -c "$(Line)"
rem call nvim-qt.exe -qwindowgeometry 1024x800 --servname unityvim
rem nvim-qt.exe --help


cd C:\Users\emihailenco\Neovim\bin\


set NVIM_LISTEN_ADDRESS=127.0.0.1:7777
call nvim-qt --maximized

rem start nvim --headless
rem nvim-qt --server 127.0.0.1:7777 --maximized



