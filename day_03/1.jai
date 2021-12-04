#import "Basic";
#import "File";
#import "String";

main :: () {
    input, success := read_entire_file("day_03/input.txt");
    if !success {
        print("failed to read input file\n");
        return;
    }

    gamma_rate, epsilon_rate := 0, 0;

    lines := split(input, "\n");

    digits := lines[0].count-1;

    print("Digits: %\n", digits);

    for i: 0..digits-1 {
        one_count, zero_count := 0, 0;
        for lines {
            if it[i] == {
                case "0"[0]; zero_count += 1;
                case "1"[0]; one_count += 1;
            }
        }

        print("% %\n", one_count, zero_count);

        if one_count > zero_count gamma_rate |= 1 << (digits-i-1);
        if one_count < zero_count epsilon_rate |= 1 << (digits-i-1);
    }

    print("Gamma: %\nEpisolon: %\n", gamma_rate, epsilon_rate);

    print("Result: %\n", gamma_rate * epsilon_rate);
}