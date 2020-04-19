# Lab3 Parallel Merge Sort using Pthread
## Overview

### Divide
1. T1: the master thread. Divides the array into two equal sub-arrays
2. Signals T2 and T3 (via semaphores) to sort the two sub-arrays
3. Waits on T2 and T3 (via semaphores)
4. Merges the two sorted sub-arrays
5. Generate an output file

### Conquer
T8~T15:
1. Do bubble sort on their own sub-arrays
2. Signal their upper-level threads (via semaphores)

## Format
### Input: A one dimension array (unsorted)
- Largest input: 1,000,000 integers
- All integers separated by space

### Output:  A one dimension array (sorted)
- sorted integers separated by space


## Pthread
### Goal & Require
- Comparing the single & multithread (Pthread)
- The singlethreaded version should be noticeably slower than the multithreaded version

### APIs
#### pthread.h
- Pthread_create, pthread_exit
- Do not use pthread_join, use semaphore instead

### semaphore.h
- sem_init, sem_wait, sem_post, sem_getvalue, sem_destroy


