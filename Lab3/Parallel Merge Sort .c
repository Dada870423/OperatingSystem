#include<stdio.h>
#include<pthread.h>
#include<semaphore.h>
#include<sys/wait.h>
#include<sys/time.h>
#include<stdlib.h>


//Global 
int number_element;           	  //number of elements in the file
int ar[1000005];    			  //input array
int arr[1000005]; 
int ans[1000005];
int count = 0;
int start[15], end[15];
sem_t sem[15], multi_bubble_sort_done, multi_all_done;
sem_t single_start, single_all_done;

void single_thread(void);
void *ST_sort();
void MERGE_PART(int );
void bubble_sort(int ); 
void MERGE_MERGE(int );

void multi_thread(void);
void *MT_bubble_sort(void *thread_id);
void *MT_sort(void *thread_id);


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
    fscanf(fp, "%d", &number_element);
    for(i=0;i<number_element;i++) fscanf(fp, "%d", &ar[i]);
    fclose(fp);
	
    for(int i=0; i<15; i++) sem_init(&sem[i], 0, 0);
    
    gettimeofday(&stime, 0);
    single_thread();
    sem_wait(&single_all_done);	
    gettimeofday(&etime, 0);

    sec = etime.tv_sec - stime.tv_sec;
    usec = etime.tv_usec - stime.tv_usec;

    printf("ST: %lf ms\n\n\n\n\n\n", sec*1000+(usec/1000.0));

    fp = fopen("output2.txt", "w");
    for(int i=0; i<number_element; i++) fprintf(fp, "%d \n", arr[i]);
	
    fclose(fp);

    for(int i=0; i<15; i++) sem_init(&sem[i], 0, 0);
	

    sem_post(&sem[0]);
    gettimeofday(&stime, 0);
    multi_thread();
    sem_wait(&multi_all_done);	
    gettimeofday(&etime, 0);

    sec = etime.tv_sec - stime.tv_sec;
    usec = etime.tv_usec - stime.tv_usec;
    printf("MT: %lf ms\n", sec*1000+(usec/1000.0));

    fp = fopen("output1.txt", "w");
    for(int i=0; i<number_element; i++) fprintf(fp, "%d \n", arr[i]);
	
    fclose(fp);	
}


void multi_thread(void) 
{
    int i;
    int areg[15];
    for(i=0; i<15; i++) areg[i] = i;

    for(i=0; i<number_element; i++) arr[i] = ar[i];

    sem_init(&multi_bubble_sort_done, 0, 0);
    sem_init(&multi_all_done, 0, 0);
	
    start[0] = 0;
    end[0] = number_element-1;
    pthread_t thread[16];
	
	
    for(i=7; i<15; i++) pthread_create(&thread[i], NULL, MT_bubble_sort, (void*)(&areg[i]));

    for(i=6; i>-1; i--) pthread_create(&thread[i], NULL, MT_sort, (void*)(&areg[i]));
}

void *MT_sort(void *thread_id) 
{
    int id = *(int*)thread_id;

    sem_wait(&sem[id]);

    int ii;
    for(ii=0;ii<7;ii++) MERGE_PART(ii);

    sem_post(&sem[(id*2)+1]);
    sem_post(&sem[(id*2)+2]);
    sem_wait(&sem[id]);
    sem_wait(&sem[id]);

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
        if((arr[A_x] <= arr[B_x] ) && A_x <= A_y)
        {
            ans[ori_x + i] = arr[A_x];
            A_x++;
        }
        else if((arr[A_x] >= arr[B_x]  ) && B_x <= B_y)
        {
            ans[ori_x + i] = arr[B_x];
            B_x++;
        }
        else if(A_x > A_y)
        {
            ans[ori_x + i] = arr[B_x];
            B_x++;
        }
        else if(B_x > B_y)
        {
            ans[ori_x + i] = arr[A_x];
            A_x++;
        }
        else 
        {
            printf("A_x: %d A_y: %d B_x: %d B_y: %d \n", A_x, A_y, B_x, B_y);
            printf("fuck error!!!\n");
        }
    }
    for(i=ori_x;i<ori_y+1;i++) arr[i] = ans[i];

    if(id == 0) sem_post(&multi_all_done);
    else sem_post(&sem[(id-1)/2]);
}

void *MT_bubble_sort(void *thread_id) 
{
    int id = *(int*)thread_id;
    sem_wait(&sem[id]);
    int i, j;
    int x, y;
	
    x = start[id];
    y = end[id];

    int len = y-x+1;
    for(i=0; i<len; i++) {
        for(j=x; j<y-i; j++) {
            if(arr[j] > arr[j+1]) {
                arr[j] ^= arr[j+1] ^= arr[j] ^= arr[j+1];
            }
        }
    }
    sem_post(&sem[(id-1)/2]);
}

void single_thread() 
{
    int i;
    for(i=0; i<number_element; i++) arr[i] = ar[i];
	
    sem_init(&single_start, 0, 0);
    sem_init(&single_all_done, 0, 0);
    pthread_t threade;
    pthread_create(&threade, NULL, ST_sort, NULL);

    for(i=0;i<15;i++) start[i] = 0;
    for(i=0;i<15;i++) end[i] = number_element-1;
    sem_post(&single_start);
}

void *ST_sort() 
{
    int i;
    sem_wait(&single_start);

    for(i=0;i<7;i++) MERGE_PART(i);
    for(i=7;i<15;i++) bubble_sort(i);
    for(i=14;i>0;i=i-2) MERGE_MERGE(i);
    sem_post(&single_all_done);
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
            if(arr[j] > arr[j+1]) {
                arr[j] ^= arr[j+1] ^= arr[j] ^= arr[j+1];
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
    ori_id = (id - 1)/2;
	
    A = id-1;
    B = id;

    A_x = start[A];
    A_y = end[A];
    B_x = start[B];
    B_y = end[B];

    ori_x = start[ori_id];
    ori_y = end[ori_id];

    len = ori_y - ori_x + 1;
    for(i=0;i<(len);i++)
    {
        if((arr[A_x] <= arr[B_x] ) && A_x <= A_y)
        {
            ans[ori_x + i] = arr[A_x];
            A_x++;
        }
        else if((arr[A_x] >= arr[B_x]  ) && B_x <= B_y)
        {
            ans[ori_x + i] = arr[B_x];
            B_x++;
        }
        else if(A_x > A_y)
        {
            ans[ori_x + i] = arr[B_x];
            B_x++;
        }
        else if(B_x > B_y)
        {
        	ans[ori_x + i] = arr[A_x];
            A_x++;
        }
        else 
        {
            printf("A_x: %d A_y: %d B_x: %d B_y: %d \n", A_x, A_y, B_x, B_y);
            printf("fuck error!!!\n");
        }
    }
    for(i=ori_x;i<ori_y+1;i++) arr[i] = ans[i];
}
