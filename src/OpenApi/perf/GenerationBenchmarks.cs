
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Diagnosers;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Routing;
using Microsoft.OpenApi.Models;

namespace Microsoft.AspNetCore.OpenApi.Microbenchmarks;

/// <summary>
/// The following benchmarks are used to assess the memory and performance
/// impact of different types of transformers. In particular, we want to
/// measure the impact of (a) context-object creation and caching and (b)
/// enumerator usage when processing operations in a given document.
/// </summary>
[MemoryDiagnoser]
[EventPipeProfiler(EventPipeProfile.GcVerbose)]
public class GenerationBenchmarks : OpenApiDocumentServiceTestBase
{
    [Params(10, 100, 1000)]
    public int EndpointCount { get; set; }

    private readonly IEndpointRouteBuilder _builder = CreateBuilder();
    private readonly OpenApiOptions _options = new OpenApiOptions();
    private OpenApiDocumentService _documentService;

    [GlobalSetup(Target = nameof(GenerateDocument))]
    public void OperationTransformerAsDelegate_Setup()
    {
        _builder.MapGet("/", () => { });
        for (var i = 0; i <= EndpointCount; i++)
        {
            _builder.MapGet($"/{i}", (int i) => new Todo());
        }
        _documentService = CreateDocumentService(_builder, _options);
    }

    [Benchmark]
    public async Task GenerateDocument()
    {
        await _documentService.GetOpenApiDocumentAsync();
    }
}
