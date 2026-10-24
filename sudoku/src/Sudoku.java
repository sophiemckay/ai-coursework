import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Sudoku {
    public static void main(String[] args) throws Exception {
        
        int[][] grid = new int [9][9]; // initialise 9x9 grid
        File puzzle = new File("puzzle.txt"); // initialise the file 
        
        // if the file is found...
        try {
            Scanner scanner = new Scanner(puzzle);

            // input the values from the file into a 2D array
            for (int row = 0; row < 9; row++) {
                for (int col = 0; col < 9; col++){
                    grid[row][col] = scanner.nextInt();
                }
            }
        
        // stop scanning the file
        scanner.close();
        }

        // if the file cannot be found
        catch (FileNotFoundException e){
            System.err.println("File not found.");
            return;
        }
    
        // displays the grid with borders
        for (int row = 0; row < 9; row ++){
            if (row == 3 || row == 6){
                System.out.println("-------+--------+-------");
            }
            for (int col = 0; col < 9; col++){
                if (col == 3 || col == 6){
                    System.out.print(" | ");
                }
                System.out.print(grid[row][col]+ " ");
            }
            System.out.println("");
        }
    } 
}