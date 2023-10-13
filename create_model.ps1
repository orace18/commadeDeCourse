param (
    [string]$model_name,
    [string]$hive_type_id
)

# Define list of attribute types
$attribute_types = @("int", "double", "String", "bool", "List<int>", "List<double>", "List<String>", "List<bool>", "List<dynamic>", "Other(specify)")

# Ask for model name
if (-not $model_name) {
    $model_name = Read-Host "Enter model name"
}

if (-not $hive_type_id) {
    $hive_type_id = Read-Host "Enter hive type id"
}

$model_name_class_name = ""
$split_model_name = $model_name -split '_'
foreach ($part in $split_model_name) {
    $model_name_class_name += ($part.Substring(0, 1).ToUpper() + $part.Substring(1).ToLower())
}
Write-Host "Creating $model_name_class_name model..."

# Start model definition
$save_path = "lib\models\"
$model_definition = "import 'package:hive/hive.dart';`n`n"
$model_definition += "part '$model_name.g.dart';`n`n"
$model_definition += "@HiveType(typeId: $hive_type_id)`n"
$model_definition += "class $model_name_class_name {`n"

# Define fields
$fields_definition = ""

# Start constructor definition
$constructor_definition = "`n`n  $model_name_class_name({"

# Define fromMap factory method
$from_map_definition = "`n  factory $model_name_class_name.fromMap(Map<String, dynamic> map) {`n"
$from_map_definition += "    return $model_name_class_name(`n"

# Define toMap method
$to_map_definition = "`n  Map<String, dynamic> toMap() {`n"
$to_map_definition += "    return {`n"

# Ask for attributes until user enters empty value
while ($true) {
    # Ask for attribute name
    Write-Host ""
    $attribute_name = Read-Host "Enter attribute name (leave empty to finish)"

    # Stop asking for attributes if user enters empty value
    if (-not $attribute_name) {
        break
    }

    # Ask user to select attribute type
    Write-Host "Select attribute type for $attribute_name:"
    for ($i = 0; $i -lt $attribute_types.Length; $i++) {
        Write-Host "$i. $($attribute_types[$i])"
    }
    # Ask for attribute type number or Attribute type name and check number is less than attribute types length or attribut type name is not number
    while ($true) {
        $attribute_type_number = Read-Host "Type number"
        if ($attribute_type_number -match '^\d+$') {
            if ($attribute_type_number -lt $attribute_types.Length) {
                break
            }
        }
        else {
            for ($i = 0; $i -lt $attribute_types.Length; $i++) {
                if ($attribute_types[$i] -eq $attribute_type_number) {
                    $attribute_type_number = $i
                    break
                }
            }
        }
        Write-Host "Invalid attribute type number"
    }

    if ($attribute_type_number -eq $attribute_types.Length - 1) {
        $attribute_type = Read-Host "Enter attribute type"
    }
    else {
        $attribute_type = $attribute_types[$attribute_type_number]
    }

    # Ask if attribute is required
    $is_required = Read-Host "Is $attribute_name required? (Y/n)"
    if ($is_required -ne "n") {
        $is_required = $true
    }
    else {
        $is_required = $false
    }

    # Define field
    $field_definition = "`n  @HiveField($fields_count:=0)"
    $field_definition += "`n  $attribute_type $attribute_name;"

    # Add field to model definition
    $model_definition += $field_definition

    # Add field to constructor definition
    $constructor_definition += ($is_required ? "required " : "") + "this.$attribute_name,"

    # Add field to fromMap factory method
    $from_map_definition += "      $attribute_name: map['$attribute_name'],`n"

    # Add field to toMap method
    $to_map_definition += "      '$attribute_name': $attribute_name,`n"

    $fields_count++
}

# End constructor definition
$constructor_definition += "});"

# End model definition
$model_definition += $constructor_definition + "`n"

# End fromMap factory method
$from_map_definition += "    );`n  }`n"

# End toMap method
$to_map_definition += "    };`n  }`n"

# Add fromMap and toMap methods to model definition
$model_definition += $from_map_definition
$model_definition += $to_map_definition
$model_definition += "}`n"

# Create model file
$model_definition | Out-File -FilePath "$save_path$model_name.dart"

Write-Host "Model created successfully!"
