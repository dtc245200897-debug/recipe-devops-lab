
$content = @'
#!/usr/bin/env bash

echo "===================================="
echo " RECIPE WEBSITE - SECURITY AUDIT"
echo "===================================="

echo
echo "[1] Docker Compose configuration"
if docker compose config --quiet; then
    echo "PASS: Compose configuration is valid"
else
    echo "FAIL: Compose configuration has errors"
fi

echo
echo "[2] Container status"
docker compose ps

echo
echo "[3] Nginx security headers"
curl.exe -sSI http://localhost

echo
echo "===================================="
echo " SECURITY AUDIT FINISHED"
echo "===================================="
'@

$path = (Resolve-Path .).Path + "\security\audit.sh"
$unixContent = $content -replace "`r`n", "`n"
[System.IO.File]::WriteAllText($path, $unixContent, [System.Text.UTF8Encoding]::new($false))

Write-Host "Da tao lai audit.sh voi xuong dong Unix."
