# connect
# Connect-AzAccount

$ResourceGroupName = "keyvaults"
$upn = ""

$json = Get-Content -Path ./infrastructure.json | ConvertFrom-Json

foreach ($keyvault in $json.keyvaults) {
    New-AzKeyVault -Name $keyvault -ResourceGroupName $ResourceGroupName -Location "UK South"
    Set-AzKeyVaultAccessPolicy -VaultName $keyvault -ResourceGroupName $ResourceGroupName -UserPrincipalName $upn -PermissionsToSecrets get,list,set,delete
    foreach ($secret in $json.secrets) {
        Set-AzKeyVaultSecret -Name $secret -VaultName $keyvault -SecretValue (Convertto-secureString "SomeThingSecr3t" -AsPlainText -Force)
    }
}
