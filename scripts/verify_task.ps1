param([string]$TaskName = "Portfolio-MultiSource-ETL")
$Task = Get-ScheduledTask -TaskName $TaskName -ErrorAction Stop
$Info = Get-ScheduledTaskInfo -TaskName $TaskName
[pscustomobject]@{
  TaskName = $Task.TaskName
  State = $Task.State
  LastRunTime = $Info.LastRunTime
  LastTaskResult = $Info.LastTaskResult
  NextRunTime = $Info.NextRunTime
} | Format-List
if ($Info.LastTaskResult -ne 0) { throw "Last scheduled run did not succeed: $($Info.LastTaskResult)" }
