#import "Basic";
#import "File";
#import "String";

main :: () {
    input, success := read_entire_file("day_04/input.txt");
    if !success {
        print("failed to read input file\n");
        return;
    }

    lines := split(input, "\n");

    play_numbers: [..]s32;
    for split(lines[0], ",") array_add(*play_numbers, cast(s32) string_to_int(it));

    // for play_numbers print("% ", it);
    // print("\n");

    boards: [..][5][5]s32;

    board_index, row, col := 0, 0, 0;

    for 2..lines.count-1 {
        if boards.count == board_index {
            _ := array_add(*boards);
        }

        // print("Line %\n", lines[it]);

        for split(lines[it], " ") {
            if trim(it).count == 0 {
                continue;
            }
            boards[board_index][row][col] = cast(s32) string_to_int(it);
            col += 1;
        }
        col = 0;
        row += 1;

        if row > 4 {
            board_index += 1;
            row = 0;
            it += 1; // Skip empty line
        }
    }

    // for board_index: 0..boards.count-1 {
    //     print("Board %\n", board_index);
    //     print("---\n");

    //     for row: 0..4 {
    //         for col: 0..4 {
    //             print("% ", boards[board_index][row][col]);
    //         }
    //         print("\n");
    //     }
    // }

    markers: [..][5][5]bool;
    for boards {
        _ := array_add(*markers);
    }

    // for board_index: 0..boards.count-1 {
    //     print("Board %\n", board_index);
    //     print("---\n");

    //     for row: 0..4 {
    //         for col: 0..4 {
    //             if markers[board_index][row][col] {
    //                 print("1 ",);
    //             } else {
    //                 print("0 ",);
    //             }
    //         }
    //         print("\n");
    //     }
    // }

    winning_boards: [..]s64;
    winning_numbers: [..]s32;

    for play_numbers {
        for board_index: 0..boards.count-1 {
            if array_find(winning_boards, board_index) continue;

            for row: 0..4 {
                for col: 0..4 {
                    if boards[board_index][row][col] == it {
                        markers[board_index][row][col] = true;
                    }
                }
            }
        }

        for board_index: 0..boards.count-1 {
            if array_find(winning_boards, board_index) continue;

            count := 0;
            for row: 0..4 {
                for col: 0..4 {
                    if markers[board_index][row][col] {
                        count += 1;
                    }
                }
                if count == 5 break;
                count = 0;
            }
            if count == 5 {
                array_add(*winning_boards, board_index);
                array_add(*winning_numbers, it);
                continue;
            }

            for col: 0..4 {
                for row: 0..4 {
                    if markers[board_index][row][col] {
                        count += 1;
                    }
                }
                if count == 5 break;
                count = 0;
            }
            if count == 5 {
                array_add(*winning_boards, board_index);
                array_add(*winning_numbers, it);
            }
        }

        // for board_index: 0..boards.count-1 {
        //     print("Board %\n", board_index);
        //     print("---\n");

        //     for row: 0..4 {
        //         for col: 0..4 {
        //             if markers[board_index][row][col] {
        //                 print("1 ",);
        //             } else {
        //                 print("0 ",);
        //             }
        //         }
        //         print("\n");
        //     }
        // }
        // print("\n\n");

        if winning_boards.count == boards.count break;
    }

    winning_board := winning_boards[winning_boards.count-1];
    winning_number := winning_numbers[winning_numbers.count-1];

    sum_unmarked := 0;
    for row: 0..4 {
        for col: 0..4 {
            if !markers[winning_board][row][col] {
                sum_unmarked += boards[winning_board][row][col];
            }
        }
    }

    print("Winning board: %\n", winning_board);
    print("Sum unmarked: %\n", sum_unmarked);
    print("Final played number: %\n", winning_number);
    print("Result: %\n", sum_unmarked * winning_number);
}