# Lab2
## Overview
### Matrix multiplication using multiple processes
- Basic parallel processing
- Will be faster on multicore machines

### Input: the dimension of two square matrices A & B
- E.g., 100 -> A, B, and C are 100x100 square matrices

### Output: an execution time and a checksum

## Shared Memory
- Matrices A, B, and C are stored in a shared memory
- No locking/synchronization is required since multiplication on sub-metrics are mutually independent

## APIs
### shmget()
- int shmget(key_t key, size_t size, int shmflg);

### shmat()
- void *shmat(int shmid, const void *shmaddr, int shmflg);

### shmdt()
- int shmdt(const void *shmaddr);

### shmctl()
- int shmctl(int shmid, int cmd, struct shmid_ds *buf);

