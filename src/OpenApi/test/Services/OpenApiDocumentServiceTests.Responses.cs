// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

public partial class OpenApiDocumentServiceTests : OpenApiDocumentServiceTestBase
{
    [Fact]
    public async Task GetOpenApiResponse_SupportsMultipleResponseViaAttributes()
    {
        // Arrange
        var builder = CreateBuilder();

        // Act
        builder.MapGet("/api/todos",
            [ProducesResponseType(typeof(TimeSpan), StatusCodes.Status201Created)]
            [ProducesResponseType(StatusCodes.Status400BadRequest)]
            () => { });

        // Assert
        await VerifyOpenApiDocument(builder, document =>
        {
            var operation = Assert.Single(document.Paths["/api/todos"].Operations.Values);
            Assert.Collection(operation.Responses.OrderBy(r => r.Key),
                response =>
                {
                    Assert.Equal("201", response.Key);
                    Assert.Equal("Created", response.Value.Description);
                },
                response =>
                {
                    Assert.Equal("400", response.Key);
                    Assert.Equal("Bad Request", response.Value.Description);
                });
        });
    }

    [Fact]
    public async Task GetOpenApiResponse_SupportsProblemDetailsResponse()
    {
        // Arrange
        var builder = CreateBuilder();

        // Act
        builder.MapGet("/api/todos", () => { })
            .WithMetadata(new ProducesResponseTypeMetadata(StatusCodes.Status400BadRequest, typeof(ProblemDetails), ["application/json+problem"]));

        // Assert
        await VerifyOpenApiDocument(builder, document =>
        {
            var operation = Assert.Single(document.Paths["/api/todos"].Operations.Values);
            var response = Assert.Single(operation.Responses);
            Assert.Equal("400", response.Key);
            Assert.Equal("Bad Request", response.Value.Description);
            Assert.Equal("application/json+problem", response.Value.Content.Keys.Single());
        });
    }

    [Fact]
    public async Task GetOpenApiResponse_SupportsMultipleResponsesForStatusCode()
    {
        // Arrange
        var builder = CreateBuilder();

        // Act
        builder.MapGet("/api/todos", () => { })
            // Simulates metadata provided by IEndpointMetadataProvider
            .WithMetadata(new ProducesResponseTypeMetadata(StatusCodes.Status200OK))
            // Simulates metadata added via `Produces` call
            .WithMetadata(new ProducesResponseTypeMetadata(StatusCodes.Status200OK, typeof(string), ["text/plain"]));

        // Assert
        await VerifyOpenApiDocument(builder, document => {
            var operation = Assert.Single(document.Paths["/api/todos"].Operations.Values);
            var response = Assert.Single(operation.Responses);
            Assert.Equal("200", response.Key);
            Assert.Equal("OK", response.Value.Description);
            var content = Assert.Single(response.Value.Content);
            Assert.Equal("text/plain", content.Key);
        });
    }

    [Fact]
    public async Task GetOpenApiResponse_SupportsMultipleResponseTypesWithTypeForStatusCode()
    {
        // Arrange
        var builder = CreateBuilder();

        // Act
        builder.MapGet("/api/todos", () => { })
            // Simulates metadata provided by IEndpointMetadataProvider
            .WithMetadata(new ProducesResponseTypeMetadata(StatusCodes.Status200OK, typeof(Todo), ["application/json"]))
            // Simulates metadata added via `Produces` call
            .WithMetadata(new ProducesResponseTypeMetadata(StatusCodes.Status200OK, typeof(TodoWithDueDate), ["application/json"]));

        // Assert
        await VerifyOpenApiDocument(builder, document => {
            var operation = Assert.Single(document.Paths["/api/todos"].Operations.Values);
            var response = Assert.Single(operation.Responses);
            Assert.Equal("200", response.Key);
            Assert.Equal("OK", response.Value.Description);
            var content = Assert.Single(response.Value.Content);
            Assert.Equal("application/json", content.Key);
            // Todo: Check that this generates a schema using `oneOf`.
        });
    }
}
