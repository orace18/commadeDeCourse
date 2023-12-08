param (
    [string]$model_name
)

# Vérifie si un argument a été fourni
if (-not $model_name) {
    Write-Host "Veuillez fournir un nom de page."
    exit 1
}

if ($env:OSTYPE -eq "linux-gnu") {
    $model_name_class_name = $model_name -replace '_([a-z])', { $_.Groups[1].Value.ToUpper() }
    $model_name_class_name = $model_name_class_name.Substring(0,1).ToUpper() + $model_name_class_name.Substring(1)
}
elseif ($env:OSTYPE -eq "darwin23") {
    $model_name_class_name = ""
    $model_name_split = $model_name -split '_'
    foreach ($part in $model_name_split) {
        $model_name_class_name += ($part.Substring(0,1).ToUpper() + $part.Substring(1).ToLower())
    }
}
else {
    Write-Host $env:OSTYPE
    Write-Host "Système d'exploitation non pris en charge."
    exit 1
}

# Créer le dossier de la page
New-Item -ItemType Directory -Path "lib\pages\$model_name`_page" -Force

# Créer le dossier de contrôleurs
New-Item -ItemType Directory -Path "lib\pages\$model_name`_page\controllers" -Force

# Créer le fichier ${model_name}_binding.dart avec le contenu spécifié
@"
import 'package:get/get.dart';
import '${model_name}_controller.dart';

class $model_name_class_name Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<$model_name_class_name Controller>(() => $model_name_class_name Controller());
  }
}
"@ | Set-Content -Path "lib\pages\$model_name`_page\controllers\$model_name`_binding.dart"

# Créer le fichier ${model_name}_controller.dart avec le contenu spécifié
@"
import 'package:get/get.dart';

class $model_name_class_name Controller extends GetxController {
  void navigateBack() => Get.back();
}
"@ | Set-Content -Path "lib\pages\$model_name`_page\controllers\$model_name`_controller.dart"

# Créer le fichier index.dart avec le contenu spécifié
@"
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/$model_name`_controller.dart';

class $model_name_class_name Page extends GetWidget<$model_name_class_name Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<$model_name_class_name Controller>(
          builder: (_) => Placeholder(),
        ));
  }
}
"@ | Set-Content -Path "lib\pages\$model_name`_page\index.dart"

Write-Host "La page $model_name_class_name a été créée avec succès."
