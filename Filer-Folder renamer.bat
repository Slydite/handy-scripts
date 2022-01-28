@echo off
pushd "Folder"
for /d %%D in (*) do (
  for %%F in ("%%~D\*") do (
    for %%P in ("%%F\..") do (
      ren "%%F" "%%~nxP_%%~nxF"
    )
  )
)
popd