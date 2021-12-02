#import "Basic";
#import "File";
#import "String";

main :: () {
    input, success := read_entire_file("day_02/input.txt");
    if !success {
        print("reading input file was unsuccessful\n");
        return;
    }

    lines := split(input, "\n");

    x,z,aim := 0,0,0;

    for lines {
        parts := split(it, " ");
        dir   := parts[0];
        dist  := string_to_int(parts[1]);

        if dir == {
            case "forward"; x += dist; z += aim * dist;
            case "down"; aim += dist;
            case "up"; aim -= dist;
        }
    }

    print("x:% z:%\n", x, z);

    print("Result: %\n", x * z);
}
