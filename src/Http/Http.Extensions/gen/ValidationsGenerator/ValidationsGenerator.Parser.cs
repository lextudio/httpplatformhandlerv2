using System.Collections.Generic;
using System.Threading;
using Microsoft.AspNetCore.App.Analyzers.Infrastructure;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.Operations;

public partial class ValidationsGenerator
{
    internal static ValidatableEndpoint Parse(IInvocationOperation invocationOperation, WellKnownTypes _)
    {
        return new ValidatableEndpoint { Location = invocationOperation.GetLocation(), Parameters = [] };
    }

    internal static ValidatableModel ParseModel(GeneratorAttributeSyntaxContext context, CancellationToken token)
    {
        var _ = context.TargetNode;
        return new ValidatableModel();
    }

    internal class ValidatableEndpoint
    {
        public (string File, int LineNumber, int CharacterNumber) Location { get; init; }
        public IList<ValidatableParameter> Parameters { get; init; } = [];
    }

    internal class ValidatableParameter
    {
        public string Name { get; init; } = default!;
        public ITypeSymbol Type { get; init; } = default!;
    }

    internal class ValidatableModel
    {

    }
}
