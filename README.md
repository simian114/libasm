# LIBASM
-----

### 1. How to compile?
```
  Linux
    - nasm -f elf64 file.s -o file.o
  Mac
    - nasm -f macho64 file.s -o file.o
  
  이후의 라이브러리로 만드는 작업은 libft와 동일
```
-----
### 2. ft_read

ft_read를 구현하기 위해서 위해서는 시스템콜을 직접 호출해야한다.  
호출하는 방법은 rax 레지스터에 sys_read의 번호를 넣고 syscall을 호출해야한다.  
생각해보면 read 함수는 read(int fd, void \*buf, size_t count)의 형태고 이런 인자들이 들어가야 하는데 
위에서 처럼 rax 레지스터에 sys_read의 번호만 넣고 호출하면 인자는 어떻게 넘겨주는걸까?
(https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64) 이 주소를 확인해보면
sys_read의 인자로 rdi, rsi, rdx로 들어가는 걸 확인할 수 있다.
즉, syscall 을 호출하기 전에 먼저 rdi, rsi, rdx에 fd, buf, count를 지정해야한다.
하지만 내 코드를 보면
```
    mov rax, 0  
    syscall  
    ret  
```  
 고작 이 세줄이 끝인데? 대체 이 코드 어디에서 sys_read의 인자로 들어가는 rdi, rsi, rdx를 지정해준거지?  
 이에 대한 해답에 앞서 우리는 c로 만들어진 main문에서 ft_read를 함수로써 사용한다는 것을 인지해야한다.  
 즉, 아래와 같다.
``` 
  int main()  
  {  
      
      char buf[10];  
      ft_read(0, buf, 10);  
  }  
```
위의 코드를 보면 ft_read의 인자로 3개의 값을 전달해 준다. 이 인자들은 차례대로 rdi, rsi, rdx의 레지스터로 전달된다.  
이 내용은 calling convention을 확인하면 된다. convention에 따르면 함수로 들어간 인자는 차례대로 rdi,rsi, rdx, r10, r8, r9  
레지스터로 전달된다고 한다. 결과적으로 우리가 구현한 ft_read는 아래처럼 작동한다.
```
  rdi = 0, rsi = buf, rdx = 10
  sys_read(0, buf, 10)
```
에러처리는 마지막에 서술.

-----
### 2. ft_write
write는 read와 완전 동일하다.

-----
### 3. ft_strlen
먼저 함수를 assembly로 구현하기에 앞서 c언어로 구현된 코드를 다시 확인해보자.
```
size_t         ft_strlen(char *s)
{
       size_t  i;

       i = 0;
       while (s[i])
               i++;
       return (i);
}
```
여기서 알 수 있는건 인자로 들어오는 char \*s는 rdi 레지스터에 담길거라는 것이다.  
그리고 각각의 인자가 NULL이랑 비교되면서 만약 널이면 반복이 끝나고 return된다.  
따라서 인덱스로 사용할 레지스터를 하나 정하고 0으로 초기화 해준다.  
```
  xor rax, rax
```
여기서 rax를 0으로 초기화 해주는데 xor 명령어를 사용했다. mov rax, 0으로 해도 되지만  
디버거를 돌려보니깐 컴파일러도 이렇게 하길래 이렇게 했다.  
이제 반복문을 시작해야한다. 반복을 수행할 함수 strlen_loop를 새롭게 만든다.  
이제 문자열 s에 담겨있는 값들을 널 값과 하나씩 비교해 줘야한다.  
char \*s 가 가리키는 문자열에서 하나의 문자들은 char 형이고 char형은 1 Byte다.  
인자로 들어온 문자열은 rdi 레지스터에 담겨져 있다. 즉 rdi 레지스터는 ***pointer***이다.  
만약
```
  cmp [rdi + rax], 0
```
이런 식으로 코딩을 하면 ***&s[idx]*** 와 0을 비교하는것과 같다. 즉 포인터와 0을 비교하는거니까 말이 안된다.  
우리가 해야하는건 ***s[idx]*** 와 0을 비교하는거니깐 여기서 하나의 바이트를 의미하는 명령어를 앞에 붙여서  
```
  cmp byte [rdi + rax], 0
```
이렇게 해야한다.  
그리고 값이 널이라면 반복을 끝내고 함수를 종료한다. 아니라면 인덱스 값을 증가시키고 다시 반복한다.  

-----
### 4. ft_strcmp
```
  int            ft_strcmp(char *s1, char *s2)
  {
         int i;
  
         i = 0;
         while (s1[i] && s1[i] == s2[i])
                 i++;
         return (s1[i] - s2[i]);
  }
```
ft_strlen와 비슷하게 값들을 레지스터로 1바이트 형식으로 넣고 비교하면 된다. 여기서 dl과 dh를 이해해야하는데  
rcx = 64bit --> ecx = 32bit --> cx = 16bit --> ch = cl == 8bit 이렇게 된다.  
strcmp는 한 바이트 씩을 비교하는거니깐 바이트 하나씩을 따와서 이렇게 비교해준다.  
내가 해결하지 못한거는 이 dl과 dh의 뺸 결과과 rax에 담겨야 하는데 옮기지를 못하겠다.. 그래서 그냥 -1, 0, 1로 만들었다.

-----
### 5. ft_strcpy
이 함수는 매우 간단하다. 그냥 rsi를 1바이트씩 NULL과 비교한다. 만약 널이 아니라면 rdi에 대입하고 인덱스를 증가시킨다.  
만약 rsi가 NULL이라면 rdi에 NULL넣고 ret한다.

-----
### 6. ft_strdup
이 함수를 어셈블리 만으로 구현하기는 너무 복잡하고 길어진다. 따라서 앞에서 구현한 함수들을 이용해서 구현하자.  
```
  char   *ft_strdup(char *s)
  {
         int             len;
         char    *ret;
  
         len = (int)ft_strlen(s);
         ret = malloc(sizeof(char) * (len + 1));
         if (ret == 0)
                 return (0);
         ft_strlcpy(ret, s, len + 1);
         return (ret);
  }
```
위의 코드는 c언어로 구현한 ft_strdup다. 이걸보면 어떻게 어셈블리로 구현할지 딱 감이 온다.  
1. src의 길이(len)을 구한다.
2. len + 1 만큼의 공간을 할당 받는다.
3. 만약 malloc 의 return 값이 NULL 이라면 0을 return한다.
4. 마지막으로 src의 데이터를 dest에 복사한다.  
먼저 이 함수는 외부 함수를 사용하므로 외부 함수를 어떻게 사용하는지 먼저 알아야한다.  
외부 함수를 사용하기 위해서는 간단히 extern funcname 이렇게 하면 된다.  
libasm.h 헤더에 이미 원형을 정의해 놓았기 때문에 컴파일 단계에서 알아서 링크가 된다.  
이후에는 각 함수를 사용하기에 앞서 각 레지스터들의 값을 잘 초기화하고 순서대로 함수 호출하면 끝이다.

-----
### Bonus 1.ft_list_push_front  
우선 이 함수는 피신을 기준으로 만들어야 하기 때문에 c언어 코드를 먼저 작성해보겠다.
```
  void   ft_list_push_front(t_list **list, void *data)
  {
        t_list *new; 

        new= malloc(sizeof(t_list));
        if (new == 0)
                return ;
        new->content = data;
        new->next = *list;
        *list = node;
  }
  
  int main(void)
  {
        t_list *head;
        t_list *temp;
        
        head = 0;
        ft_list_push_front(&head, "123");
        ft_list_push_front(&head, "456");
        ft_list_push_front(&head, "789");
        temp = head;
        while (temp)
        {
              printf("[%s]", (char *)temp->content);
              if (temp->next)
                    printf(" -> ");
        }
  }
```
***이 함수는 void 형태이므로 return value가 없다. 처음에 인자로 들어왔던 rdi의 주소 공간을 계속 갖고 있어야 한다.***  
함수를 시작하면 바로 malloc을 사용해야 하므로 인자로 들어온 rdi(t_list \*\*list), rsi(void \*data)를 저장하자.
malloc을 하기 위해서는 리스트 구조체의 사이즈를 알아야한다. 간단하게 main에서 sizeof(t_list)을 하면 된다.
결과 16이 나왔으므로 malloc(16)을 하자. 그리고 malloc fail을 체크하자. 아래가 이제부터 중요.  
> 1. rax 에는 새로 할당받은 16의 공간이 있다.  
> 2. rax[0] ~ rax[7] 까지는 data를 위한 공간, rax[8] ~ rax[15] 까지는 next 포인터를 위한 공간이다.  
> 3. push 해 놓은 rdi와, rsi을 pop하자. (push, pop하면 push 했던 상태 그대로 pop 된다.)  
> 4. mov [rax], rsi ; node->content = data(rsi)  
> 5. mov rcx, [rdi] ; t_list \*temp = 0;  
> 6. mov [rax + 8], rcx ; node->next = 0;  
> 7. mov [rdi], rax ; \*list = node == head = node  

디버거로 rax의 값을 계속 추적하면 알게되는게 참 많은거 같다. 디버거 활용을 잘하자!  

-----
### Bonus 2.ft_list_size

우서 C코드.
```
  int ft_list_size(t_list *begin_list)
  {
         int             ret;
  
         ret = 0;
         while (begin_list)
         {
                 ret++;
                 begin_list = begin_list->next;
         }
         return (ret);
  }
```  
C코드가 간단한 만큼 어셈블리로도 간단하다. 너무 간단해서 별로 할 말은 없지만...  
주의해야할건
```
  node = node->next
```  
이 부분일듯.  
```
  mov rsi, [rsi + 8]
```
이런식으로 현재 노드를 가리키고 있는 레지스터에 next가 위치한 곳의 값을 넣어주면 된다.  

-----
## Errno(Linux)
pdf에 각 에러에 따른 errno를 설정하라고 한다. \_\_\_error 함수를 사용하면 된다고 한다.  
하지만 언더바를 세개쓴 error은 컴파일 자체가 안된다. 언더바를 두 개 쓰니깐 라이브러리는 만들어 졌다.  
만들어진 라이브러리로 실행파일을 만들면 이상하게 오류가 뜬다. 그래서 gdb 디버거를 돌려보니깐  
error 함수를 호출할 때 마다 \_\_errno\_location 함수가 호출이 되었다. 이 함수에 대해서 알아보니  
```
  int *__errno_location(void)
```
이런 원형을 갖고 있었다. 뭔가 저 errno_location 함수가 가리키고 있는 int 가 errno거라는 느낌이 딱 와와서  
pdf에서 사용하라고 한 \_\_\_error 함수 말고 \_\_error\_location을 사용하기로 했다.  
하지만 이 함수를 사용해도 errno가 적절하게 세팅이 되지 않았다.  
아래와 같이 첫 번째 ft_read는 옳지 않은 fd를 넣어봤고 두 번째에는 옳지 않은 buf를 넣어줬다.  
이렇게 했을 때 a, b는 -1로 세팅이 되어야하고 errno는 각각이 9, 14로 세팅이 되어야 한다.  
(errno 번호 보려면 sudo apt-get install error하고 errno -l 입력하면 쫘르륵 뜬다.)
```
  1 ____ int a = ft_read(fault, buf, 10);
  2 ____ int b = ft_read(0, fault, 10);
```
이 결과는 a = -9, b = -14 였다. 그리고 errno는 0으로 값이 변경되지 않았다.  
어쨋든 ft_read의 return 값 자체. 즉 sys_read는 함수 호출을 실패하면 errno * -1 값을 return 한다는 것을 알았다.  
그리고 디버거를 계속 돌려본 결과
```
  call __errno_location
```
을 호출하면 rax 값에 errno의 포인터가 저장이 된다는 것을 알았다.  
이제 필요한 정보들은 다 알았으니 총 정리해보면 아래와 같다.    

> sys_read가 실패하면 ***rax*** 에는 ***errno * -1*** 값이 담긴다.  
> 따라서 syscall 이후 ***cmp rax, 0***으로 만약 rax 값이 0 보다 작다면 err 처리로 jump  
> 이제 음수인 rax의 값을 양수로 바꿔주기 위해 ***neg rax***  
> call \_\_errno\_location 호출 전에 rax 값을 스택에 저장. ***push rax***  
> ***call __errno_location***으로 ***rax에 errno pointer*** 저장  
> 아까 스택에 저장해 놓은 값을 ***rax 가 가리키고 있는 errno pointer 에 저장 pop qword [rax]***  
>> 여기서 중요한 것은 ***rax***는 ***int형 pointer*** 따라서 ***8바이트***의 값. 사이즈를 맞춰주기 위해 ***qword***를 써준다.  
> 그리고 ft_read가 실패하면 ret 값은 -1 이므로 ***mov rax, -1***

-----
## Mac
errno를 다 구현하고 클러스터 ssh 환경에서 실행을 해보니깐 그냥 컴파일 자체가 안된다....  
리눅스랑 freebsd(Mac) 계열에 차이가 조금 있어서인데, 먼저 함수들을 선언할 때 \_ft\_ead 와 같이 함수 이름 앞에  
언더바를 붙여야한다. 그리고 syscall이 실패했을 경우에 차이가 조금 있었다.

## Errno(Mac)
일단 리눅스와 비교를 해보면 Mac에서는 pdf에서 사용하라고 한 \_\_\_error 함수를 사용하는게 맞다.  
그리고 syscall이 실패했을 경우 linux에서는 ***errno * -1*** rax에 들어오지만  
freebsd계열은 rax에 바로 errno가 들어온다. (알아본 결과 모든 시스템 콜이 이렇게 되는건 아니라고 한다.)  
어쨋은 리눅스에서 neg rax 를 지워주고 \_\_errno\_handling 함수 대신 \_\_\_error 함수를 이용하면 끝!
