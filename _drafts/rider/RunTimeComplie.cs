using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

// internal class RunTimecompile
// {

//    public static void Run()
//     {
//         var csc = new CSharpCodeProvider(new Dictionary<string, string>() { { "CompilerVersion", "v3.5" } });
//         var parameters = new CompilerParameters(new[] { "mscorlib.dll", "System.Core.dll" }, "foo.dll", true);
//         parameters.GenerateExecutable = true;
//         CompilerResults results = csc.CompileAssemblyFromSource(parameters,
//         @"using System.Linq;
//             public class Emulator  {
//               public  int Run() {
//               return 123;
//               }}");
//         results.Errors.Cast<CompilerError>().ToList().ForEach(error => Console.WriteLine(error.ErrorText));
//     }
// }
