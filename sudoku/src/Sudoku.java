import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Sudoku {
    public static void main(String[] args) throws Exception {
        
        int[][] grid = new int [9][9]; // initialise 9x9 grid
        File puzzle = new File("puzzle.txt");

        System.out.println("Looking here: " + puzzle.getAbsolutePath());
        System.out.println("Does it exist? " + puzzle.exists());
        
        try {
            Scanner scanner = new Scanner(puzzle);

            for (int row = 0; row < 9; row++) {
                for (int col = 0; col < 9; col++){
                    grid[row][col] = scanner.nextInt();
                }
            }
        
        scanner.close();
        }

        catch (FileNotFoundException e){
            System.err.println("File not found.");
            return;
        }

        for (int i = 0; i < 9; i++) {
            for (int x = 0; x < 9; x++){
               System.err.println(grid[i][x] + "");
            }
            System.out.println("");
        }
     } 
    }