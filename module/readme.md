## Azure Bicep KeyVault Module Documentation

### Overview:

This module allows for the creation of an Azure Key Vault. It provides customization based on `location`, `environment`, and `purpose` with dynamic naming conventions based on the provided parameters. It also ensures the newly created Key Vault has RBAC (Role-Based Access Control) authorization enabled.

### Module Parameters:

1. **location**:
   - Description: Specifies the Azure region where the Key Vault should be created.
   - Allowed values: 'westeurope', 'northeurope'
   - Type: String
   
2. **environment**:
   - Description: Specifies the type of environment for which the Key Vault is being provisioned.
   - Allowed values: 'acceptance', 'production', 'integration'
   - Type: String

3. **kvSkuName**:
   - Description: The SKU name of the Key Vault.
   - Type: String

4. **purpose**:
   - Description: The specific use case or reason for provisioning the Key Vault.
   - Type: String

### Naming Convention:

The module uses the `location`, `environment`, and `purpose` parameters to create a dynamic name for the Key Vault in the format:

```
'kvault-{locationShortName}-{environmentShortName}-{purpose}'
```

Where:
- `{locationShortName}` is the short version of the provided location. ('we' for 'westeurope' and 'ne' for 'northeurope')
- `{environmentShortName}` is the short version of the provided environment. ('prd' for 'production', 'acc' for 'acceptance', and 'int' for 'integration')

### Resource Details:

1. **myKeyVault**:
   - Resource Type: `Microsoft.KeyVault/vaults`
   - API Version: `2022-11-01`
   
   **Properties**:
   - **sku**: 
     - **family**: Set to 'A'. This is the SKU family for Azure Key Vault.
     - **name**: The SKU name of the Key Vault, passed via the `kvSkuName` parameter.
   - **tenantId**: Automatically retrieves the tenant ID of the current Azure context.
   - **enableRbacAuthorization**: Set to `true`, this ensures the Key Vault uses Role-Based Access Control (RBAC) for authorization.
   - **createMode**: Set to 'default'. This indicates the standard method of Key Vault creation.

### Usage:

To utilize this module, make a reference to it in your main Bicep file and pass the necessary parameters. Ensure that the values for `location`, `environment`, and `kvSkuName` meet the constraints defined in the module.

### Note:

Ensure you have the necessary permissions to create Azure Key Vault resources in your subscription and the selected location. Also, ensure the chosen SKU is available in your region.

### Best Practices:

1. When choosing a `purpose`, be as descriptive as possible to easily identify the use case of the Key Vault.
2. Ensure the chosen `environment` correctly reflects the environment you are working in.
3. Regularly review and update access policies to ensure only necessary identities have access to your Key Vault.