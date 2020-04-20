#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <pthread.h>
#include <semaphore.h>

//Global 
int number_element;           	  //number of elements in the file
int count = 0;
int input[1000005];    			  //input aray
int ar[1000005]; 
int arr[1000005]; 
int ans[1000005];
int start[15], end[15];
sem_t sem[15];

struct pool
{
    int worker_num;
    pthread_t thread[8];
};
struct Job
{
    int type;
    int id;
};

struct jlist
{
    struct Job job;
    struct jlist *next;
};

struct pool thread_pool;
struct jlist *head;
struct jlist *tail;

sem_t job_list_mutex;
sem_t mutex;
sem_t peace;
sem_t job_count;
sem_t bottom_level;
sem_t worker[8];

void append(struct Job );
void *MT_bubble_sort(void *thread_id);
void MERGE_PART(int );
void bubble_sort(int );
void MERGE_MERGE(int );

int main(void)
{
    int i, j, k;
    struct timeval stime, etime;
	double sec, usec;
	
    FILE *fp;
    char filename[100];

    printf("Please input the filename: ");
    scanf("%s", filename);

    fp = fopen(filename, "r");
    if(fp == NULL)
    {
        printf("Read file error\n");
        exit(0);
    }
    fscanf(fp, "%d", &number_element);
    for(i=0;i<number_element;i++) fscanf(fp, "%d", &input[i]);
    fclose(fp);
	
	//initialize
    sem_init(&job_list_mutex, 0, 1);
    sem_init(&mutex, 0, 0);
    sem_init(&peace, 0, 0);
    sem_post(&mutex);
    sem_init(&job_count, 0, 0);
    sem_init(&bottom_level, 0, 0);
	
    for(int i=0; i<8; i++) sem_init(&worker[i], 0, 0);
	
    thread_pool.worker_num = 1; //worker_num


    int tid[8];
    for( i=0; i<8; i++) 
    {
        tid[i] = i;
        pthread_create(&thread_pool.thread[i], NULL, MT_bubble_sort, (void*)(&tid[i]));
    }

    while(thread_pool.worker_num < 9)
    {
        gettimeofday(&stime, 0);
        //reset
        for(i=0; i<number_element; i++) ar[i] = input[i];
        for(int i=0; i<15; i++) sem_init(&sem[i], 0, 0);
        sem_post(&sem[0]);
        start[0] = 0;
        end[0] = number_element-1;
        sem_wait(&mutex);
        count = 0;
        sem_post(&mutex);
        sem_wait(&job_list_mutex);
        head = NULL;
        struct Job j;
        j.type = 0;
        j.id = 0;
        append(j);
        sem_post(&job_count);
        sem_post(&job_list_mutex);
        sem_post(&worker[thread_pool.worker_num-1]); //wake up a thread one time
        //reset_done
        sem_wait(&peace);
        gettimeofday(&etime, 0);
        sec = etime.tv_sec - stime.tv_sec;
        usec = etime.tv_usec - stime.tv_usec;
        printf("Time of %d Thread: %lf s\n",thread_pool.worker_num,sec+(double)usec/1000000);
        char filename[100];
        sprintf(filename, "output_%d.txt", thread_pool.worker_num);
        fp = fopen(filename, "w");
        for(int i=0; i<number_element; i++) fprintf(fp, "%d ", ans[i]);
        fclose(fp);
        thread_pool.worker_num++;
    }
    return 0;
}


void append(struct Job job) 
{
    if(head != NULL) 
    {
        struct jlist *j = (struct jlist *)malloc(sizeof(struct jlist));	
        j->job = job;
        j->next = NULL;
        tail->next = j; //head
        tail = tail->next;
    }
    else 
    {
        head = (struct jlist *)malloc(sizeof(struct jlist));		
        head->job = job;
        head->next = NULL;
        tail = head;
    }
}

void *MT_bubble_sort(void *thread_id) 
{
    int i, j, k;
    int tid = *((int *) thread_id);
    while(thread_pool.worker_num < 9) 
    {
        sem_wait(&worker[tid]);
        if(thread_pool.worker_num > 8)	break;
        sem_wait(&job_count);
        sem_wait(&job_list_mutex);
        struct jlist *tmp = head;
        struct Job job = head->job;
        head = head->next;
        free(tmp);
        sem_post(&job_list_mutex);
        if(job.type == 0) 
	    {
            sem_wait(&sem[job.id]);

            MERGE_PART(job.id);
            sem_wait(&job_list_mutex);

            struct Job j1, j2;
            j1.id = (2 * (job.id) + 1);
            j2.id = (2 * (job.id) + 2);
            if((2 * (job.id) + 1) > 6) j1.type = j2.type = 1;
            else j1.type = j2.type = 0;

            sem_post(&sem[(job.id*2)+1]);
            sem_post(&sem[(job.id*2)+2]);

            append(j1);
            append(j2);	
            sem_post(&job_count);
            sem_post(&job_count);	
            sem_post(&job_list_mutex);
        }
        else if(job.type == 1)
        {
            sem_wait(&sem[job.id]);
            bubble_sort(job.id);
            sem_wait(&mutex);
            count++;
            if(count == 8)
            {
                for(i=7;i<15;i++) sem_post(&sem[(i-1)/2]);//bottom_level
                sem_wait(&job_list_mutex);

                struct Job j;
                for(i=6;i>-1;i--)
                {
                	j.id = i;
                	j.type = 3;
                	append(j);
                	sem_post(&job_count);
                }		
                sem_post(&job_list_mutex);
            }
            sem_post(&mutex);			
        }
        else
        {
            sem_wait(&sem[job.id]);
            sem_wait(&sem[job.id]);
			
            MERGE_MERGE(job.id);

            if(job.id == 0) sem_post(&peace);
            else sem_post(&sem[(job.id-1)/2]);
        }
        sem_post(&worker[tid]);
    }
}

void MERGE_PART(int id) 
{
    int x, y;
    x = start[id];
    y = end[id];
    start[(2 * id) + 1] = start[id];
    end[(2 * id) + 1] = (x + y)/2;
    start[(2 * id) + 2] = (x + y)/2 + 1;
    end[(2 * id) + 2] = end[id];
}

void bubble_sort(int id) 
{
    int i, j;
    int x, y;
    x = start[id];
    y = end[id];

    int len = y-x+1;
    for(i=0; i<len; i++) {
        for(j=x; j<y-i; j++) {
            if(ar[j] > ar[j+1]) {
                ar[j] ^= ar[j+1] ^= ar[j] ^= ar[j+1];
            }
        }
    }
}

void MERGE_MERGE(int id)
{
    int i, j;
    int A_x, A_y, B_x, B_y;
    int ori_id, ori_x, ori_y, len;
    int A, B;

	
    A = (2 * id) + 1;
    B = (2 * id) + 2;
    A_x = start[A];
    A_y = end[A];
    B_x = start[B];
    B_y = end[B];

    ori_x = start[id];
    ori_y = end[id];

    len = ori_y - ori_x + 1;
    for(i=0;i<(len);i++)
    {
        if((ar[A_x] <= ar[B_x] ) && A_x <= A_y)
        {
            ans[ori_x + i] = ar[A_x];
            A_x++;
        }
        else if((ar[A_x] >= ar[B_x]  ) && B_x <= B_y)
        {
            ans[ori_x + i] = ar[B_x];
            B_x++;
        }
        else if(A_x > A_y)
        {
            ans[ori_x + i] = ar[B_x];
            B_x++;
        }
        else if(B_x > B_y)
        {
            ans[ori_x + i] = ar[A_x];
            A_x++;
        }
        else printf("A_x: %d A_y: %d B_x: %d B_y: %d \n", A_x, A_y, B_x, B_y);
    }
	for(i=ori_x;i<ori_y+1;i++) ar[i] = ans[i];
}