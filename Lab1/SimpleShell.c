#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<sys/types.h>
#include<unistd.h>
#include<sys/wait.h>

int main(void)
{
    int i, j, k;
    char str[100];
    char *word[100];
    char *pipe_ar[100];
    char *token;

    ////////flag!!!!!
    int flag_and;
    int flag_redir;
    int flag_pipe;


    //////file address
    char *open_file;



    //count pipe
    int pipe_num;

    for(;;)
    {
        printf(">");
        memset(str,sizeof(str),0);
        flag_and = flag_redir = flag_pipe = pipe_num = 0;
        fgets(str,sizeof(str),stdin);
        for(i=0;i<100;i++) word[i] = NULL;
        for(i=0;i<100;i++) pipe_ar[i] = NULL;
        if(strcmp(str,"\n") == 0) continue;
        token = strtok(str,"\n ");    
        for(i=0;token != NULL;i++)
        {
            word[i] = token;
            token = strtok(NULL,"\n ");
        }

        

        for(i=0;i<99 && (word[i] != NULL);i++)
        {
            if(word[i] == NULL) break;
            else if(!strcmp(word[i], "&")) flag_and = 1;
            else if(!strcmp(word[i], "|")) flag_pipe = 1;
            else if(flag_pipe) pipe_ar[pipe_num++] = word[i];
            else if(!strcmp(word[i], ">"))
            {
                flag_redir = 1;
                open_file = word[i+1];
                word[i] = NULL;
                continue;
            }
            if(!strcmp(word[i], "&") || !strcmp(word[i], "|")) word[i] = NULL;
        }
        if(!strcmp(word[0], "exit")) exit(0);
        if(!strcmp(word[0], "cd"))
        {
            if(chdir(word[1]) < 0) perror(word[1]);
            continue;
        }

        int  child = fork();

        if(child < 0) //error
        {
            perror("child (fork) has the error\n");
            exit(-1);
        }

        if(child != 0)
        {
            wait(NULL); //parent
        }
        if(child == 0) //child
        {
            if(!strcmp(word[0], "cd")) 
            {
                execv(word[0], word);
            }
            if(flag_redir) // >
            {
                FILE *fp = fopen(open_file, "w");
                dup2(fileno(fp), STDOUT_FILENO);
                fclose(fp);
            }

            if(!flag_and && !flag_pipe) execvp(word[0], word);
            if(flag_and)
            {
                int grand_kid = fork();
                if(grand_kid < 0)
                {
                    perror("grandkid (fork) has the error\n");
                    exit(-1);
                }
                if(grand_kid != 0) return 0;
                if(grand_kid == 0) execvp(word[0], word);
            }
            if(flag_pipe)
            {
                int filedes[2];
                int grand_kid;
                
                if(pipe(filedes))
                {
                    perror("Pipe fail.\n");
                    exit(-1);
                }
                
                grand_kid = fork();
   
                if(grand_kid == 0)
                {
                    //this is the child process. close other end first
                    close(filedes[0]);
                    dup2(filedes[1], 1);    
                    close(filedes[1]);
                    execvp(word[0], word);
                }
                else if(grand_kid < 0)
                {
                    perror("FORK fail.\n");
                    exit(-1);
                }
                else if(grand_kid > 0 && flag_pipe == 1)
                {
                    wait(NULL);

                    if(!flag_pipe) continue;
                    close(filedes[1]);
                    dup2(filedes[0], 0);
                    close(filedes[0]);
                    execvp(pipe_ar[0], pipe_ar);
                }
            }
        }
    }
    return 0;
} 
