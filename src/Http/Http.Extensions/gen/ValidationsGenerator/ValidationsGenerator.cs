using Microsoft.AspNetCore.Analyzers.Infrastructure;
using Microsoft.AspNetCore.App.Analyzers.Infrastructure;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.Operations;

[Generator]
public partial class ValidationsGenerator : IIncrementalGenerator
{
    public void Initialize(IncrementalGeneratorInitializationContext context)
    {
        var withValidationInvocations = context.SyntaxProvider.CreateSyntaxProvider(
            predicate: (node, _) => TryGetInvocationMethodName(node, out var methodName) && methodName == "WithValidation",
            transform: (context, token) =>
            {
                var operation = context.SemanticModel.GetOperation(context.Node, token) as IInvocationOperation;
                AnalyzerDebug.Assert(operation is not null, "Expected an invocation operation.");
                var wellKnownTypes = WellKnownTypes.GetOrCreate(context.SemanticModel.Compilation);
                return Parse(operation, wellKnownTypes);
            });

        var validatableModels = context.SyntaxProvider.ForAttributeWithMetadataName("Microsoft.AspNetCore.Validation.ValidatableModelAttribute",
            predicate: (node, _) => node is ClassDeclarationSyntax,
            transform: ParseModel);

        context.RegisterSourceOutput(validatableModels, Emit);
        context.RegisterSourceOutput(withValidationInvocations.Collect(), Emit);
    }

    private static bool TryGetInvocationMethodName(SyntaxNode node, out string? methodName)
    {
        methodName = default;
        if (node is InvocationExpressionSyntax { Expression: MemberAccessExpressionSyntax { Name.Identifier.ValueText: var method } })
        {
            methodName = method;
            return true;
        }
        return false;
    }
}
