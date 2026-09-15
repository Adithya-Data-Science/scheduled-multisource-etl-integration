$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$EvidenceDir = Join-Path $ProjectRoot "evidence"
New-Item -ItemType Directory -Force -Path $EvidenceDir | Out-Null
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$Log = Join-Path $EvidenceDir "scheduled-run-$Timestamp.log"
try {
  & (Join-Path $ProjectRoot "run_etl.ps1") *>&1 | Tee-Object -FilePath $Log
  "exit_code=0" | Add-Content $Log
  exit 0
} catch {
  $_ | Out-File -Append $Log
  "exit_code=1" | Add-Content $Log
  exit 1
}
