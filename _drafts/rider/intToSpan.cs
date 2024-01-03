 static void WriteInt32ToBuffer(int value, Memory<char> buffer)
    {
        var strValue = value.ToString();

        var span = buffer.Slice(0, strValue.Length).Span;
        strValue.AsSpan().CopyTo(span);
    }

    static void DisplayBufferToConsole(Memory<char> buffer) => Console.WriteLine($"Contents of the buffer: '{buffer}'");

   static void DisplayBufferToConsole1(ReadOnlySpan<char> buffer) => Console.WriteLine($"Contents of the buffer: '{buffer}'");
