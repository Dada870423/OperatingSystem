# Lab4 Merge Sort with a Thread Pool
## Overview
- Multithreaded sorting using a thread pool
  - threads in the pool determines the max. degree of parallelism
- This lab is the same as that in the previous assignment, except that the binding of jobs to threads is dynamic.

## Procedure
1. Read data from the input file “input.txt”
2. n=1
3. Do the sorting with a thread pool of n threads
4. Print the execution time
5. Write the sorted array to a file
    - Filename: output_n.txt (e.g., output_3.txt if n=3)
6. n++; if n<=8 then goto 3

## Format
### Input: A one dimension array (unsorted)
- Largest input: 1,000,000 integers
- All integers separated by space

### Output:  A one dimension array (sorted)
- sorted integers separated by space
