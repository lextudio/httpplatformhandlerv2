// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.Operations;

internal static class IInvocationOperationExtensions
{
    internal static (string, int, int) GetLocation(this IInvocationOperation operation)
    {
        // The invocation expression consists of two properties:
        // - Expression: which is a `MemberAccessExpressionSyntax` that represents the method being invoked.
        // - ArgumentList: the list of arguments being invoked.
        // Here, we resolve the `MemberAccessExpressionSyntax` to get the location of the method being invoked.
        var memberAccessorExpression = ((MemberAccessExpressionSyntax)((InvocationExpressionSyntax)operation.Syntax).Expression);
        // The `MemberAccessExpressionSyntax` in turn includes three properties:
        // - Expression: the expression that is being accessed.
        // - OperatorToken: the operator token, typically the dot separate.
        // - Name: the name of the member being accessed, typically `MapGet` or `MapPost`, etc.
        // Here, we resolve the `Name` to extract the location of the method being invoked.
        var invocationNameSpan = memberAccessorExpression.Name.Span;
        // Resolve LineSpan associated with the name span so we can resolve the line and character number.
        var lineSpan = operation.Syntax.SyntaxTree.GetLineSpan(invocationNameSpan);
        // Resolve the filepath of the invocation while accounting for source mapped paths.
        var filePath = operation.Syntax.SyntaxTree.GetInterceptorFilePath(operation.SemanticModel?.Compilation.Options.SourceReferenceResolver);
        // LineSpan.LinePosition is 0-indexed, but we want to display 1-indexed line and character numbers in the interceptor attribute.
        return (filePath, lineSpan.StartLinePosition.Line + 1, lineSpan.StartLinePosition.Character + 1);
    }
}
