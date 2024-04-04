public class Todo
{
    public string Title { get; set; }
    public bool IsComplete { get; set; }
}

public class TodoWithDueDate : Todo
{
    public DateTime DueAt { get; set; }
}
