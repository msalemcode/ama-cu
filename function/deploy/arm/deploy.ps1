
while (!$ResourceGroupName) {
    $ResourceGroupName = Read-Host -Prompt 'Input your Resource Group name'
}    

$TemplateDeploymentname = New-Guid
$TemplateFile = ".\maintemplate.json" 
$TemplateParameterFile = ".\maintemplate.parameters.json"

New-AzResourceGroup $ResourceGroupName -Location "east us" 

New-AzResourceGroupDeployment `
    -Name $TemplateDeploymentname `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParameterFile
    