#import "Basic";
#import "File";
#import "String";

main :: () {
    input, success := read_entire_file("day_01/input.txt");
    if !success {
        print("reading file failed\n");
        return;
    }

    // print(input);

    lines := split(input, "\n");

    increasing_count := 0;

    // print("%\n", lines.count);

    for 0..lines.count-2 {
        this := string_to_int(lines[it]);
        next := string_to_int(lines[it+1]);

        // print("% %\n", this, next);

        if next > this increasing_count += 1;
    }

    print("Result: %", increasing_count);
}
