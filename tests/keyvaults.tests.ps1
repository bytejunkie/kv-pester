$ResourceGroupName = "keyvaults"

$json = Get-Content -Path ./infrastructure.json | ConvertFrom-Json

Describe "Keyvault Tests" {
    foreach ($keyvault in $json.keyvaults) {
        It "There is a keyvault with the right name $($keyvault)" {
            (Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $keyvault).count | should be 1
            #(Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $keyvault).count
        } 
    }
}

Describe "Secret Tests" {
    foreach ($keyvault in $json.keyvaults) {
        foreach ($secret in $json.secrets) {
            It "there is a secret with the name $($secret) in the keyvault with the name $($keyvault)" {
                (Get-AzKeyVaultSecret -VaultName $keyvault -Name $secret).count | should be 1
            }
        }
    }
}
