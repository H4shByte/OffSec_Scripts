$groups = get-netgroup | select-object -expandproperty samaccountname

$results = foreach($group in $groups) {
    $ace = get-objectacl -identity $group
        foreach($Val in $ace){

#Security Identifer has these rights on the Object SID
        $Obj_SID = Convert-SidToName $val.ObjectSID
        $Rights  = $val.ActiveDirectoryRights
        $Sec_ID  = Convert-SidToName $val.SecurityIdentifier
    
        [PSCustomObject]@{
            Object_SID      = $Obj_SID
            Rights          = $Rights
            Sec_Identifier  = $Sec_ID
        }
    }
}

$results | export-csv C:\Users\web_svc\Documents\test.csv
