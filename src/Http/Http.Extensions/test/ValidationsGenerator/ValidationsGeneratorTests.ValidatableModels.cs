using Microsoft.AspNetCore.Http.Generators.Tests;

public partial class ValidationsGeneratorTests : ValidationsGeneratorTestBase
{
    [Fact]
    public async Task ComplexType()
    {
        // Arrange
        var source = """
using System;
using System.ComponentModel.DataAnnotations;

namespace Microsoft.AspNetCore.Validation
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
    file sealed class ValidatableModelAttribute : Attribute { }
}

[Microsoft.AspNetCore.Validation.ValidatableModel]
public class Model
{
    [Range(1, 10)]
    public int Id { get; set; }
}
""";
        var (driver, updatedCompilation) = await RunGeneratorDriverAsync(source, forModel: true);
        var diagnostics = updatedCompilation.GetDiagnostics();
        await Verify(driver.GetRunResult());
    }
}
