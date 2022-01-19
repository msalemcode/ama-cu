$TemplateDeploymentname = New-Guid
$ResourceGroupName = "amafunc01"
$TemplateFile = ".\maintemplate.json" 
$TemplateParameterFile = ".\maintemplate.parameters.json"


New-AzResourceGroupDeployment `
    -Name $TemplateDeploymentname `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParameterFile