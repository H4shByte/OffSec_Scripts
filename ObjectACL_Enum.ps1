# Leverage information from Get-ObjectACL from the PowerView.ps1 script (from PowerSploit)
# Run the command "Get-Objectacl -identity <object-name>" and store it in a variable called $ace
# Then run this script with ". .\ObjectACL_Enum.ps1" to get a $results variable that maps all ObjectSIDs, its AccessRightsProperties to the Security_identifier
#Example: do a get-object ACL on a Domain Group -> feed that into this script to find out objects have rights over that group.


$results = foreach($Val in $ace){

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
