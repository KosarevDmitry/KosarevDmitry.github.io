* ```[global] using [static] ``` for class,  namespace, enum

* in csproj 
    * `<Using Include="Microsoft.AspNetCore.Http.Results" Alias="Results" />`
 emits `global using Results = global::Microsoft.AspNetCore.Http.Results;`

    * `<Using Include="Microsoft.AspNetCore.Http.Results" Static="True" /> `
emits `global using static global::Microsoft.AspNetCore.Http.Results;`