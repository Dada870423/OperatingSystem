#include <unistd.h>
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <string.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <sys/time.h>



struct node
{
    unsigned  int matrix[800][800];
};
struct ans
{
    unsigned  int ar[800];
};

struct node *A; //= (struct node *) malloc(sizeof(struct node));
struct node *B; //= (struct node *) malloc(sizeof(struct node));
struct ans *C; //= (struct ans *) malloc(sizeof(struct ans));

int main(void)
{
    int siz;
    int shmid_A, shmid_B, shmid_C; //share memory id
    int i, j, k, m, n;
    int pid;
    int now;
    int times;
    int process;
    int one_time;
    int sec, usec;
    unsigned int check;
    struct timeval begin;
    struct timeval terminal;

    printf("Input the dimensions of your matrix: ");
    scanf("%d", &siz);
    A = (struct node *) malloc(sizeof(struct node));
    B = (struct node *) malloc(sizeof(struct node));
    C = (struct ans *) malloc(sizeof(struct ans));

    shmid_A = shmget(0, sizeof(struct node) , IPC_CREAT|0600);
    shmid_B = shmget(0, sizeof(struct node) , IPC_CREAT|0600);
    shmid_C = shmget(0, sizeof(struct ans), IPC_CREAT|0600);

    A = (struct node *) shmat(shmid_A, NULL, 0);
    B = (struct node *) shmat(shmid_B, NULL, 0);
    C = (struct ans *) shmat(shmid_C, NULL, 0);
	
    k=0;
    for(i=0;i<siz;i++)
    {
        for(j=0;j<siz;j++) 
        {
            A->matrix[i][j] = k;
            B->matrix[i][j] = k++;
        }
				
        C->ar[i] = 0;
    }
	
    for(times=1;times<17;times++)
    {
        check = 0;
        one_time = siz / times;
        now=-1;
        gettimeofday(&begin, 0);
        for(i=0;i<siz;i++) C->ar[i] = 0;
        for(process=1;process<times+1;process++)
        {
            now = one_time * (process - 1);
            pid = fork();
            if(pid<0)
            {
                printf("error!!!!!!!!\n");
                exit(-1);
            }
            else if(pid>0) continue;
            else if(pid==0) //child
            {
                if(process < times)
                {
                    for(j=now;j<one_time+now;j++)
                    {
                        for(k=0;k<siz;k++)
                        {
                            for(m=0;m<siz;m++)
                            {
                                C->ar[j] += A->matrix[j][k] * B->matrix[k][m];
                            }
                        }
                    }
                }
                if(process == times)
                {
                    for(j=now;j<siz;j++)
                    {
                        for(k=0;k<siz;k++)
                        {
                            for(m=0;m<siz;m++)
                            {
                                C->ar[j] += A->matrix[j][k] * B->matrix[k][m];
                            }
                        }
                    }
                }
                exit(0);
            }
        }
        for(i=0;i<times;i++) wait(NULL);
        for(i=0;i<siz;i++) check += C->ar[i];
        gettimeofday(&terminal, 0);
        sec = terminal.tv_sec - begin.tv_sec;
        usec = terminal.tv_usec - begin.tv_usec;
        printf("Multiplying matrices using %d processes\n", times);
        printf("Elapsed time: %f sec, Checksum: %u\n", (sec*1000 + (usec / 1000.0)), check);
    }
    return 0;
}