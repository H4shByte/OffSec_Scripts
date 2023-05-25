$results = Get-LocalGroup | ForEach-Object {
    $group = $_
    Get-LocalGroupMember -Group $group.Name | ForEach-Object {
        [PSCustomObject]@{
            Group = $group.Name
            Member = $_.Name
        }
    }
}
