using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Generators.Tests;

public partial class ValidationsGeneratorTests : ValidationsGeneratorTestBase
{
    [Theory]
    [InlineData("3", true)]
    [InlineData("12", false)]
    public async Task SingleSimpleType(string testValue, bool isValid)
    {
        // Arrange
        var source = @"app.MapGet(""/{id}"", ([Range(1, 10)] int id) => ""Hello, World!"").WithValidation();";
        var (_, compilation) = await RunGeneratorAsync(source);
        var endpoint = GetEndpointFromCompilation(compilation);
        var httpContext = CreateHttpContext();
        httpContext.Request.RouteValues["id"] = testValue;

        // Act
        await endpoint.RequestDelegate(httpContext);

        // Assert
        Assert.Equal(isValid, httpContext.Response.StatusCode.Equals(StatusCodes.Status200OK));
    }
}
