foreach ($username in (Get-ADUser -SearchBase "OU=TerminatedStaff,DC=orgname,DC=org" -filter *)) {

# Get all group memberships
$groups = get-adprincipalgroupmembership $username;

# Loop through each group
foreach ($group in $groups) {

    # Exclude Domain Users group
    if ($group.name -ne "domain users") {

        # Remove user from group
        remove-adgroupmember -Identity $group.name -Member $username.SamAccountName -Confirm:$false;

        # Write progress to screen
        write-host "removed" $username "from" $group.name;

        # Define and save group names into filename in c:\logs\groupsstrip\username
        $grouplogfile = "c:\logs\groupsstrip\" + $username.SamAccountName + ".txt";
        $group.name >> $grouplogfile
    }

}
}
