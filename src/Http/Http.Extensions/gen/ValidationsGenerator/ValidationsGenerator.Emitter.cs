using System.Collections.Immutable;
using System.IO;
using Microsoft.CodeAnalysis;

public partial class ValidationsGenerator
{
    public static string GeneratedCodeConstructor => $@"System.CodeDom.Compiler.GeneratedCodeAttribute(""{typeof(ValidationsGenerator).Assembly.FullName}"", ""{typeof(ValidationsGenerator).Assembly.GetName().Version}"")";
    public static string GeneratedCodeAttribute => $"[{GeneratedCodeConstructor}]";

    private const string SourceHeader = """
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
""";

    private static readonly string InterceptsLocationAttribute = $$"""
namespace System.Runtime.CompilerServices
{
   [AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
   {{GeneratedCodeAttribute}}
   file sealed class InterceptsLocationAttribute : Attribute
   {
       public InterceptsLocationAttribute(string filePath, int line, int column)
       {
       }
   }
}
""";

    private static readonly string ValidatableModelAttribute = $$"""
namespace Microsoft.AspNetCore.Validation
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
    {{GeneratedCodeAttribute}}
    file sealed class ValidatableModelAttribute : Attribute { }
   }
}
""";

        private const string Usings = """
using System;
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Builder;
""";

    internal static void Emit(SourceProductionContext context, ImmutableArray<ValidatableEndpoint> validatableEndpoints)
    {
        if (validatableEndpoints.IsDefaultOrEmpty)
        {
            return;
        }
        var stringWriter = new StringWriter();
        var writer = new CodeWriter(stringWriter, baseIndent: 0);
        writer.WriteLine(SourceHeader);
        writer.WriteLine("#nullable enable");
        writer.WriteLine(InterceptsLocationAttribute);
        writer.WriteLine(ValidatableModelAttribute);
        writer.WriteLine("namespace Microsoft.AspNetCore.Http.Generated");
        writer.StartBlock();
        writer.WriteLine(Usings);
        writer.WriteLine(GeneratedCodeAttribute);
        writer.WriteLine("public static class GeneratedValidationCalls");
        writer.StartBlock();
        foreach (var endpoint in validatableEndpoints)
        {
            Emit(endpoint, writer);
        }
        writer.EndBlock();
        writer.EndBlock();
        var source = stringWriter.ToString();
        context.AddSource("GeneratedEventHandlers.g.cs", source);
    }

    internal static void Emit(ValidatableEndpoint endpoint, CodeWriter writer)
    {
        var location = endpoint.Location;
        writer.WriteLine($$"""[InterceptsLocation(@"{{location.File}}", {{location.LineNumber}}, {{location.CharacterNumber}})]""");
        writer.WriteLine($"public static TBuilder WithValidation<TBuilder>(this TBuilder builder) where TBuilder : IEndpointConventionBuilder");
        writer.StartBlock();
        writer.WriteLine("return builder;");
        writer.EndBlock();
    }

    internal static void Emit(SourceProductionContext context, ValidatableModel model)
    {
        return;
    }
}
