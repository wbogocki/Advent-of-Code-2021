#import "Basic";
#import "File";
#import "String";

binary_to_s64 :: (bin: string) -> s64 {
    num := 0;
    for 0..bin.count-1 {
        if bin[it] == "1"[0] {
            num |= 1 << (bin.count - 1 - it);
        }
    }
    return num;
}

get_most_common_bit :: (lines: []string, digit_index: s64, default_bit: u8) -> u8 {
    one_count, zero_count := 0, 0;
    for lines {
        if it[digit_index] == {
            case "0"[0]; zero_count += 1;
            case "1"[0]; one_count += 1;
        }
    }
    // print("Counts % %\n", one_count, zero_count);
    if one_count > zero_count return "1"[0];
    if one_count < zero_count return "0"[0];
    return default_bit;
}

get_oxygen_rating :: (lines: []string) -> s64 {
    digits := lines[0].count;
    lines_resizable: [..]string;
    for lines array_add(*lines_resizable, it);
    for digit_index: 0..digits-1 {
        common_bit := get_most_common_bit(lines_resizable, digit_index, "1"[0]);

        line_index := 0;
        while lines_resizable.count > 1 && line_index < lines_resizable.count {
            if lines_resizable[line_index][digit_index] != common_bit {
                // print("Remove %\n", lines_resizable[line_index]);
                array_ordered_remove_by_index(*lines_resizable, line_index);
            } else {
                // print("Keep %\n", lines_resizable[line_index]);
                line_index += 1;
            }
        }

        // print("Common bit: ");
        // print_character(common_bit);
        // print("\n");

        if lines_resizable.count == 1 {
            for lines_resizable print("%\n", it);
            return binary_to_s64(lines_resizable[0]);
        }
    }
    print("failed to find oxygen rating\n");
    exit(1);
    return -1;
}

get_least_common_bit :: (lines: []string, line_index: s64, default_bit: u8) -> u8 {
    one_count, zero_count := 0, 0;
    for lines {
        if it[line_index] == {
            case "0"[0]; zero_count += 1;
            case "1"[0]; one_count += 1;
        }
    }
    // print("Counts % %\n", one_count, zero_count);
    if one_count < zero_count return "1"[0];
    if one_count > zero_count return "0"[0];
    return default_bit;
}

get_co2_rating :: (lines: []string) -> s64 {
    digits := lines[0].count;
    lines_resizable: [..]string;
    for lines array_add(*lines_resizable, it);
    for digit_index: 0..digits-1 {
        common_bit := get_least_common_bit(lines_resizable, digit_index, "0"[0]);

        line_index := 0;
        while lines_resizable.count > 1 && line_index < lines_resizable.count {
            if lines_resizable[line_index][digit_index] != common_bit {
                // print("Remove %\n", lines_resizable[line_index]);
                array_ordered_remove_by_index(*lines_resizable, line_index);
            } else {
                // print("Keep %\n", lines_resizable[line_index]);
                line_index += 1;
            }
        }

        // print("Common bit: ");
        // print_character(common_bit);
        // print("\n");

        if lines_resizable.count == 1 {
            for lines_resizable print("%\n", it);
            return binary_to_s64(lines_resizable[0]);
        }
    }
    print("failed to find co2 rating\n");
    exit(1);
    return -1;
}

main :: () {
    input, success := read_entire_file("day_03/input.txt");
    if !success {
        print("failed to read input file\n");
        return;
    }

    lines := split(input, "\n");
    for 0..lines.count-1 lines[it] = trim_right(lines[it], chars="\r\n");

    oxygen_rating := get_oxygen_rating(lines);
    print("Oxygen rating: %\n", oxygen_rating);

    co2_rating := get_co2_rating(lines);
    print("CO2 rating: %\n", co2_rating);

    print("Result: %\n", oxygen_rating * co2_rating);
}