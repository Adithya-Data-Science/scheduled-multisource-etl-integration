# Windows Task Scheduler verification

These steps create a real daily scheduled integration and capture auditable results.

1. Open PowerShell in the repository root.
2. Install dependencies: `py -m pip install -r requirements.txt`.
3. Register the task: `powershell -ExecutionPolicy Bypass -File scripts/register_task.ps1`.
4. Trigger it once: `Start-ScheduledTask -TaskName "Portfolio-MultiSource-ETL"`.
5. After it finishes, verify: `powershell -ExecutionPolicy Bypass -File scripts/verify_task.ps1`.
6. Commit the generated `evidence/scheduled-run-*.log` after confirming it contains `exit_code=0`.

The registration configures daily execution, catch-up after missed starts, and two retries at five-minute intervals. Do not describe the workflow as successfully scheduled until `LastTaskResult` is `0` and the run log is committed.
